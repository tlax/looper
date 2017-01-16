import UIKit

class VCameraScale:VView
{
    private weak var controller:CCameraScale!
    private weak var viewSlider:VCameraScaleSlider!
    private weak var buttonDone:UIButton!
    private weak var layoutDoneLeft:NSLayoutConstraint!
    private var totalHeight:CGFloat
    private let kButtonHeight:CGFloat = 35
    private let kButtonWidth:CGFloat = 120
    private let kButtonBottom:CGFloat = -20
    private let kSliderTop:CGFloat = 40
    private let kSliderBottom:CGFloat = -40
    
    override init(controller:CController)
    {
        totalHeight = 0
        
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
        buttonDone.titleLabel!.font = UIFont.bold(size:17)
        buttonDone.addTarget(
            self,
            action:#selector(actionDone(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let viewSlider:VCameraScaleSlider = VCameraScaleSlider(controller:self.controller)
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
            constant:kButtonWidth)
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
            toView:buttonDone,
            constant:kSliderBottom)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        totalHeight = bounds.maxY - (kSliderTop - kSliderBottom + kButtonHeight - kButtonBottom)
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
        else if percent < 0
        {
            percent = 0
        }
        
        controller.currentPercent = percent
        updateSlider()
    }
    
    //MARK: public
    
    func updateSlider()
    {
        viewSlider.sliderSelected(percent:controller.currentPercent)
    }
}
