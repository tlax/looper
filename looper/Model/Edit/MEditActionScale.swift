import UIKit

class MEditActionScale:MEditActionProtocol
{
    var image:UIImage
    {
        get
        {
            return #imageLiteral(resourceName: "assetGenericScale")
        }
    }
    
    var controllerType:UIViewController.Type
    {
        get
        {
            return UIViewController.self
        }
    }
}
