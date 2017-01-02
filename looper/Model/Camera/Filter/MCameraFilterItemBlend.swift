import UIKit

class MCameraFilterItemBlend:MCameraFilterItem
{
    override init()
    {
        let title:String = NSLocalizedString("MCameraFilterItemBlend_title", comment:"")
        let image:UIImage = #imageLiteral(resourceName: "assetCameraFilterNone")
        
        super.init(title:title, image:image)
    }
    
    override init(title:String, image:UIImage)
    {
        fatalError()
    }
}
