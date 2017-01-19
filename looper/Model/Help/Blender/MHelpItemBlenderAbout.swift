import UIKit

class MHelpItemBlenderAbout:MHelpItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetHelpHelpBlenderAbout")
        let title:String = NSLocalizedString("MHelpItemBlenderAbout_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
}
