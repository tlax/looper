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
    
    func selected(edit:MEdit) -> UIViewController
    {
        fatalError()
    }
}
