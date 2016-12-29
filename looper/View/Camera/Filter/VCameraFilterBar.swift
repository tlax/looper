import UIKit

class VCameraFilterBar:UIView
{
    private weak var controller:CCameraFilter!
    private weak var layoutIconLeft:NSLayoutConstraint!
    private let kContentTop:CGFloat = 20
    private let kBackWidth:CGFloat = 60
    private let kIconWidth:CGFloat = 60
    
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
        
        let icon:UIImageView = UIImageView()
        icon.isUserInteractionEnabled = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.clipsToBounds = true
        icon.contentMode = UIViewContentMode.center
        icon.image = #imageLiteral(resourceName: "assetCameraFilter")
        
        addSubview(icon)
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
        
        let layoutIconTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:icon,
            toView:self,
            constant:kContentTop)
        let layoutIconBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:icon,
            toView:self)
        layoutIconLeft = NSLayoutConstraint.leftToLeft(
            view:icon,
            toView:self)
        let layoutIconWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:icon,
            constant:kIconWidth)
        
        addConstraints([
            layoutBackTop,
            layoutBackBottom,
            layoutBackLeft,
            layoutBackWidth,
            layoutIconTop,
            layoutIconBottom,
            layoutIconLeft,
            layoutIconWidth])
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainIcon:CGFloat = width - kIconWidth
        let margin:CGFloat = remainIcon / 2.0
        layoutIconLeft.constant = margin
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
}
