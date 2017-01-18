import UIKit

class MCameraFilterSelectorItemColor:MCameraFilterSelectorItem
{
    let color:UIColor
    private let kCellWidth:CGFloat = 80
    
    init(color:UIColor)
    {
        let reusableIdentifier:String = VCameraFilterSelectorCellColor.reusableIdentifier
        self.color = color
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellWidth:kCellWidth)
    }
}
