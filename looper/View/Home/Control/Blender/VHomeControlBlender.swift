import UIKit

class VHomeControlBlender:UIView
{
    private weak var viewMenu:VHomeControlBlenderMenu!
    private weak var controller:CHome!
    private let kMenuHeight:CGFloat = 50
    
    convenience init(controller:CHome)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.black
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let viewMenu:VHomeControlBlenderMenu = VHomeControlBlenderMenu(
            controller:controller)
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
}
