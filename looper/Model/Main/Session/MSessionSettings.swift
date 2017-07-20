import Foundation
import CoreData

extension MSession
{
    func asyncLoadSession()
    {
        DManager.sharedInstance?.fetch(entity:DSettings.self)
        { (data:[NSManagedObject]?) in
            
            guard
            
                let settings:DSettings = data?.first as? DSettings
            
            else
            {
                self.createSession()
                
                return
            }
            
            settings.addTtl()
            
            self.settingsLoaded(settings:settings)
        }
    }
    
    //MARK: private
    
    private func createSession()
    {
        DManager.sharedInstance?.create(entity:DSettings.self)
        { (data:NSManagedObject?) in
            
            guard
            
                let settings:DSettings = data as? DSettings
            
            else
            {
                return
            }
            
            self.settingsLoaded(settings:settings)
        }
    }
}
