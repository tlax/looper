import UIKit

class MCameraFilterSelectorItemRecord:MCameraFilterSelectorItem
{
    weak var record:MCameraRecord!
    private let kCellWidth:CGFloat = 144
    
    init(record:MCameraRecord)
    {
        let reusableIdentifier:String = VCameraFilterSelectorCellRecord.reusableIdentifier
        self.record = record
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellWidth:kCellWidth)
    }
}
