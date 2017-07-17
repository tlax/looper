import UIKit

class MCameraMore
{
    let items:[MCameraMoreItem]
    private let kEmptyActions:CGFloat = 30
    
    init(record:MCameraRecord)
    {
        let itemClose:MCameraMoreItemClose = MCameraMoreItemClose()
        let itemInfoFrames:MCameraMoreItemInfoFrames = MCameraMoreItemInfoFrames(record:record)
        let itemInfoSize:MCameraMoreItemInfoSize = MCameraMoreItemInfoSize(record:record)
        let itemEmptyActions:MCameraMoreItemEmpty = MCameraMoreItemEmpty(cellHeight:kEmptyActions)
        let itemActions:MCameraMoreItemActions = MCameraMoreItemActions()
        
        items = [
            itemClose,
            itemInfoFrames,
            itemInfoSize,
            itemEmptyActions,
            itemActions
        ]
    }
}
