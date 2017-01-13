import UIKit

class MCameraMoreItemEmpty:MCameraMoreItem
{
    init(cellHeight:CGFloat)
    {
        let reusableIdentifier:String = VCameraMoreCellInfo.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:cellHeight)
    }
    
    override init(reusableIdentifier:String, cellHeight:CGFloat)
    {
        fatalError()
    }
    
    override init(record:MCameraRecordEditable)
    {
        fatalError()
    }
}
