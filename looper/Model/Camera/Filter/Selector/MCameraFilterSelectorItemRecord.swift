import Foundation

class MCameraFilterSelectorItemRecord:MCameraFilterSelectorItem
{
    weak var record:MCameraRecord!
    
    init(record:MCameraRecord)
    {
        let reusableIdentifier:String = VCameraFilterSelectorCellRecord.reusableIdentifier
        self.record = record
        
        super.init(reusableIdentifier:reusableIdentifier)
    }
}
