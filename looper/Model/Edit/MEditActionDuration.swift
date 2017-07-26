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
    
    func selected(edit:MEdit) -> UIViewController
    {
        let controller:CEditDuration = CEditDuration(edit:edit)
        
        return controller
    }
}
