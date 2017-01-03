import UIKit

class VCameraPreviewPlayer:UIView
{
    private weak var controller:CCameraPreview!
    
    convenience init(controller:CCameraPreview)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}
