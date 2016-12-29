import UIKit

class VCameraFilterBar:UIView
{
    private weak var controller:CCameraFilter!
    private let kContentTop:CGFloat = 20
    private let kBackWidth:CGFloat = 60
    
    convenience init(controller:CCameraFilter)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        clipsToBounds = true
        self.controller = controller
        
        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBackDown").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.normal)
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBackDown").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        backButton.imageView!.contentMode = UIViewContentMode.center
        backButton.imageView!.clipsToBounds = true
        backButton.imageView!.tintColor = UIColor.red
        backButton.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(backButton)
        
        let layoutBackTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:backButton,
            toView:self,
            constant:kContentTop)
        let layoutBackBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:backButton,
            toView:self)
        let layoutBackLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:backButton,
            toView:self)
        let layoutBackWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:backButton,
            constant:kBackWidth)
        
        addConstraints([
            layoutBackTop,
            layoutBackBottom,
            layoutBackLeft,
            layoutBackWidth])
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
}
