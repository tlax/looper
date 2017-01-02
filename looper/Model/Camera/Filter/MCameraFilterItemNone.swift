import UIKit

class MCameraFilterItemNone:MCameraFilterItem
{
    override init()
    {
        let title:String = NSLocalizedString("MCameraFilterItemNone_title", comment:"")
        let image:UIImage = #imageLiteral(resourceName: "assetSpinner4")
        
        super.init(title:title, image:image)
    }
    
    override init(title:String, image:UIImage)
    {
        fatalError()
    }
}
