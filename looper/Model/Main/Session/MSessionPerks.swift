import Foundation

extension MSession
{
    private class func factoryPerks() -> [MPerkThumbnailProtocol]
    {
        let perks:[MPerkThumbnailProtocol] = []
        
        return perks
    }
    
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
            
            self?.finishLoadingSession()
        }
    }
    
    private func addThumbnail(thumbnail:MPerkThumbnailProtocol, dispatchGroup:DispatchGroup)
    {
        if let thumbnailFree:MPerkThumbnailFreeProtocol = thumbnail as? MPerkThumbnailFreeProtocol
        {
            addPerkFree(perk:perkFree, dispatchGroup:dispatchGroup)
        }
        else if let thumbnailPurchase:MPerkThumbnailPurchaseProtocol = thumbnail as? MPerkThumbnailPurchaseProtocol
        {
            addPerkPurchase(perk:perkPurchase, dispatchGroup:dispatchGroup)
        }
    }
    
    private func addThumbnailFree(thumbnail:MPerkThumbnailFreeProtocol, dispatchGroup:DispatchGroup)
    {
        dispatchGroup.enter()
        
        let optionsClass:String = optionsClassFor(perk:perk)
        
        DManager.sharedInstance?.createData(
            entityName:DOptionFree.entityName)
        { (data) in
            
            guard
                
                let option:DOptionFree = data as? DOptionFree
                
                else
            {
                return
            }
            
            option.gameId = perk.gameId
            option.optionsClass = optionsClass
            option.settings = self.settings
            
            dispatchGroup.leave()
        }
    }
    
    private func addPerkPurchase(perk:MPerkPurchaseProtocol, dispatchGroup:DispatchGroup)
    {
        dispatchGroup.enter()
        
        let optionsClass:String = optionsClassFor(perk:perk)
        
        DManager.sharedInstance?.createData(
            entityName:DOptionPurchase.entityName)
        { (data) in
            
            guard
                
                let option:DOptionPurchase = data as? DOptionPurchase
                
                else
            {
                return
            }
            
            option.gameId = perk.gameId
            option.optionsClass = optionsClass
            option.purchaseId = perk.purchaseId
            option.settings = self.settings
            
            dispatchGroup.leave()
        }
    }
}
