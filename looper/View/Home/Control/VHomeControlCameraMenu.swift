import UIKit

class VHomeControlCameraMenu:UIView
{
    private weak var controller:CHome!
    private weak var buttonTrigger:VHomeControlCameraMenuTrigger!
    private weak var layoutButtonTriggerLeft:NSLayoutConstraint!
    private let kBackgroundHeight:CGFloat = 50
    private let kButtonBackWidth:CGFloat = 60
    private let kButtonTriggerSize:CGFloat = 100
    
    convenience init(controller:CHome)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let background:UIView = UIView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.clipsToBounds = true
        background.backgroundColor = UIColor.genericDark
        
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
        
        let buttonTrigger:VHomeControlCameraMenuTrigger = VHomeControlCameraMenuTrigger(
            controller:controller)
        
        background.addSubview(buttonBack)
        addSubview(background)
        addSubview(buttonTrigger)
        
        let layoutBackgroundHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:background,
            constant:kBackgroundHeight)
        let layoutBackgroundBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:background,
            toView:self)
        let layoutBackgroundLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:background,
            toView:self)
        let layoutBackgroundRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:background,
            toView:self)
        
        let layoutButtonBackTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonBack,
            toView:background)
        let layoutButtonBackBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:buttonBack,
            toView:background)
        let layoutButtonBackLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:buttonBack,
            toView:background)
        let layoutButtonBackWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonBack,
            constant:kButtonBackWidth)
        
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
            layoutBackgroundHeight,
            layoutBackgroundBottom,
            layoutBackgroundLeft,
            layoutBackgroundRight,
            layoutButtonBackTop,
            layoutButtonBackBottom,
            layoutButtonBackLeft,
            layoutButtonBackWidth,
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
        controller.viewHome.hideCamera()
    }
}
