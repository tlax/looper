import UIKit

class MHelpItemCameraEdit:MHelpItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetHelpCameraEdit")
        let title:String = NSLocalizedString("MHelpItemCameraEdit_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
}
