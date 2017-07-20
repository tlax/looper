import UIKit

class View<T:ViewMain, S:Model, R:Controller<T, S>>:UIView
{
    private(set) weak var controller:R!
    
    required init(controller:R)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
