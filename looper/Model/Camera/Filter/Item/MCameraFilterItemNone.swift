import UIKit

class MCameraFilterItemNone:MCameraFilterItem
{
    override init()
    {
        let title:String = NSLocalizedString("MCameraFilterItemNone_title", comment:"")
        let image:UIImage = #imageLiteral(resourceName: "assetFilterSimple")
        
        super.init(title:title, image:image)
    }
    
    override func processController() -> CController?
    {
        let controller:CCameraFilterNone = CCameraFilterNone(model:self)
        
        return controller
    }
}
