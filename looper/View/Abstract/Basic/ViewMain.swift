import UIKit

class ViewMain:UIView, ViewProtocol
{
    private(set) weak var controller:UIViewController!
    weak var layoutLeft:NSLayoutConstraint!
    weak var layoutRight:NSLayoutConstraint!
    weak var layoutTop:NSLayoutConstraint!
    weak var layoutBottom:NSLayoutConstraint!
    weak var pushBackground:VPushBackground?
    private let kPanBack:Bool = false
    
    required init(controller:UIViewController)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    var panBack:Bool
    {
        get
        {
            return kPanBack
        }
    }
}
