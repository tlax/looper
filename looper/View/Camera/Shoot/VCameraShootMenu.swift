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
        
        NSLayoutConstraint.height(
            view:buttonBack,
            constant:kButtonsHeight)
        NSLayoutConstraint.bottomToBottom(
            view:buttonBack,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:buttonBack,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonBack,
            constant:kButtonsWidth)
        
        NSLayoutConstraint.height(
            view:buttonReverse,
            constant:kButtonsHeight)
        NSLayoutConstraint.bottomToBottom(
            view:buttonReverse,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:buttonReverse,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonReverse,
            constant:kButtonsWidth)
        
        NSLayoutConstraint.topToTop(
            view:buttonTrigger,
            toView:self)
        NSLayoutConstraint.height(
            view:buttonTrigger,
            constant:kButtonTriggerSize)
        layoutButtonTriggerLeft = NSLayoutConstraint.leftToLeft(
            view:buttonTrigger,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonTrigger,
            constant:kButtonTriggerSize)
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
