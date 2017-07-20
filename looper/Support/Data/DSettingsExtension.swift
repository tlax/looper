import Foundation
import CoreData

extension DSettings
{
    //MARK: public
    
    func addTtl()
    {
        ttl += 1
        DManager.sharedInstance?.save()
    }
    
    func perksMap() -> [String:DPerk]
    {
        var map:[String:DPerk] = [:]
        
        guard
            
            let perks:[DPerk] = perks?.array as? [DPerk]
            
        else
        {
            return map
        }
        
        for perk:DPerk in perks
        {
            guard
                
                let identifier:String = perk.identifier
                
            else
            {
                continue
            }
            
            map[identifier] = perk
        }
        
        return map
    }
}
