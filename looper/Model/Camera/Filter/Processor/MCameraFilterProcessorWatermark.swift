import Foundation
import MetalKit

class MCameraFilterProcessorWatermark:MCameraFilterProcessor
{
    private var mtlFunction:MTLFunction!
    private let kMetalFunctionName:String = "metalFilter_blender"
    
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
            
            let baseWidth:CGFloat = CGFloat(mutableTexture.width)
            let baseHeight:CGFloat = CGFloat(mutableTexture.height)
            
        }
        
        return marked
    }
    
    
    
    
    private func blendOverTexture(
        baseTexture:MTLTexture,
        index:Int,
        sequences:[MHomeImageSequenceRaw])
    {
        let baseWidth:CGFloat = CGFloat(baseTexture.width)
        let baseHeight:CGFloat = CGFloat(baseTexture.height)
        
        for sequence:MHomeImageSequenceRaw in sequences
        {
            let countSequenceItem:Int = sequence.items.count
            
            if countSequenceItem > index
            {
                guard
                    
                    let point:MHomeImageSequenceRawPoint = sequence.point
                    
                    else
                {
                    continue
                }
                
                if point.mapTexture == nil
                {
                    point.mapTexture = mapTexture(
                        texture:baseTexture,
                        point:point)
                }
                
                let sequenceItem:MHomeImageSequenceItem = sequence.items[index]
                
                guard
                    
                    let overTexture:MTLTexture = sequenceItem.createTexture(
                        point:point,
                        textureWidth:baseWidth,
                        textureHeight:baseHeight,
                        textureLoader:textureLoader),
                    let mapTexture:MTLTexture = point.mapTexture
                    
                    else
                {
                    continue
                }
                
                let commandBuffer:MTLCommandBuffer = commandQueue.makeCommandBuffer()
                let metalFilter:MetalFilter = MetalFilter(device:device)
                metalFilter.render(
                    mtlFunction:mtlFunction,
                    commandBuffer:commandBuffer,
                    overlayTexture:overTexture,
                    baseTexture:baseTexture,
                    mapTexture:mapTexture)
                
                commandBuffer.commit()
                commandBuffer.waitUntilCompleted()
            }
        }
        
        guard
            
            let textureImage:UIImage = baseTexture.exportImage()
            
            else
        {
            return
        }
        
        let finalItem:MHomeImageSequenceItem = MHomeImageSequenceItem(
            image:textureImage)
        items.append(finalItem)
    }
}
