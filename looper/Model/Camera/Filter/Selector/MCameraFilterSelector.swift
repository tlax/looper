import Foundation

class MCameraFilterSelector
{
    let items:[MCameraFilterSelectorItem]
    var selected:Int
    
    init(items:[MCameraFilterSelectorItem])
    {
        selected = 0
        self.items = items
    }
}
