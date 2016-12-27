import UIKit

class VCameraHeader:UICollectionReusableView
{
    private weak var controller:CCamera?
    private weak var buttonShoot:UIButton!
    
    //MARK: public
    
    func config(controller:CCamera)
    {
        self.controller = controller
    }
}
