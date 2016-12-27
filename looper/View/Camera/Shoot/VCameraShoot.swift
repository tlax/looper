import UIKit

class VCameraShoot:VView
{
    weak var viewMenu:VCameraShootMenu!
    private weak var controller:CCameraShoot!
    private let kMenuHeight:CGFloat = 90
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.black
        self.controller = controller as? CCameraShoot
        
        let viewMenu:VCameraShootMenu = VCameraShootMenu(
            controller:self.controller)
        self.viewMenu = viewMenu
        
        addSubview(viewMenu)
        
        let layoutMenuHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:viewMenu,
            constant:kMenuHeight)
        let layoutMenuBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:viewMenu,
            toView:self)
        let layoutMenuLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewMenu,
            toView:self)
        let layoutMenuRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewMenu,
            toView:self)
        
        addConstraints([
            layoutMenuHeight,
            layoutMenuBottom,
            layoutMenuLeft,
            layoutMenuRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
