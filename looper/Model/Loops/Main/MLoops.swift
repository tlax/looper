import Foundation

class MLoops
{
    var items:[MLoopsItem]
    
    init()
    {
        items = []
    }
    
    //MARK: private
    
    private func LoadFromDb()
    {
        
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
            
            self?.items = items
            completion()
        }
    }
}
