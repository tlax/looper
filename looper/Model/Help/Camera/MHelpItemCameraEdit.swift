import UIKit

class MHelpItemCameraEdit:MHelpItem
{
    override init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetHelpCameraEdit")
        let title:String = NSLocalizedString("MHelpItemCameraEdit_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
    
    override init(image:UIImage, title:String)
    {
        fatalError()
    }
}
