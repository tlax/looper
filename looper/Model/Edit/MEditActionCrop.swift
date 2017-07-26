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
    
    func selected(edit:MEdit) -> UIViewController
    {
        fatalError()
    }
}
