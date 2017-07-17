import UIKit

class VCameraMoreCell:UICollectionViewCell
{
    weak var model:MCameraMoreItem?
    weak var controller:CCameraMore?
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(controller:CCameraMore, model:MCameraMoreItem)
    {
        self.controller = controller
        self.model = model
    }
}
