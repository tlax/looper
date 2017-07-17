import UIKit

class VCameraVideoLoader:VView
{
    private weak var controller:CCameraVideoLoader!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CCameraVideoLoader
        
        let blur:VBlur = VBlur.dark()
        
        addSubview(blur)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
