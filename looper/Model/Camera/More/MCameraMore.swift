import Foundation

class MCameraMore
{
    let items:[MCameraMoreItem]
    
    init(record:MCameraRecord)
    {
        let itemClose:MCameraMoreItemClose = MCameraMoreItemClose(record:record)
        
        items = [
            itemClose
        ]
    }
}
