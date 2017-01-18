import UIKit

class MCameraFilterItemCoolBlue:MCameraFilterItem
{
    init()
    {
        let title:String = NSLocalizedString("MCameraFilterItemCoolBlue_title", comment:"")
        let viewTitle:String = NSLocalizedString("MCameraFilterItemCoolBlue_viewTitle", comment:"")
        let image:UIImage = #imageLiteral(resourceName: "assetFilterCoolBlue")
        
        super.init(title:title, viewTitle:viewTitle, image:image)
    }
}
