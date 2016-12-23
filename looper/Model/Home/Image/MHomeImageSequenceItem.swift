import UIKit
import MetalKit

class MHomeImageSequenceItem
{
    let image:UIImage
    var texture:MTLTexture?
    
    init(image:UIImage)
    {
        self.image = image
    }
    
    //MARK: public
    
    func createTexture(
        textureLoader:MTKTextureLoader)
    {
        if texture == nil
        {
            guard
            
                let cgImage:CGImage = image.cgImage
            
            else
            {
                return
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
            }
        }
    }
}
