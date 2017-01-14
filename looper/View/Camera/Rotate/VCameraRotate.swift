import UIKit

class VCameraRotate:VView
{
    private weak var controller:CCameraRotate!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CCameraRotate
        
        let blur:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.extraLight)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(effect:blur)
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.clipsToBounds
        
        addSubview(visualEffect)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
