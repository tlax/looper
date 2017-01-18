import UIKit

class MHelpItemCompress:MHelpItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetHelpCompress")
        let title:String = NSLocalizedString("MHelpItemCompress_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
}
