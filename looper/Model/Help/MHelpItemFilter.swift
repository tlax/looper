import UIKit

class MHelpItemFilter:MHelpItem
{
    override init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetHelpRecord")
        let title:String = NSLocalizedString("MHelpItemFilter_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
    
    override init(image:UIImage, title:String)
    {
        fatalError()
    }
}
