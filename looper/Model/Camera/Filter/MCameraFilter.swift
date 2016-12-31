import Foundation

class MCameraFilter
{
    weak var currentFilter:MCameraFilterItem?
    let items:[MCameraFilterItem]
    
    init()
    {
        items = [
        ]
        
        currentFilter = items.first
    }
}
