import Foundation
import CoreData

extension MSession
{
    func loadPerks(settings:DSettings)
    {
        let perksMap:[String:DPerk] = settings.perksMap()
        let thumbnails:[MPerkThumbnailProtocol] = MSession.factoryPerks()
        let dispatchGroup:DispatchGroup = DispatchGroup()
        dispatchGroup.setTarget(
            queue:DispatchQueue.global(
                qos:DispatchQoS.QoSClass.background))
        
        loadPerks(
            perksMap:perksMap,
            thumbnails:thumbnails,
            dispatchGroup:dispatchGroup)
    }
    
    //MARK: private
    
    private class func factoryPerks() -> [MPerkThumbnailProtocol]
    {
        let perks:[MPerkThumbnailProtocol] = []
        
        return perks
    }
    
    private func loadPerks(
        perksMap:[String:DPerk],
        thumbnails:[MPerkThumbnailProtocol],
        dispatchGroup:DispatchGroup)
    {
        for thumbnail:MPerkThumbnailProtocol in thumbnails
        {
            let identifier:String = thumbnail.identifier()
            
            guard
                
                let _:DPerk = perksMap[identifier]
            
            else
            {
                addThumbnail(
                    thumbnail:thumbnail,
                    dispatchGroup:dispatchGroup)
                
                continue
            }
        }
        
        dispatchGroup.notify(
            queue:DispatchQueue.global(
                qos:DispatchQoS.QoSClass.background))
        { [weak self] in
            
            self?.finishedLoadingSession()
        }
    }
    
    private func addThumbnail(
        thumbnail:MPerkThumbnailProtocol,
        dispatchGroup:DispatchGroup)
    {
        if let thumbnailFree:MPerkThumbnailFreeProtocol = thumbnail as? MPerkThumbnailFreeProtocol
        {
            addThumbnailFree(
                thumbnail:thumbnailFree,
                dispatchGroup:dispatchGroup)
        }
        else if let thumbnailPurchase:MPerkThumbnailPurchaseProtocol = thumbnail as? MPerkThumbnailPurchaseProtocol
        {
            addThumbnailPurchase(
                thumbnail:thumbnailPurchase,
                dispatchGroup:dispatchGroup)
        }
    }
    
    private func addThumbnailFree(
        thumbnail:MPerkThumbnailFreeProtocol,
        dispatchGroup:DispatchGroup)
    {
        dispatchGroup.enter()
        
        let identifier:String = thumbnail.identifier()
        let domainIdentifier:String = thumbnail.domainIdentifier()
        
        DManager.sharedInstance?.create(entity:DPerkFree.self)
        { (data:NSManagedObject?) in
            
            guard
                
                let perk:DPerkFree = data as? DPerkFree
                
            else
            {
                return
            }
            
            perk.identifier = identifier
            perk.domainIdentifier = domainIdentifier
            perk.settings = self.settings
            
            dispatchGroup.leave()
        }
    }
    
    private func addThumbnailPurchase(
        thumbnail:MPerkThumbnailPurchaseProtocol,
        dispatchGroup:DispatchGroup)
    {
        dispatchGroup.enter()
        
        let identifier:String = thumbnail.identifier()
        let domainIdentifier:String = thumbnail.domainIdentifier()
        
        DManager.sharedInstance?.create(entity:DPerkPurchase.self)
        { (data:NSManagedObject?) in
            
            guard
                
                let perk:DPerkPurchase = data as? DPerkPurchase
                
            else
            {
                return
            }
            
            perk.identifier = identifier
            perk.domainIdentifier = domainIdentifier
            perk.settings = self.settings
            
            dispatchGroup.leave()
        }
    }
}
