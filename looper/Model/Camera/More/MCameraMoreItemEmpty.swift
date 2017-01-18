import UIKit

class MCameraMoreItemEmpty:MCameraMoreItem
{
    init(cellHeight:CGFloat)
    {
        let reusableIdentifier:String = VCameraMoreCellEmpty.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:cellHeight)
    }
}
