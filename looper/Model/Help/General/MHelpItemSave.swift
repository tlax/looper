import UIKit

class MHelpItemSave:MHelpItem
{
    override init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetHelpSave")
        let title:String = NSLocalizedString("MHelpItemSave_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
}
