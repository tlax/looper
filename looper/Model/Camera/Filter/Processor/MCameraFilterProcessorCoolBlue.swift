import Foundation
import MetalKit

class MCameraFilterProcessorCoolBlue:MCameraFilterProcessor
{    
    //MARK: public
    
    func cool(record:MCameraRecord) -> MCameraRecord
    {
        let cooled:MCameraRecord = MCameraRecord()
        
        for item:MCameraRecordItem in record.items
        {
            let itemImage:UIImage = item.image
            
            guard
                
                let sourceTexture:MTLTexture = texturize(image:itemImage)
            
            else
            {
                continue
            }
            
            let destinationTexture:MTLTexture = createBlankTexure(
                pixelFormat:sourceTexture.pixelFormat,
                width:sourceTexture.width,
                height:sourceTexture.height)
            
            let commandBuffer:MTLCommandBuffer = commandQueue.makeCommandBuffer()
            let metalFilter:MetalFilterCoolBlue = MetalFilterCoolBlue(
                device:device,
                commandBuffer:commandBuffer)
            
            metalFilter.render(
                sourceTexture:sourceTexture,
                destinationTexture:destinationTexture)
            
            commandBuffer.commit()
            commandBuffer.waitUntilCompleted()
            
            guard
                
                let cooledImage:UIImage = destinationTexture.exportImage()
                
            else
            {
                continue
            }
            
            let cooledItem:MCameraRecordItem = MCameraRecordItem(
                image:cooledImage)
            cooled.items.append(cooledItem)
        }
        
        return cooled
    }
}
