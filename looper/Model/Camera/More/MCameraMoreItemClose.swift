import UIKit

class MCameraMoreItemClose:MCameraMoreItem
{
    private let kCellHeight:CGFloat = 60
    
    init()
    {
        let reusableIdentifier:String = VCameraMoreCellClose.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
