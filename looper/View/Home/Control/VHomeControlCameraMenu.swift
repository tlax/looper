import UIKit

class VHomeControlCameraMenu:UIView
{
    private weak var controller:CHome!
    private let kBackgroundHeight:CGFloat = 50
    private let kButtonBackWidth:CGFloat = 60
    
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
        buttonBack.addTarget(
            self,
            action:#selector(self.actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        background.addSubview(buttonBack)
        addSubview(background)
        
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
        
        addConstraints([
            layoutBackgroundHeight,
            layoutBackgroundBottom,
            layoutBackgroundLeft,
            layoutBackgroundRight,
            layoutButtonBackTop,
            layoutButtonBackBottom,
            layoutButtonBackLeft,
            layoutButtonBackWidth])
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        button.isUserInteractionEnabled = false
        controller.viewHome.hideCamera()
    }
}
