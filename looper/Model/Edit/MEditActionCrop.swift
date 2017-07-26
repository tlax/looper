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
        let controller:CEditCrop = CEditCrop(edit:edit)
        
        return controller
    }
}
