import UIKit

class MSourceImage:MSourceProtocol
{
    var icon:UIImage
    {
        get
        {
            return #imageLiteral(resourceName: "assetCreateImage")
        }
    }
    
    var title:String
    {
        get
        {
            return String.localizedModel(key:"MSourceImage_title")
        }
    }
}
