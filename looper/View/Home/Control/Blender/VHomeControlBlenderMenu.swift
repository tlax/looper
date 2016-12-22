import UIKit

class VHomeControlBlenderMenu:UIView
{
    private weak var controller:CHome!
    private let kButtonsWidth:CGFloat = 60
    private let kButtonsHeight:CGFloat = 50
    
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
        
        addSubview(buttonBack)
        
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

        addConstraints([
            layoutButtonBackHeight,
            layoutButtonBackBottom,
            layoutButtonBackLeft,
            layoutButtonBackWidth])
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        button.isUserInteractionEnabled = false
        controller.viewHome.hideBlender()
    }
}
