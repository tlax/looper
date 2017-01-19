import UIKit

class MHelpItemBlenderBase:MHelpItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetHelpCameraCapture")
        let title:String = NSLocalizedString("MHelpItemBlenderBase_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
}
