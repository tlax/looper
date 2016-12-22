import UIKit

class VHomeControlBlender:UIView
{
    private weak var viewMenu:VHomeControlBlenderMenu!
    private weak var viewBoard:VHomeControlBlenderBoard!
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
        
        let viewBoard:VHomeControlBlenderBoard = VHomeControlBlenderBoard()
        self.viewBoard = viewBoard
        
        addSubview(viewBoard)
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
        
        let layoutBoardTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:viewBoard,
            toView:self)
        let layoutBoardHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:viewBoard)
        let layoutBoardLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewBoard,
            toView:self)
        let layoutBoardRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewBoard,
            toView:self)
        
        addConstraints([
            layoutMenuHeight,
            layoutMenuBottom,
            layoutMenuLeft,
            layoutMenuRight,
            layoutBoardTop,
            layoutBoardHeight,
            layoutBoardLeft,
            layoutBoardRight])
    }
}
