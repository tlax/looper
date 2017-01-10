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
    let originZero:MTLOrigin
    let sizeOfFloat:Int
    
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
        originZero = MTLOriginMake(0, 0, 0)
        sizeOfFloat = MemoryLayout.size(ofValue:kRepeatingElement)
        
        self.device = device
        self.mtlLibrary = mtlLibrary
    }
    
    //MARK: public
    
    func createBlankTexure() -> MTLTexture
    {
        let textureDescriptor:MTLTextureDescriptor = MTLTextureDescriptor.texture2DDescriptor(
            pixelFormat:kTextureDefaultPixelFormat,
            width:Int(MCamera.kImageMaxSize),
            height:Int(MCamera.kImageMaxSize),
            mipmapped:kTextureMipMapped)
        
        let newTexture:MTLTexture = device.makeTexture(
            descriptor:textureDescriptor)
        
        return newTexture
    }
    
    func createBlankTexure(
        pixelFormat:MTLPixelFormat,
        width:Int,
        height:Int) -> MTLTexture
    {
        let textureDescriptor:MTLTextureDescriptor = MTLTextureDescriptor.texture2DDescriptor(
            pixelFormat:pixelFormat,
            width:width,
            height:height,
            mipmapped:kTextureMipMapped)
        
        let newTexture:MTLTexture = device.makeTexture(
            descriptor:textureDescriptor)
        
        return newTexture
    }
    
    func createMutableTexture(texture:MTLTexture) -> MTLTexture
    {
        let width:Int = texture.width
        let height:Int = texture.height
        let baseTexture:MTLTexture = createBlankTexure(
            pixelFormat:texture.pixelFormat,
            width:width,
            height:height)
        
        let originZero:MTLOrigin = MTLOriginMake(0, 0, 0)
        let textureBuffer:MTLCommandBuffer = commandQueue.makeCommandBuffer()
        let size:MTLSize = MTLSizeMake(
            width,
            height,
            kTextureDepth)
        let blitEncoder:MTLBlitCommandEncoder = textureBuffer.makeBlitCommandEncoder()
        
        blitEncoder.copy(
            from:texture,
            sourceSlice:0,
            sourceLevel:0,
            sourceOrigin:originZero,
            sourceSize:size,
            to:baseTexture,
            destinationSlice:0,
            destinationLevel:0,
            destinationOrigin:originZero)
        blitEncoder.endEncoding()
        
        textureBuffer.commit()
        textureBuffer.waitUntilCompleted()
        
        return baseTexture
    }
    
    func createMappingTexture(
        textureWidth:Int,
        textureHeight:Int,
        mapMinX:Int,
        mapMinY:Int,
        mapMaxX:Int,
        mapMaxY:Int) -> MTLTexture
    {
        let textureMatrixSize:Int = textureWidth * textureHeight
        var textureArray:[Float] = Array(
            repeating:kRepeatingElement,
            count:textureMatrixSize)
        let bytesPerRow:Int = sizeOfFloat * textureWidth
        let region:MTLRegion = MTLRegionMake2D(
            0,
            0,
            textureWidth,
            textureHeight)
        
        let mapTexture:MTLTexture = createBlankTexure(
            pixelFormat:kMapTexturePixelFormat,
            width:textureWidth,
            height:textureHeight)
        
        for indexVr:Int in mapMinY ..< mapMaxY
        {
            let currentRow:Int = textureWidth * indexVr
            
            for indexHr:Int in mapMinX ..< mapMaxX
            {
                let pixelIndex:Int = currentRow + indexHr
                textureArray[pixelIndex] = kReplaceElement
            }
        }
        
        let bytes:UnsafeRawPointer = UnsafeRawPointer(textureArray)
        mapTexture.replace(
            region:region,
            mipmapLevel:0,
            withBytes:bytes,
            bytesPerRow:bytesPerRow)
        
        return mapTexture
    }
    
    func texturize(image:UIImage) -> MTLTexture?
    {
        let texture:MTLTexture?
        
        guard
            
            let cgImage:CGImage = image.cgImage
            
        else
        {
            return nil
        }
        
        do
        {
            texture = try textureLoader.newTexture(
                with:cgImage,
                options:[
                    MTKTextureLoaderOptionTextureUsage:
                        MTLTextureUsage.shaderRead.rawValue as NSObject,
                    MTKTextureLoaderOptionSRGB:
                        true as NSObject
                ])
        }
        catch
        {
            texture = nil
        }
        
        return texture
    }
    
    func texturizeAt(
        image:UIImage,
        textureWidth:Int,
        textureHeight:Int,
        imageX:Int,
        imageY:Int,
        imageWidth:Int,
        imageHeight:Int) -> MTLTexture?
    {
        let canvasSize:CGSize = CGSize(
            width:textureWidth,
            height:textureHeight)
        let drawingRect:CGRect = CGRect(
            x:imageX,
            y:imageY,
            width:imageWidth,
            height:imageHeight)
        
        UIGraphicsBeginImageContext(canvasSize)
        image.draw(in:drawingRect)
        
        guard
            
            let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
            
        else
        {
            UIGraphicsEndImageContext()
            
            return nil
        }
        
        UIGraphicsEndImageContext()
        
        let texture:MTLTexture? = texturize(image:newImage)
        
        return texture
    }
}
