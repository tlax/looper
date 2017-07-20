import UIKit

class View<T:ViewMain, S:Model>:UIView
{
    private(set) weak var controller:Controller<T, S>!
    
    required init(controller:Controller<T, S>)
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
