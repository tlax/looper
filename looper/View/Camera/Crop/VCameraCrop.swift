import UIKit

class VCameraCrop:VView
{
    weak var viewImage:VCameraCropImage!
    private weak var controller:CCameraCrop!
    private weak var buttonDone:UIButton!
    private weak var buttonReset:UIButton!
    private weak var spinner:VSpinner!
    private weak var layoutDoneLeft:NSLayoutConstraint!
    private let kButtonDoneHeight:CGFloat = 35
    private let kButtonResetHeight:CGFloat = 50
    private let kButtonWidth:CGFloat = 120
    private let kAnimationDuration:TimeInterval = 0.3
    private let kAlphaLoading:CGFloat = 0.3
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CCameraCrop
        
        let blur:VBlur = VBlur.extraLight()
        
        let buttonDone:UIButton = UIButton()
        buttonDone.translatesAutoresizingMaskIntoConstraints = false
        buttonDone.clipsToBounds = true
        buttonDone.backgroundColor = UIColor.genericLight
        buttonDone.layer.cornerRadius = kButtonDoneHeight / 2.0
        buttonDone.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonDone.setTitleColor(
            UIColor(white:1, alpha:0.1),
            for:UIControlState.highlighted)
        buttonDone.setTitle(
            NSLocalizedString("VCameraCrop_done", comment:""),
            for:UIControlState.normal)
        buttonDone.titleLabel!.font = UIFont.bold(size:17)
        buttonDone.addTarget(
            self,
            action:#selector(actionDone(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonDone = buttonDone
        
        let buttonReset:UIButton = UIButton()
        buttonReset.translatesAutoresizingMaskIntoConstraints = false
        buttonReset.clipsToBounds = true
        buttonReset.backgroundColor = UIColor.clear
        buttonReset.setTitleColor(
            UIColor.black,
            for:UIControlState.normal)
        buttonReset.setTitleColor(
            UIColor(white:0, alpha:0.2),
            for:UIControlState.highlighted)
        buttonReset.setTitle(
            NSLocalizedString("VCameraCrop_reset", comment:""),
            for:UIControlState.normal)
        buttonReset.titleLabel!.font = UIFont.medium(size:14)
        buttonReset.addTarget(
            self,
            action:#selector(actionReset(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonReset = buttonReset
        
        let viewImage:VCameraCropImage = VCameraCropImage(controller:self.controller)
        self.viewImage = viewImage
        
        let spinner:VSpinner = VSpinner()
        spinner.stopAnimating()
        self.spinner = spinner
        
        addSubview(blur)
        addSubview(spinner)
        addSubview(viewImage)
        addSubview(buttonDone)
        addSubview(buttonReset)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.bottomToTop(
            view:buttonDone,
            toView:buttonReset)
        NSLayoutConstraint.height(
            view:buttonDone,
            constant:kButtonDoneHeight)
        NSLayoutConstraint.width(
            view:buttonDone,
            constant:kButtonWidth)
        layoutDoneLeft = NSLayoutConstraint.leftToLeft(
            view:buttonDone,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:buttonReset,
            toView:self)
        NSLayoutConstraint.height(
            view:buttonReset,
            constant:kButtonResetHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:buttonReset,
            toView:buttonDone)
        
        NSLayoutConstraint.topToTop(
            view:viewImage,
            toView:self)
        NSLayoutConstraint.bottomToTop(
            view:viewImage,
            toView:buttonDone)
        NSLayoutConstraint.equalsHorizontal(
            view:viewImage,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:viewImage)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remain:CGFloat = width - kButtonWidth
        let margin:CGFloat = remain / 2.0
        layoutDoneLeft.constant = margin
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionDone(sender button:UIButton)
    {
        button.isUserInteractionEnabled = false
        controller.save()
    }
    
    func actionReset(sender button:UIButton)
    {
        viewImage.thumbTopLeft.reset()
        viewImage.thumbTopRight.reset()
        viewImage.thumbBottomLeft.reset()
        viewImage.thumbBottomRight.reset()
        
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
        { [weak self] in
            
            self?.viewImage.layoutIfNeeded()
        })
        { [weak self] (done:Bool) in
            
            self?.viewImage.print()
        }
    }
    
    //MARK: public
    
    func startLoading()
    {
        spinner.startAnimating()
        viewImage.isHidden = true
        buttonDone.isUserInteractionEnabled = false
        buttonReset.isUserInteractionEnabled = false
        buttonReset.alpha = kAlphaLoading
        buttonDone.alpha = kAlphaLoading
    }
}
