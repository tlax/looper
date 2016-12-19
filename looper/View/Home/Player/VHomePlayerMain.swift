import UIKit

class VHomePlayerMain:UIButton
{
    private weak var controller:CHome!
    
    convenience init(controller:CHome)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(
            self,
            action:#selector(self.actionMain(sender:)),
            for:UIControlEvents.touchUpInside)
        self.controller = controller
    }
    
    //MARK: actions
    
    func actionMain(sender button:UIButton)
    {
        
    }
}
