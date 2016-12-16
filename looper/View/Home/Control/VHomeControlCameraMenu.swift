import UIKit

class VHomeControlCameraMenu:UIView
{
    private weak var controller:CHome!
    
    convenience init(controller:CHome)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor(white:0.95, alpha:1)
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}
