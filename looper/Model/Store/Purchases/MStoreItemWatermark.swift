import UIKit

class MStoreItemWatermark:MStoreItem
{
    private let kStorePurchaseId:MStore.PurchaseId = "iturbide.looper.watermark"
    
    init()
    {
        let title:String = NSLocalizedString("MStoreItemWatermark_title", comment:"")
        let descr:String = NSLocalizedString("MStoreItemWatermark_descr", comment:"")
        let image:UIImage = #imageLiteral(resourceName: "assetGenericStoreWatermark")
        
        super.init(
            purchaseId:kStorePurchaseId,
            title:title,
            descr:descr,
            image:image)
    }
    
    override func purchaseAction()
    {
        MSession.sharedInstance.settings?.watermark = true
        DManager.sharedInstance.save()
    }
    
    override func validatePurchase() -> Bool
    {
        var isPurchased:Bool = false
        
        guard
            
            let watermark:Bool = MSession.sharedInstance.settings?.watermark
            
        else
        {
            return isPurchased
        }
        
        isPurchased = watermark
        
        return isPurchased
    }
}
