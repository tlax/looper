import UIKit

class MHelpItemFilter:MHelpItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetHelpFilter")
        let title:String = NSLocalizedString("MHelpItemFilter_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
}
