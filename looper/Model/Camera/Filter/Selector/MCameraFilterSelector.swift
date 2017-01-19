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
    
    //MARK: public
    
    func selectedModel() -> MCameraFilterSelectorItem
    {
        let item:MCameraFilterSelectorItem = items[selected]
        
        return item
    }
}
