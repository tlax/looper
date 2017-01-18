import UIKit

class MHelpItemCameraReady:MHelpItem
{
    override init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetHelpCameraReady")
        let title:String = NSLocalizedString("MHelpItemCameraReady_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
    
    override init(image:UIImage, title:String)
    {
        fatalError()
    }
}
