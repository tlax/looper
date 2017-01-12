import UIKit

class VCameraMoreCell:UICollectionViewCell
{
    weak var model:MCameraMoreItem?
    weak var controller:CCameraMore?
    
    //MARK: public
    
    func config(controller:CCameraMore, model:MCameraMoreItem)
    {
        self.controller = controller
        self.model = model
    }
}
