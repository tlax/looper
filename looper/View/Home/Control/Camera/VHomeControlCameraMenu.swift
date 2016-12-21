import UIKit

class VHomeControlCameraMenu:UIView
{
    private weak var controller:CHome!
    private weak var buttonTrigger:VHomeControlCameraMenuTrigger!
    private weak var buttonBack:UIButton!
    private weak var buttonReverse:UIButton!
    private weak var layoutButtonTriggerLeft:NSLayoutConstraint!
    private let kButtonsWidth:CGFloat = 60
    private let kButtonsHeight:CGFloat = 50
    private let kButtonTriggerSize:CGFloat = 100
    private let kButtonsAlphaBlocked:CGFloat = 0.2
    private let kButtonsAlpha:CGFloat = 1
    
    convenience init(controller:CHome)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let buttonBack:UIButton = UIButton()
        buttonBack.translatesAutoresizingMaskIntoConstraints = false
        buttonBack.setImage(
            #imageLiteral(resourceName: "assetHomeCameraBack").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonBack.setImage(
            #imageLiteral(resourceName: "assetHomeCameraBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonBack.imageView!.contentMode = UIViewContentMode.center
        buttonBack.imageView!.clipsToBounds = true
        buttonBack.imageView!.tintColor = UIColor(white:1, alpha:0.1)
        buttonBack.imageEdgeInsets = UIEdgeInsets(
            top:5,
            left:0,
            bottom:0,
            right:10)
        buttonBack.addTarget(
            self,
            action:#selector(self.actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonBack = buttonBack
        
        let buttonReverse:UIButton = UIButton()
        buttonReverse.translatesAutoresizingMaskIntoConstraints = false
        buttonReverse.setImage(
            #imageLiteral(resourceName: "assetHomeCameraReverse").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonReverse.setImage(
            #imageLiteral(resourceName: "assetHomeCameraReverse").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonReverse.imageView!.contentMode = UIViewContentMode.center
        buttonReverse.imageView!.clipsToBounds = true
        buttonReverse.imageView!.tintColor = UIColor(white:1, alpha:0.1)
        buttonReverse.addTarget(
            self,
            action:#selector(self.actionReverse(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonReverse = buttonReverse
        
        let buttonTrigger:VHomeControlCameraMenuTrigger = VHomeControlCameraMenuTrigger(
            controller:controller)
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
    
    func actionBack(sender button:UIButton)
    {
        button.isUserInteractionEnabled = false
        
        if buttonTrigger.active
        {
            controller.viewHome.viewControl.viewCamera?.actionTrigger(
                activate:false)
        }
        
        controller.viewHome.hideCamera()
    }
    
    func actionReverse(sender button:UIButton)
    {
        controller.viewHome.viewControl.viewCamera?.reverseCamera()
    }
    
    //MARK: public
    
    func blockButtons()
    {
        buttonReverse.isUserInteractionEnabled = false
        buttonBack.isUserInteractionEnabled = false
        buttonReverse.alpha = kButtonsAlphaBlocked
        buttonBack.alpha = kButtonsAlphaBlocked
    }
    
    func releaseButtons()
    {
        buttonReverse.isUserInteractionEnabled = true
        buttonBack.isUserInteractionEnabled = true
        buttonReverse.alpha = kButtonsAlpha
        buttonBack.alpha = kButtonsAlpha
    }
}
