import UIKit
import MetalKit

class MCameraFilterProcessor
{
    let device:MTLDevice
    let mtlLibrary:MTLLibrary
    let commandQueue:MTLCommandQueue
    let textureLoader:MTKTextureLoader
    let kMapTexturePixelFormat:MTLPixelFormat = MTLPixelFormat.r32Float
    let kTextureDefaultPixelFormat:MTLPixelFormat = MTLPixelFormat.bgra8Unorm
    let kTextureMipMapped:Bool = false
    let kTextureDepth:Int = 1
    let kRepeatingElement:Float = 0
    let kReplaceElement:Float = 1
    
    init?()
    {
        guard
            
            let device:MTLDevice = MTLCreateSystemDefaultDevice(),
            let mtlLibrary:MTLLibrary = device.newDefaultLibrary()
            
        else
        {
            return nil
        }
        
        commandQueue = device.makeCommandQueue()
        textureLoader = MTKTextureLoader(device:device)
        self.device = device
        self.mtlLibrary = mtlLibrary
    }
}
