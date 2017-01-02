import Foundation

class MCameraCompress
{
    let items:[MCameraCompressItem]
    var currentCompress:MCameraCompressItem?
    
    init()
    {
        let itemNone:MCameraCompressItemNone = MCameraCompressItemNone()
        let itemSlight:MCameraCompressItemSlight = MCameraCompressItemSlight()
        let itemMedium:MCameraCompressItemMedium = MCameraCompressItemMedium()
        let itemMax:MCameraCompressItemMax = MCameraCompressItemMax()
        
        items = [
            itemNone,
            itemSlight,
            itemMedium,
            itemMax
        ]
        
        currentCompress = items.first
    }
}
