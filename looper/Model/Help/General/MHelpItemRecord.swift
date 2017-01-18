import UIKit

class MHelpItemRecord:MHelpItem
{
    override init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetHelpRecord")
        let title:String = NSLocalizedString("MHelpItemRecord_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
}
