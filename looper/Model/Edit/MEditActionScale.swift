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
    
    func selected(edit:MEdit) -> UIViewController
    {
        fatalError()
    }
}
