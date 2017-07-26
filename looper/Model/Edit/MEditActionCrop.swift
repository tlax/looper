import UIKit

class MEditActionCrop:MEditActionProtocol
{
    var image:UIImage
    {
        get
        {
            return #imageLiteral(resourceName: "assetGenericCrop")
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
