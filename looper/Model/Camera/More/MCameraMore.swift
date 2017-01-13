import Foundation

class MCameraMore
{
    let items:[MCameraMoreItem]
    
    init(record:MCameraRecord)
    {
        let itemClose:MCameraMoreItemClose = MCameraMoreItemClose(record:record)
        let itemInfoFrames:MCameraMoreItemInfoFrames = MCameraMoreItemInfoFrames(record:record)
        let itemInfoSize:MCameraMoreItemInfoSize = MCameraMoreItemInfoSize(record:record)
        
        items = [
            itemClose,
            itemInfoFrames,
            itemInfoSize
        ]
    }
}
