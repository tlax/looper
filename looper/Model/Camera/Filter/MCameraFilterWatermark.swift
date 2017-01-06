import UIKit
import MetalKit

class MCameraFilterWatermark
{
    private let device:MTLDevice
    private let commandQueue:MTLCommandQueue
    private let mtlFunction:MTLFunction
    private let textureLoader:MTKTextureLoader
    private let kMetalBlenderFunctionName:String = "metalFilter_blender"
    private let kMapTexturePixelFormat:MTLPixelFormat = MTLPixelFormat.r32Float
    private let kTextureDefaultPixelFormat:MTLPixelFormat = MTLPixelFormat.bgra8Unorm
    private let kTextureMipMapped:Bool = false
    private let kTextureDepth:Int = 1
    private let kRepeatingElement:Float = 0
    private let kReplaceElement:Float = 1
    
    init(title:String, image:UIImage)
    {
        self.title = title
        self.image = image
    }
    
    init()
    {
        fatalError()
    }
    
    //MARK: public
    
    func processController() -> CController?
    {
        return nil
    }
    
    func waterMark(original:MCameraRecord) -> MCameraRecord
    {
        guard
            
            let noWatermark:Bool = MSession.sharedInstance.settings?.noWatermark
            
            else
        {
            return original
        }
        
        let markedRecord:MCameraRecord
        
        if noWatermark
        {
            markedRecord = original
        }
        else
        {
            markedRecord = MCameraRecord()
            
            if self.device == nil
            {
                self.device = MTLCreateSystemDefaultDevice()
            }
            
            guard
                
                let device:MTLDevice = self.device
                
                else
            {
                return markedRecord
            }
            
            renderedSequence = MHomeImageSequenceGenerated(
                device:device,
                main:mainSequence,
                sequences:blendingSequences,
                length:longestSequence)
        }
        
        return markedRecord
    }
}
