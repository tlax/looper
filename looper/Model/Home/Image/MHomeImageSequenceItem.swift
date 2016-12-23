import UIKit
import MetalKit

class MHomeImageSequenceItem
{
    let image:UIImage
    
    init(image:UIImage)
    {
        self.image = image
    }
    
    //MARK: private
    
    private func texturize(
        image:UIImage,
        textureLoader:MTKTextureLoader) -> MTLTexture?
    {
        let texture:MTLTexture?
        
        guard
            
            let cgImage:CGImage = image.cgImage
            
        else
        {
            texture = nil
            
            return texture
        }
        
        do
        {
            texture = try textureLoader.newTexture(
                with:cgImage,
                options:[
                    MTKTextureLoaderOptionTextureUsage:MTLTextureUsage.shaderRead.rawValue as NSObject,
                    MTKTextureLoaderOptionSRGB:true as NSObject
                ])
        }
        catch
        {
            texture = nil
        }
        
        return texture
    }
    
    //MARK: public
    
    func createTexture(
        point:MHomeImageSequenceRawPoint,
        textureWidth:CGFloat,
        textureHeight:CGFloat,
        textureLoader:MTKTextureLoader) -> MTLTexture?
    {
        let canvasSize:CGSize = CGSize(
            width:textureWidth,
            height:textureHeight)
        let pointCenterX:CGFloat = point.percentPosX * textureWidth
        let pointCenterY:CGFloat = point.percentPosY * textureHeight
        let drawingRadius:CGFloat = point.percentRadius * textureWidth
        let drawingRadius2:CGFloat = drawingRadius + drawingRadius
        let drawingX:CGFloat = pointCenterX - drawingRadius
        let drawingY:CGFloat = pointCenterY - drawingRadius
        let drawingRect:CGRect = CGRect(
            x:drawingX,
            y:drawingY,
            width:drawingRadius2,
            height:drawingRadius2)

        UIGraphicsBeginImageContext(canvasSize)
        image.draw(in:drawingRect)
        
        guard
            
            let overlayedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
            
        else
        {
            UIGraphicsEndImageContext()
            
            return nil
        }
        
        UIGraphicsEndImageContext()
        
        let texture:MTLTexture? = texturize(
            image:overlayedImage,
            textureLoader:textureLoader)
        
        return texture
    }
    
    func createTexture(
        textureLoader:MTKTextureLoader) -> MTLTexture?
    {
        let texture:MTLTexture? = texturize(
            image:image,
            textureLoader:textureLoader)
        
        return texture
    }
}
