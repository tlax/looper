import UIKit

class MCameraFilterItemCoolBlue:MCameraFilterItem
{
    override init()
    {
        let title:String = NSLocalizedString("MCameraFilterItemCoolBlue_title", comment:"")
        let image:UIImage = #imageLiteral(resourceName: "assetFilterSimple")
        
        super.init(title:title, image:image)
    }
    
    override init(title:String, image:UIImage)
    {
        fatalError()
    }
    
    override func processController() -> CController?
    {
        let controller:CCameraFilterNone = CCameraFilterNone(model:self)
        
        return controller
    }
}
