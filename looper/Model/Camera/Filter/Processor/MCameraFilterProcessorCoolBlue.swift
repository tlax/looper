import Foundation
import MetalKit

class MCameraFilterProcessorCoolBlue:MCameraFilterProcessor
{
    private var mtlFunction:MTLFunction!
    private let kMetalFunctionName:String = "metalFilter_blender"
    private let kBlenderMinLength:Int = 1
    
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
    
    func blend(
        filterSelectedItem:MCameraFilterSelectorItem,
        overlays:[MCameraFilterItemBlendOverlay]) -> MCameraRecord
    {
        let blended:MCameraRecord = MCameraRecord()
        let baseRecord:MCameraRecord?
        let color:UIColor?
        let length:Int
        
        if let selectedRecord:MCameraFilterSelectorItemRecord = filterSelectedItem as? MCameraFilterSelectorItemRecord
        {
            baseRecord = selectedRecord.record
            color = nil
        }
        else if let selectedColor:MCameraFilterSelectorItemColor = filterSelectedItem as? MCameraFilterSelectorItemColor
        {
            baseRecord = nil
            color = selectedColor.color
        }
        else
        {
            baseRecord = nil
            color = nil
        }
        
        if let baseRecord:MCameraRecord = baseRecord
        {
            length = baseRecord.items.count
        }
        else
        {
            var minLength:Int?
            
            for overlay:MCameraFilterItemBlendOverlay in overlays
            {
                let overlayLength:Int = overlay.record.items.count
                
                if minLength == nil
                {
                    minLength = overlayLength
                }
                else
                {
                    if overlayLength < minLength!
                    {
                        minLength = overlayLength
                    }
                }
            }
            
            if let minLength:Int = minLength
            {
                length = minLength
            }
            else
            {
                length = kBlenderMinLength
            }
        }
        
        for indexItem:Int in 0 ..< length
        {
            let baseTexture:MTLTexture
            
            if let baseRecord:MCameraRecord = baseRecord
            {
                let item:MCameraRecordItem = baseRecord.items[indexItem]
                let itemImage:UIImage = item.image
                
                guard
                    
                    let itemTexture:MTLTexture = texturize(image:itemImage)
                    
                    else
                {
                    continue
                }
                
                baseTexture = createMutableTexture(texture:itemTexture)
            }
            else if let color:UIColor = color
            {
                let textureSize:Int = Int(MCamera.kImageMaxSize)
                
                guard
                    
                    let colorTexture:MTLTexture = createColorTexture(
                        color:color,
                        width:textureSize,
                        height:textureSize)
                    
                    else
                {
                    continue
                }
                
                baseTexture = createMutableTexture(texture:colorTexture)
            }
            else
            {
                baseTexture = createBlankTexure()
            }
            
            let baseWidth:Int = baseTexture.width
            let baseHeight:Int = baseTexture.height
            let baseMax:Int = baseWidth - 1
            let baseSize:CGFloat = CGFloat(baseWidth)
            
            for overlay:MCameraFilterItemBlendOverlay in overlays
            {
                let recordOverlay:MCameraRecord = overlay.record
                let countItemsRecord:Int = recordOverlay.items.count
                
                if indexItem >= countItemsRecord
                {
                    continue
                }
                
                let itemOverlay:MCameraRecordItem = recordOverlay.items[indexItem]
                let imageOverlay:UIImage = itemOverlay.image
                let overlaySize:Int = Int(overlay.percentSize * baseSize)
                let overlayMinX:Int = Int(overlay.percentPosX * baseSize)
                let overlayMinY:Int = Int(overlay.percentPosY * baseSize)
                let mapMinX:Int
                var mapMaxX:Int
                let mapMinY:Int
                var mapMaxY:Int
                
                if overlayMinX < 0
                {
                    mapMinX = 0
                }
                else if overlayMinX <= baseMax
                {
                    mapMinX = overlayMinX
                }
                else
                {
                    mapMinX = baseMax
                }
                
                if overlayMinY < 0
                {
                    mapMinY = 0
                }
                else if overlayMinY <= baseMax
                {
                    mapMinY = overlayMinY
                }
                else
                {
                    mapMinY = baseMax
                }
                
                mapMaxX = overlayMinX + overlaySize
                mapMaxY = overlayMinY + overlaySize
                
                if mapMaxX > baseMax
                {
                    mapMaxX = baseMax
                }
                
                if mapMaxY > baseMax
                {
                    mapMaxY = baseMax
                }
                
                let mappingTexture:MTLTexture = createMappingTexture(
                    textureWidth:baseWidth,
                    textureHeight:baseHeight,
                    mapMinX:mapMinX,
                    mapMinY:mapMinY,
                    mapMaxX:mapMaxX,
                    mapMaxY:mapMaxY)
                
                guard
                    
                    let overlayTexture:MTLTexture = texturizeAt(
                        image:imageOverlay,
                        textureWidth:baseWidth,
                        textureHeight:baseHeight,
                        imageX:overlayMinX,
                        imageY:overlayMinY,
                        imageWidth:overlaySize,
                        imageHeight:overlaySize)
                    
                    else
                {
                    continue
                }
                
                let commandBuffer:MTLCommandBuffer = commandQueue.makeCommandBuffer()
                
                guard
                    
                    let metalFilter:MetalFilterBlender = MetalFilterBlender(
                        device:device,
                        mtlFunction:mtlFunction,
                        commandBuffer:commandBuffer,
                        width:baseWidth,
                        height:baseHeight)
                    
                    else
                {
                    continue
                }
                
                metalFilter.render(
                    overlayTexture:overlayTexture,
                    baseTexture:baseTexture,
                    mapTexture:mappingTexture)
                
                commandBuffer.commit()
                commandBuffer.waitUntilCompleted()
            }
            
            guard
                
                let blendedImage:UIImage = baseTexture.exportImage()
                
                else
            {
                continue
            }
            
            let blendedItem:MCameraRecordItem = MCameraRecordItem(
                image:blendedImage)
            blended.items.append(blendedItem)
        }
        
        return blended
    }
}
