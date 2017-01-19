import UIKit

class MHelpItemCameraActive:MHelpItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetHelpCameraActive")
        let title:String = NSLocalizedString("MHelpItemCameraActive_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
}
