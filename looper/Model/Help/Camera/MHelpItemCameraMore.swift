import UIKit

class MHelpItemCameraMore:MHelpItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetHelpCameraMore")
        let title:String = NSLocalizedString("MHelpItemCameraMore_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
}
