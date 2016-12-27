import UIKit

class VParentBar:UIView
{
    private weak var controller:CParent!
    
    convenience init(controller:CParent)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}
