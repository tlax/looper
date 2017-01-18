import UIKit

class MCameraFilterSelectorItemColor:MCameraFilterSelectorItem
{
    let color:UIColor
    
    init(color:UIColor)
    {
        let reusableIdentifier:String = VCameraFilterSelectorCellColor.reusableIdentifier
        self.color = color
        
        super.init(reusableIdentifier:reusableIdentifier)
    }
}
