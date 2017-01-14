import UIKit

class MCameraMore
{
    let items:[MCameraMoreItem]
    private let kEmptyActions:CGFloat = 30
    
    init(record:MCameraRecordEditable)
    {
        let itemClose:MCameraMoreItemClose = MCameraMoreItemClose(record:record)
        let itemInfoFrames:MCameraMoreItemInfoFrames = MCameraMoreItemInfoFrames(record:record)
        let itemInfoSize:MCameraMoreItemInfoSize = MCameraMoreItemInfoSize(record:record)
        let itemInfoSpeed:MCameraMoreItemInfoSpeed = MCameraMoreItemInfoSpeed(record:record)
        let itemEmptyActions:MCameraMoreItemEmpty = MCameraMoreItemEmpty(cellHeight:kEmptyActions)
        let itemActions:MCameraMoreItemActions = MCameraMoreItemActions(record:record)
        
        items = [
            itemClose,
            itemInfoFrames,
            itemInfoSize,
            itemInfoSpeed,
            itemEmptyActions,
            itemActions
        ]
    }
}
