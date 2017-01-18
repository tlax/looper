import UIKit

class MHelpItemCompress:MHelpItem
{
    override init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetHelpCompress")
        let title:String = NSLocalizedString("MHelpItemCompress_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
    
    override init(image:UIImage, title:String)
    {
        fatalError()
    }
}
