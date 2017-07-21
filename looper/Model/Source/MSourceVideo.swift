import UIKit

class MSourceVideo:MSourceProtocol
{
    var icon:UIImage
    {
        get
        {
            return #imageLiteral(resourceName: "assetCreateVideo")
        }
    }
    
    var title:String
    {
        get
        {
            return String.localizedModel(key:"MSourceVideo_title")
        }
    }
}
