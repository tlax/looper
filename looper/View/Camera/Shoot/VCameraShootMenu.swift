import UIKit

class VCameraShootMenu:UIView
{
    weak var buttonTrigger:VCameraShootMenuTrigger!
    private weak var controller:CCameraShoot!
    private weak var buttonBack:UIButton!
    private weak var buttonReverse:UIButton!
    private weak var layoutButtonTriggerLeft:NSLayoutConstraint!
    private let kButtonsWidth:CGFloat = 60
    private let kButtonsHeight:CGFloat = 50
    private let kButtonTriggerSize:CGFloat = 90
    private let kButtonsAlphaBlocked:CGFloat = 0.3
    private let kButtonsAlpha:CGFloat = 1
    
    convenience init(controller:CCameraShoot)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let buttonBack:UIButton = UIButton()
        buttonBack.translatesAutoresizingMaskIntoConstraints = false
        buttonBack.setImage(
            #imageLiteral(resourceName: "assetGenericBackDown").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonBack.setImage(
            #imageLiteral(resourceName: "assetGenericBackDown").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonBack.imageView!.contentMode = UIViewContentMode.center
        buttonBack.imageView!.clipsToBounds = true
        buttonBack.imageView!.tintColor = UIColor(white:1, alpha:kButtonsAlphaBlocked)
        buttonBack.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonBack = buttonBack
        
        let buttonReverse:UIButton = UIButton()
        buttonReverse.isUserInteractionEnabled = false
        buttonReverse.alpha = kButtonsAlphaBlocked
        buttonReverse.translatesAutoresizingMaskIntoConstraints = false
        buttonReverse.setImage(
            #imageLiteral(resourceName: "assetCameraReverse").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonReverse.setImage(
            #imageLiteral(resourceName: "assetCameraReverse").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonReverse.imageView!.contentMode = UIViewContentMode.center
        buttonReverse.imageView!.clipsToBounds = true
        buttonReverse.imageView!.tintColor = UIColor(white:1, alpha:kButtonsAlphaBlocked)
        buttonReverse.addTarget(
            self,
            action:#selector(actionReverse(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonReverse = buttonReverse
        
        let buttonTrigger:VCameraShootMenuTrigger = VCameraShootMenuTrigger()
        buttonTrigger.isUserInteractionEnabled = false
        buttonTrigger.alpha = kButtonsAlphaBlocked
        buttonTrigger.addTarget(
            self,
            action:#selector(actionTrigger(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonTrigger = buttonTrigger
        
        addSubview(buttonBack)
        addSubview(buttonReverse)
        addSubview(buttonTrigger)
        
        let layoutButtonBackHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:buttonBack,
            constant:kButtonsHeight)
        let layoutButtonBackBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:buttonBack,
            toView:self)
        let layoutButtonBackLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:buttonBack,
            toView:self)
        let layoutButtonBackWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonBack,
            constant:kButtonsWidth)
        
        let layoutButtonReverseHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:buttonReverse,
            constant:kButtonsHeight)
        let layoutButtonReverseBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:buttonReverse,
            toView:self)
        let layoutButtonReverseRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:buttonReverse,
            toView:self)
        let layoutButtonReverseWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonReverse,
            constant:kButtonsWidth)
        
        let layoutButtonTriggerTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonTrigger,
            toView:self)
        layoutButtonTriggerLeft = NSLayoutConstraint.leftToLeft(
            view:buttonTrigger,
            toView:self)
        let layoutButtonTriggerWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonTrigger,
            constant:kButtonTriggerSize)
        let layoutButtonTriggerHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:buttonTrigger,
            constant:kButtonTriggerSize)
        
        addConstraints([
            layoutButtonBackHeight,
            layoutButtonBackBottom,
            layoutButtonBackLeft,
            layoutButtonBackWidth,
            layoutButtonReverseHeight,
            layoutButtonReverseBottom,
            layoutButtonReverseRight,
            layoutButtonReverseWidth,
            layoutButtonTriggerTop,
            layoutButtonTriggerLeft,
            layoutButtonTriggerWidth,
            layoutButtonTriggerHeight])
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainButtonTrigger:CGFloat = width - kButtonTriggerSize
        let marginLeftButtonTrigger:CGFloat = remainButtonTrigger / 2.0
        layoutButtonTriggerLeft.constant = marginLeftButtonTrigger
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionTrigger(sender button:VCameraShootMenuTrigger)
    {
        if controller.recording
        {
            controller.stopRecording()
        }
        else
        {
            controller.startRecording()
        }
    }
    
    func actionBack(sender button:UIButton)
    {
        button.isUserInteractionEnabled = false
        
        controller.back()
    }
    
    func actionReverse(sender button:UIButton)
    {
        blockReverse()
        controller.reverseCamera()
    }
    
    //MARK: private
    
    private func blockReverse()
    {
        buttonTrigger.isUserInteractionEnabled = false
        buttonReverse.isUserInteractionEnabled = false
        buttonBack.isUserInteractionEnabled = false
        buttonTrigger.alpha = kButtonsAlphaBlocked
        buttonReverse.alpha = kButtonsAlphaBlocked
        buttonBack.alpha = kButtonsAlphaBlocked
    }
    
    private func blockRecording()
    {
        buttonReverse.isUserInteractionEnabled = false
        buttonBack.isUserInteractionEnabled = false
        buttonReverse.alpha = kButtonsAlphaBlocked
        buttonBack.alpha = kButtonsAlphaBlocked
    }
    
    //MARK: public
    
    func activateButtons()
    {
        buttonTrigger.isUserInteractionEnabled = true
        buttonReverse.isUserInteractionEnabled = true
        buttonBack.isUserInteractionEnabled = true
        buttonTrigger.alpha = kButtonsAlpha
        buttonReverse.alpha = kButtonsAlpha
        buttonBack.alpha = kButtonsAlpha
    }
    
    func startRecording()
    {
        buttonTrigger.startRecording()
        blockRecording()
    }
    
    func stopRecording()
    {
        buttonTrigger.stopRecording()
        activateButtons()
    }
}
