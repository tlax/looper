import UIKit

class MHelpItemCameraDeactive:MHelpItem
{
    override init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetHelpCameraDeactive")
        let title:String = NSLocalizedString("MHelpItemCameraDeactive_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
    
    override init(image:UIImage, title:String)
    {
        fatalError()
    }
}
