import Foundation

class MCameraFilter
{
    weak var currentFilter:MCameraFilterItem?
    let items:[MCameraFilterItem]
    
    init()
    {
        let itemNone:MCameraFilterItemNone = MCameraFilterItemNone()
        let itemBlend:MCameraFilterItemBlend = MCameraFilterItemBlend()
        
        items = [
            itemNone,
            itemBlend
        ]
        
        currentFilter = items.first
    }
}
