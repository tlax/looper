import UIKit

class MHelpItemBlenderDrag:MHelpItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetHelpCameraCapture")
        let title:String = NSLocalizedString("MHelpItemBlenderDrag_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
}
