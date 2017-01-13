import UIKit

class MCameraMoreItemActions:MCameraMoreItem
{
    let options:[MCameraMoreItemActionsOption]
    private let kCellHeight:CGFloat = 100
    
    override init(record:MCameraRecordEditable)
    {
        let reusableIdentifier:String = VCameraMoreCellActions.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
    
    override init(reusableIdentifier:String, cellHeight:CGFloat)
    {
        fatalError()
    }
}
