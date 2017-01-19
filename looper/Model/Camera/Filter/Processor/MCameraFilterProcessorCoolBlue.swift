import Foundation
import MetalKit

class MCameraFilterProcessorCoolBlue:MCameraFilterProcessor
{
    private var mtlFunction:MTLFunction!
    private let kMetalFunctionName:String = "metalFilter_coolBlue"
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
    
    func cool(record:MCameraRecord) -> MCameraRecord
    {
        let cooled:MCameraRecord = MCameraRecord()
        
        for item:MCameraRecordItem in record.items
        {
            let itemImage:UIImage = item.image
            
            guard
                
                let itemTexture:MTLTexture = texturize(image:itemImage)
            
            else
            {
                continue
            }
            
            let sourceTexture:MTLTexture = createMutableTexture(
                texture:itemTexture)
            
            let commandBuffer:MTLCommandBuffer = commandQueue.makeCommandBuffer()
            let metalFilter:MetalFilterCoolBlue = MetalFilterCoolBlue(
                device:device,
                commandBuffer:commandBuffer)
            metalFilter.render(sourceTexture:sourceTexture)
            commandBuffer.commit()
            commandBuffer.waitUntilCompleted()
            
            guard
                
                let cooledImage:UIImage = sourceTexture.exportImage()
                
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
