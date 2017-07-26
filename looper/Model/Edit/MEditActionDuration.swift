import UIKit

class MEditActionDuration:MEditActionProtocol
{
    var image:UIImage
    {
        get
        {
            return #imageLiteral(resourceName: "assetGenericDuration")
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
