import UIKit
import MetalKit

class MHomeImageSequenceItem
{
    let image:UIImage
    
    init(image:UIImage)
    {
        self.image = image
    }
    
    //MARK: public
    
    func createTexture(
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
}
