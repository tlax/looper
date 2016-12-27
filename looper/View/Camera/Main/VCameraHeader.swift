import UIKit

class VCameraHeader:UICollectionReusableView
{
    private weak var controller:CCamera?
    
    //MARK: public
    
    func config(controller:CCamera)
    {
        self.controller = controller
    }
}
