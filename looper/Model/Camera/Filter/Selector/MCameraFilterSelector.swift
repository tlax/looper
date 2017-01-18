import Foundation

class MCameraFilterSelector
{
    let items:[MCameraFilterSelectorItem]
    var selected:Int
    
    init(items:[MCameraFilterItem])
    {
        selected = 0
        self.items = items
    }
}
