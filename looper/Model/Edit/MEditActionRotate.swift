import UIKit

class MEditActionRotate:MEditActionProtocol
{
    var image:UIImage
    {
        get
        {
            return #imageLiteral(resourceName: "assetGenericRotate")
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
