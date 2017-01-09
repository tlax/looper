import UIKit

class MStoreItemWatermark:MStoreItem
{
    private let kStorePurchaseId:MStore.PurchaseId = "iturbide.looper.watermark"
    
    override init()
    {
        let title:String = NSLocalizedString("MStoreItemWatermark_title", comment:"")
        let descr:String = NSLocalizedString("MStoreItemWatermark_descr", comment:"")
        let image:UIImage = #imageLiteral(resourceName: "assetHelpFilter")
        
        super.init(
            purchaseId:kStorePurchaseId,
            title:title,
            descr:descr,
            image:image)
    }
    
    override init(
        purchaseId:MStore.PurchaseId,
        title:String,
        descr:String,
        image:UIImage)
    {
        fatalError()
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
