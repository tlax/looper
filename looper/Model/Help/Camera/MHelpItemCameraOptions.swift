import UIKit

class MHelpItemCameraOptions:MHelpItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetHelpCameraOptions")
        let title:String = NSLocalizedString("MHelpItemCameraOptions_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
}
