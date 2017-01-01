import Foundation

class MCameraFilter
{
    weak var currentFilter:MCameraFilterItem?
    let items:[MCameraFilterItem]
    
    init()
    {
        let itemNone:MCameraFilterItemNone = MCameraFilterItemNone()
        
        items = [
            itemNone
        ]
        
        currentFilter = items.first
    }
}
