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
        textureLoader:MTKTextureLoader,
        textureOptions:[String:NSObject])
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
                    options:textureOptions)
            }
            catch
            {
            }
        }
    }
}
