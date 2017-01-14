import UIKit

class MCameraMoreItemInfo:MCameraMoreItem
{
    let attributedString:NSAttributedString
    private let kCellHeight:CGFloat = 40
    
    init(attributedString:NSAttributedString)
    {
        self.attributedString = attributedString
        let reusableIdentifier:String = VCameraMoreCellInfo.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
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
