import Foundation
import MetalKit

class MCameraFilterProcessorWatermark:MCameraFilterProcessor
{
    private var mtlFunction:MTLFunction!
    private let kMetalFunctionName:String = "metalFilter_watermark"
    
    override init?()
    {
        super.init()
        
        guard
            
            let mtlFunction:MTLFunction = mtlLibrary.makeFunction(name:kMetalFunctionName)
            
        else
        {
            return nil
        }
        
        self.mtlFunction = mtlFunction
    }
    
    //MARK: public
    
    func addWatermark(original:MCameraRecord) -> MCameraRecord
    {
        let marked:MCameraRecord = MCameraRecord()
        let imageWater:UIImage = #imageLiteral(resourceName: "assetGenericWaterMark")
        let waterWidth:Int = Int(imageWater.size.width)
        let waterHeight:Int = Int(imageWater.size.height)
        
        guard
        
            let firstImage:UIImage = original.items.first?.image
        
        else
        {
            return marked
        }
        
        let textureWidth:Int = Int(firstImage.size.width)
        let textureHeight:Int = Int(firstImage.size.height)
        var mapMinX:Int = textureWidth - waterWidth
        var mapMinY:Int = textureHeight - waterHeight
        
        if mapMinX < 0
        {
            mapMinX = 0
        }
        
        if mapMinY < 0
        {
            mapMinY = 0
        }
        
        var mapMaxX:Int = mapMinX + waterWidth
        
        if mapMaxX > textureWidth
        {
            mapMaxX = textureWidth
        }
        
        var mapMaxY:Int = mapMinY + waterHeight
        
        if mapMaxY > textureHeight
        {
            mapMaxY = textureHeight
        }
        
        guard
            
            let overlayTexture:MTLTexture = texturizeAt(
                image:imageWater,
                textureWidth:textureWidth,
                textureHeight:textureHeight,
                imageX:mapMinX,
                imageY:mapMinY,
                imageWidth:waterWidth,
                imageHeight:waterHeight)
            
        else
        {
            return marked
        }        
        
        for item:MCameraRecordItem in original.items
        {
            let itemImage:UIImage = item.image
            
            guard
            
                let texture:MTLTexture = texturize(image:itemImage)
            
            else
            {
                continue
            }
            
            let mutableTexture:MTLTexture = createMutableTexture(texture:texture)
            
            let mappingTexture:MTLTexture = createMappingTexture(
                textureWidth:textureWidth,
                textureHeight:textureHeight,
                mapMinX:mapMinX,
                mapMinY:mapMinY,
                mapMaxX:mapMaxX,
                mapMaxY:mapMaxY)
            
            let commandBuffer:MTLCommandBuffer = commandQueue.makeCommandBuffer()
            let metalFilter:MetalFilterWatermark = MetalFilterWatermark(device:device)
            metalFilter.render(
                mtlFunction:mtlFunction,
                commandBuffer:commandBuffer,
                overlayTexture:overlayTexture,
                baseTexture:mutableTexture,
                mapTexture:mappingTexture)
            
            commandBuffer.commit()
            commandBuffer.waitUntilCompleted()
            
            guard
            
                let wateredImage:UIImage = mutableTexture.exportImage()
            
            else
            {
                continue
            }
            
            let wateredItem:MCameraRecordItem = MCameraRecordItem(
                image:wateredImage)
            marked.items.append(wateredItem)
        }
        
        return marked
    }
}
