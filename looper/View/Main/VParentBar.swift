import UIKit

class VParentBar:UIView
{
    private weak var controller:CParent!
    private weak var buttonLoops:UIButton!
    
    convenience init(controller:CParent)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let buttonLoops:UIButton = UIButton()
        buttonLoops.translatesAutoresizingMaskIntoConstraints = false
        buttonLoops.imageView!.contentMode = UIViewContentMode.center
        buttonLoops.imageView!.clipsToBounds = true
        
        self.buttonLoops = buttonLoops
        
        addSubview(buttonLoops)
    }
}
