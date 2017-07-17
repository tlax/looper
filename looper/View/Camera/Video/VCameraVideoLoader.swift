import UIKit

class VCameraVideoLoader:VView
{
    private weak var controller:CCameraVideoLoader!
    private weak var viewFrames:VCameraVideoLoaderFrames!
    private weak var buttonNext:UIButton!
    private weak var spinner:VSpinner!
    private let kButtonHeight:CGFloat = 50
    private let kButtonsBottom:CGFloat = -50
    private let kFramesHeight:CGFloat = 200
    
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
            NSLocalizedString("VCameraVideoLoader_buttonCancel", comment:""),
            for:UIControlState.normal)
        buttonCancel.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonNext:UIButton = UIButton()
        buttonNext.translatesAutoresizingMaskIntoConstraints = false
        buttonNext.backgroundColor = UIColor.clear
        buttonNext.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonNext.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        buttonNext.setTitle(
            NSLocalizedString("VCameraVideoLoader_buttonNext", comment:""),
            for:UIControlState.normal)
        buttonNext.addTarget(
            self,
            action:#selector(actionNext(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonNext = buttonNext
        
        let viewFrames:VCameraVideoLoaderFrames = VCameraVideoLoaderFrames(
            controller:self.controller)
        self.viewFrames = viewFrames
        
        addSubview(blur)
        addSubview(buttonCancel)
        addSubview(buttonNext)
        addSubview(viewFrames)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:buttonCancel,
            toView:self,
            constant:kButtonsBottom)
        NSLayoutConstraint.height(
            view:buttonCancel,
            constant:kButtonHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:buttonCancel,
            toView:self)
        
        NSLayoutConstraint.bottomToTop(
            view:buttonNext,
            toView:buttonCancel)
        NSLayoutConstraint.height(
            view:buttonNext,
            constant:kButtonHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:buttonNext,
            toView:self)
        
        NSLayoutConstraint.bottomToTop(
            view:viewFrames,
            toView:buttonNext)
        NSLayoutConstraint.height(
            view:viewFrames,
            constant:kFramesHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewFrames,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        spinner.stopAnimating()
    }
    
    //MARK: actions
    
    func actionCancel(sender button:UIButton)
    {
        controller.back()
    }
    
    func actionNext(sender button:UIButton)
    {
        
    }
    
    //MARK: public
    
    func block()
    {
        viewFrames.isHidden = true
        buttonNext.isHidden = true
    }
}
