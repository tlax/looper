import UIKit
import MetalKit

class MCameraRecordItem
{
    let image:UIImage
    var active:Bool
    
    init(image:UIImage)
    {
        active = true
        self.image = image
    }
}
