import UIKit
import Metal

class MHomeImageSequenceItem
{
    let image:UIImage
    var texture:MTLTexture?
    
    init(image:UIImage)
    {
        self.image = image
    }
}
