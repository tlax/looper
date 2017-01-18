import UIKit

class MHelpItemCameraMore:MHelpItem
{
    override init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetHelpCameraMore")
        let title:String = NSLocalizedString("MHelpItemCameraMore_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
    
    override init(image:UIImage, title:String)
    {
        fatalError()
    }
}
