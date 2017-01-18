import UIKit

class MHelpItemCameraCapture:MHelpItem
{
    override init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetHelpCameraCapture")
        let title:String = NSLocalizedString("MHelpItemCameraCapture_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
    
    override init(image:UIImage, title:String)
    {
        fatalError()
    }
}
