import Foundation

class MCameraFilter
{
    weak var currentFilter:MCameraFilterItem?
    let items:[MCameraFilterItem]
    
    init()
    {
        let itemNone:MCameraFilterItemNone = MCameraFilterItemNone()
        let itemBlend:MCameraFilterItemBlend = MCameraFilterItemBlend()
        let itemCoolBlue:MCameraFilterItemCoolBlue = MCameraFilterItemCoolBlue()
        
        items = [
            itemNone,
            itemBlend,
            itemCoolBlue
        ]
        
        currentFilter = items.first
    }
}
