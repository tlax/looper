import UIKit

class VCameraScale:VView
{
    private weak var controller:CCameraScale!
    private weak var viewSlider:VCameraScaleSlider!
    private weak var spinner:VSpinner!
    private weak var buttonDone:UIButton!
    private weak var buttonReset:UIButton!
    private weak var layoutDoneLeft:NSLayoutConstraint!
    private var totalHeight:CGFloat
    private var minPercent:CGFloat
    private let kButtonDoneHeight:CGFloat = 35
    private let kButtonResetHeight:CGFloat = 50
    private let kButtonWidth:CGFloat = 120
    private let kSliderTop:CGFloat = 90
    private let kSliderBottom:CGFloat = -40
    private let kAlphaLoading:CGFloat = 0.3
    
    override init(controller:CController)
    {
        totalHeight = 0
        minPercent = 0
        
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CCameraScale
        
        if let imageSize:CGFloat = self.controller.record.items.first?.image.size.width
        {
            minPercent = MCamera.kImageMinSize / imageSize
        }
        
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
            NSLocalizedString("VCameraScale_done", comment:""),
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
            NSLocalizedString("VCameraScale_reset", comment:""),
            for:UIControlState.normal)
        buttonReset.titleLabel!.font = UIFont.medium(size:14)
        buttonReset.addTarget(
            self,
            action:#selector(actionReset(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonReset = buttonReset
        
        let viewSlider:VCameraScaleSlider = VCameraScaleSlider(controller:self.controller)
        self.viewSlider = viewSlider
        
        let spinner:VSpinner = VSpinner()
        spinner.stopAnimating()
        self.spinner = spinner
        
        addSubview(blur)
        addSubview(viewSlider)
        addSubview(buttonDone)
        addSubview(buttonReset)
        addSubview(spinner)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:viewSlider)
        
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
            toView:buttonDone,
            constant:kSliderBottom)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        totalHeight = bounds.maxY - (kSliderTop - kSliderBottom + kButtonDoneHeight + kButtonResetHeight)
        let width:CGFloat = bounds.maxX
        let remain:CGFloat = width - kButtonWidth
        let margin:CGFloat = remain / 2.0
        layoutDoneLeft.constant = margin
        
        super.layoutSubviews()
    }
    
    override func touchesBegan(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        guard
        
            let touch:UITouch = touches.first,
            let view:VCameraScaleSlider = touch.view as? VCameraScaleSlider
        
        else
        {
            return
        }
        
        let point:CGPoint = touch.location(in:view)
        touchAtPoint(point:point)
    }
    
    override func touchesMoved(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        guard
            
            let touch:UITouch = touches.first,
            let view:VCameraScaleSlider = touch.view as? VCameraScaleSlider
            
        else
        {
            return
        }
        
        let point:CGPoint = touch.location(in:view)
        touchAtPoint(point:point)
    }
    
    override func touchesCancelled(_ touches:Set<UITouch>, with event:UIEvent?)
    {
    }
    
    override func touchesEnded(_ touches:Set<UITouch>, with event:UIEvent?)
    {
    }
    
    //MARK: actions
    
    func actionDone(sender button:UIButton)
    {
        button.isUserInteractionEnabled = false
        
        controller.save()
    }
    
    func actionReset(sender button:UIButton)
    {
        controller.reset()
    }
    
    //MARK: private
    
    private func touchAtPoint(point:CGPoint)
    {
        let pointY:CGFloat = point.y
        let normalY:CGFloat = totalHeight - pointY
        var percent:CGFloat = normalY / totalHeight
        
        if percent > 1
        {
            percent = 1
        }
        else if percent < minPercent
        {
            percent = minPercent
        }
        
        controller.currentPercent = percent
        updateSlider()
    }
    
    //MARK: public
    
    func updateSlider()
    {
        viewSlider.sliderSelected(percent:controller.currentPercent)
    }
    
    func startLoading()
    {
        spinner.startAnimating()
        viewSlider.isHidden = true
        buttonDone.isUserInteractionEnabled = false
        buttonReset.isUserInteractionEnabled = false
        buttonDone.alpha = kAlphaLoading
        buttonReset.alpha = kAlphaLoading
    }
}
