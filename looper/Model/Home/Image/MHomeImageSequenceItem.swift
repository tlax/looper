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
    
    func createTexture()
    {
        let texture:MTLTexture?
        let textureLoader:MTKTextureLoader = MTKTextureLoader(device:device)
        
        let options:[String:NSObject] = [
            MTKTextureLoaderOptionTextureUsage:MTLTextureUsage.shaderRead.rawValue as NSObject,
            MTKTextureLoaderOptionSRGB:true as NSObject
        ]
        
        do
        {
            mtlTexture = try mtkTextureLoader.newTexture(with:cgImage, options:options)
        }
        catch
        {
            mtlTexture = nil
        }
    }
}
