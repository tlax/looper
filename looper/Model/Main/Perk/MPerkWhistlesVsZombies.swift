import Foundation

class MPerkWhistlesVsZombies:MPerkPurchaseProtocol
{
    private let kGameId:String = "iturbide.miniMancera.whistlesVsZombies"
    private let kPurchaseId:String = "iturbide.miniMancera.whistlesVsZombies"
    
    var gameId:String
    {
        get
        {
            return kGameId
        }
    }
    
    var optionsClass:MHomeOptions.Type
    {
        get
        {
            return MHomeOptionsWhistlesVsZombies.self
        }
    }
    
    var purchaseId:String
    {
        get
        {
            return kPurchaseId
        }
    }
}
