import UIKit

class VCameraVideoLoader:VView
{
    private weak var controller:CCameraVideoLoader!
    private weak var viewFrames:VCameraVideoLoaderFrames!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CCameraVideoLoader
        
        let blur:VBlur = VBlur.dark()
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.backgroundColor = UIColor.clear
        buttonCancel.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        buttonCancel.setTitle(
            NSLocalizedString("", comment:""),
            for:UIControlState.normal)
        
        let buttonNext:UIButton = UIButton()
        
        addSubview(blur)
        addSubview(buttonCancel)
        addSubview(buttonNext)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    
}
