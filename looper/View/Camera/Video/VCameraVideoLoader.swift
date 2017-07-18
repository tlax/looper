import UIKit

class VCameraVideoLoader:VView
{
    private(set) weak var viewFrames:VCameraVideoLoaderFrames!
    private weak var controller:CCameraVideoLoader!
    private weak var buttonNext:UIButton!
    private weak var spinner:VSpinner!
    private let kButtonHeight:CGFloat = 60
    private let kFramesHeight:CGFloat = 160
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CCameraVideoLoader
        
        let blur:VBlur = VBlur.extraLight()
        
        let spinner:VSpinner = VSpinner()
        spinner.stopAnimating()
        self.spinner = spinner
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.backgroundColor = UIColor.clear
        buttonCancel.setTitleColor(
            UIColor.black,
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor(white:0, alpha:0.2),
            for:UIControlState.highlighted)
        buttonCancel.setTitle(
            NSLocalizedString("VCameraVideoLoader_buttonCancel", comment:""),
            for:UIControlState.normal)
        buttonCancel.titleLabel!.font = UIFont.bold(size:15)
        buttonCancel.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonNext:UIButton = UIButton()
        buttonNext.translatesAutoresizingMaskIntoConstraints = false
        buttonNext.setImage(
            #imageLiteral(resourceName: "assetGenericNext"),
            for:UIControlState.normal)
        buttonNext.imageView!.clipsToBounds = true
        buttonNext.imageView!.contentMode = UIViewContentMode.center
        buttonNext.addTarget(
            self,
            action:#selector(actionNext(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonNext = buttonNext
        
        let viewFrames:VCameraVideoLoaderFrames = VCameraVideoLoaderFrames(
            controller:self.controller)
        self.viewFrames = viewFrames
        
        addSubview(blur)
        addSubview(spinner)
        addSubview(buttonCancel)
        addSubview(buttonNext)
        addSubview(viewFrames)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:buttonCancel,
            toView:self)
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
        controller.next()
    }
    
    //MARK: public
    
    func block()
    {
        viewFrames.isHidden = true
        buttonNext.isHidden = true
        spinner.startAnimating()
    }
}
