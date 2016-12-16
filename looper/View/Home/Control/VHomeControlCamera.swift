import UIKit

class VHomeControlCamera:UIView
{
    private weak var controller:CHome!
    
    convenience init(controller:CHome)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.gray
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}
