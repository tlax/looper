import Foundation

class MCameraMore
{
    let items:[MCameraMoreItem]
    
    init(record:MCameraRecordEditable)
    {
        let itemClose:MCameraMoreItemClose = MCameraMoreItemClose(record:record)
        let itemInfoFrames:MCameraMoreItemInfoFrames = MCameraMoreItemInfoFrames(record:record)
        let itemInfoSize:MCameraMoreItemInfoSize = MCameraMoreItemInfoSize(record:record)
        let itemInfoSpeed:MCameraMoreItemInfoSpeed = MCameraMoreItemInfoSpeed(record:record)
        
        items = [
            itemClose,
            itemInfoFrames,
            itemInfoSize,
            itemInfoSpeed
        ]
    }
}
