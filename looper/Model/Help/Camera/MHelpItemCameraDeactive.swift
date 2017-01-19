import UIKit

class MHelpItemCameraDeactive:MHelpItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetHelpCameraDeactive")
        let title:String = NSLocalizedString("MHelpItemCameraDeactive_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
}
