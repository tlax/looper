import UIKit

class MCameraFilterItemNone:MCameraFilterItem
{
    init()
    {
        let title:String = NSLocalizedString("MCameraFilterItemNone_title", comment:"")
        let viewTitle:String = NSLocalizedString("MCameraFilterItemNone_viewTitle", comment:"")
        let image:UIImage = #imageLiteral(resourceName: "assetFilterSimple")
        
        super.init(title:title, viewTitle:viewTitle, image:image)
    }
    
    override func processController() -> CController?
    {
        let controller:CCameraFilterNone = CCameraFilterNone(model:self)
        
        return controller
    }
}
