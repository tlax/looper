import Foundation

class MLoops
{
    var items:[MLoopsItem]
    
    init()
    {
        items = []
    }
    
    //MARK: public
    
    func loadFromDb(completion:@escaping(() -> ()))
    {
        DManager.sharedInstance.fetchManagedObjects(
            entityName:DLoop.entityName)
        { [weak self] (fetched) in
            
            guard
                
                let loops:[DLoop] = fetched as? [DLoop]
                
            else
            {
                self?.items = []
                completion()
                
                return
            }
            
            var items:[MLoopsItem] = []
            
            for loop:DLoop in loops
            {
                let item:MLoopsItem = MLoopsItem(loop:loop)
                items.append(item)
            }
            
            items.sort
            { (itemA:MLoopsItem, itemB:MLoopsItem) -> Bool in
                
                return itemA.loop.created > itemB.loop.created
            }
            
            self?.items = items
            completion()
        }
    }
}
