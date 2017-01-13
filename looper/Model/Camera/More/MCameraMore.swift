import UIKit

class MCameraMore
{
    let items:[MCameraMoreItem]
    private let kEmptyInfo:CGFloat = 10
    private let kEmptyActions:CGFloat = 40
    
    init(record:MCameraRecordEditable)
    {
        let itemClose:MCameraMoreItemClose = MCameraMoreItemClose(record:record)
        let itemEmptyInfo:MCameraMoreItemEmpty = MCameraMoreItemEmpty(cellHeight:kEmptyInfo)
        let itemInfoFrames:MCameraMoreItemInfoFrames = MCameraMoreItemInfoFrames(record:record)
        let itemInfoSize:MCameraMoreItemInfoSize = MCameraMoreItemInfoSize(record:record)
        let itemInfoSpeed:MCameraMoreItemInfoSpeed = MCameraMoreItemInfoSpeed(record:record)
        let itemEmptyActions:MCameraMoreItemEmpty = MCameraMoreItemEmpty(cellHeight:kEmptyActions)
        let itemActions:MCameraMoreItemActions = MCameraMoreItemActions(record:record)
        
        items = [
            itemClose,
            itemEmptyInfo,
            itemInfoFrames,
            itemInfoSize,
            itemInfoSpeed,
            itemEmptyActions,
            itemActions
        ]
    }
}
