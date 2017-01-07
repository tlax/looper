import UIKit

class VHelp:VView
{
    private weak var controller:CHelp!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CHelp
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.extraLight)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(
            effect:blurEffect)
        visualEffect.isUserInteractionEnabled = false
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.clipsToBounds = true
        
        addSubview(visualEffect)
        
        let constraintsEffect:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:visualEffect,
            parent:self)
        
        addConstraints(constraintsEffect)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
