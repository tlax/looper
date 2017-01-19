import UIKit

class MHelpItemCameraReady:MHelpItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetHelpCameraReady")
        let title:String = NSLocalizedString("MHelpItemCameraReady_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
}
