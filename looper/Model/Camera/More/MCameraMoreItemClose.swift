import UIKit

class MCameraMoreItemClose:MCameraMoreItem
{
    private let kCellHeight:CGFloat = 60
    
    override init(record:MCameraRecordEditable)
    {
        let reusableIdentifier:String = VCameraMoreCellClose.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
    
    override init(reusableIdentifier:String, cellHeight:CGFloat)
    {
        fatalError()
    }
}
