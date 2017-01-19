import UIKit

class MHelpItemBlenderSelect:MHelpItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetHelpCameraCapture")
        let title:String = NSLocalizedString("MHelpItemBlenderSelect_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
}
