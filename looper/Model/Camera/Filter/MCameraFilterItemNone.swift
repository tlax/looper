import UIKit

class MCameraFilterItemNone:MCameraFilterItem
{
    override init()
    {
        let title:String = NSLocalizedString("MCameraFilterItemNone_title", comment:"")
        let image:UIImage = #imageLiteral(resourceName: "assetCameraFilterNone")
        
        super.init(title:title, image:image)
    }
    
    override init(title:String, image:UIImage)
    {
        fatalError()
    }
    
    override func processController(model:MCamera) -> CController?
    {
        let controller:CCameraFilterNone = CCameraFilterNone(model:model)
        
        return controller
    }
}
