import UIKit

class MSourceItemVideo:MSourceProtocol
{
    var icon:UIImage
    {
        get
        {
            return #imageLiteral(resourceName: "assetGenericNewVideo")
        }
    }
    
    var title:String
    {
        get
        {
            return String.localizedModel(key:"MSourceItemVideo_title")
        }
    }
    
    var controller:UIViewController.Type
    {
        get
        {
            return CSourceVideo.self
        }
    }
}
