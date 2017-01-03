import UIKit

class VCameraPreviewBar:UIView
{
    private weak var controller:CCameraPreview!
    
    convenience init(controller:CCameraPreview)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
    }
}
