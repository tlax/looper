import UIKit

class VCameraMore:VView
{
    private weak var controller:CCameraMore!
    private var closeable:Bool
    
    override init(controller:CController)
    {
        closeable = true
        
        super.init(controller:controller)
        self.controller = controller as? CCameraMore
        
        let blur:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.light)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(effect:blur)
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.isUserInteractionEnabled = false
        visualEffect.clipsToBounds = true
        
        let closeButton:UIButton = UIButton()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.backgroundColor = UIColor.clear
        closeButton.addTarget(
            self,
            action:#selector(actionClose(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(visualEffect)
        addSubview(closeButton)
        
        let constraintsEffect:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:visualEffect,
            toView:self)
        let constraintsClose:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:closeButton,
            toView:self)
        
        addConstraints(constraintsEffect)
        addConstraints(constraintsClose)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        if closeable
        {
            closeable = false
            controller.close()
        }
    }
}
