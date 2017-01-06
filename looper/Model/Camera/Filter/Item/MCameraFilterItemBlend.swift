import UIKit

class MCameraFilterItemBlend:MCameraFilterItem
{
    override init()
    {
        let title:String = NSLocalizedString("MCameraFilterItemBlend_title", comment:"")
        let image:UIImage = #imageLiteral(resourceName: "assetCameraFilterBlend")
        
        super.init(title:title, image:image)
    }
    
    override init(title:String, image:UIImage)
    {
        fatalError()
    }
}
