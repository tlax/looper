import UIKit

class MSourceItemImage:MSourceProtocol
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
    
    var controller:UIViewController.Type
    {
        get
        {
            return CSourceImage.self
        }
    }
}
