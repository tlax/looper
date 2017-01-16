import UIKit

class VCameraScale:VView
{
    private weak var controller:CCameraScale!
    private weak var viewSlider:VCameraScaleSlider!
    private weak var buttonDone:UIButton!
    private weak var layoutDoneLeft:NSLayoutConstraint!
    private let kButtonHeight:CGFloat = 35
    private let kButtonWidth:CGFloat = 120
    private let kButtonBottom:CGFloat = 30
    private let kSliderTop:CGFloat = 20
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CCameraScale
        
        let blur:VBlur = VBlur.extraLight()
        
        let buttonDone:UIButton = UIButton()
        buttonDone.translatesAutoresizingMaskIntoConstraints = false
        buttonDone.clipsToBounds = true
        buttonDone.backgroundColor = UIColor.genericLight
        buttonDone.layer.cornerRadius = kButtonHeight / 2.0
        buttonDone.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonDone.setTitleColor(
            UIColor(white:1, alpha:0.1),
            for:UIControlState.highlighted)
        buttonDone.setTitle(
            NSLocalizedString("VCameraScale_done", comment:""),
            for:UIControlState.normal)
        buttonDone.addTarget(
            self,
            action:#selector(actionDone(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let viewSlider:VCameraScaleSlider = VCameraScaleSlider()
        self.viewSlider = viewSlider
        
        addSubview(blur)
        addSubview(viewSlider)
        addSubview(buttonDone)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:buttonDone,
            toView:self,
            constant:kButtonBottom)
        NSLayoutConstraint.height(
            view:buttonDone,
            constant:kButtonHeight)
        NSLayoutConstraint.width(
            view:buttonDone,
            constant:kButtonBottom)
        layoutDoneLeft = NSLayoutConstraint.leftToLeft(
            view:buttonDone,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewSlider,
            toView:self,
            constant:kSliderTop)
        NSLayoutConstraint.leftToLeft(
            view:viewSlider,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:viewSlider,
            toView:self)
        NSLayoutConstraint.bottomToTop(
            view:viewSlider,
            toView:buttonDone)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
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
}
