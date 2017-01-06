import UIKit
import MetalKit

class MCameraFilterWatermark
{
    private let device:MTLDevice
    private let commandQueue:MTLCommandQueue
    private let mtlFunction:MTLFunction
    private let textureLoader:MTKTextureLoader
    private let kMetalFunctionName:String = "metalFilter_blender"
    private let kMapTexturePixelFormat:MTLPixelFormat = MTLPixelFormat.r32Float
    private let kTextureDefaultPixelFormat:MTLPixelFormat = MTLPixelFormat.bgra8Unorm
    private let kTextureMipMapped:Bool = false
    private let kTextureDepth:Int = 1
    private let kRepeatingElement:Float = 0
    private let kReplaceElement:Float = 1
    
    init?()
    {
        guard
        
            let device:MTLDevice = MTLCreateSystemDefaultDevice(),
            let mtlLibrary:MTLLibrary = device.newDefaultLibrary(),
            let mtlFunction:MTLFunction = mtlLibrary.makeFunction(name:kMetalFunctionName)
        
        else
        {
            return nil
        }
        
        commandQueue = device.makeCommandQueue()
        textureLoader = MTKTextureLoader(device:device)
        self.device = device
        self.mtlFunction = mtlFunction
    }
}
