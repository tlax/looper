import UIKit

class VHomePlayer:UIView
{
    private weak var controller:CHome!
    private weak var viewBoard:VHomePlayerBoard!
    private let kMainWidth:CGFloat = 70
    private let kBoardHeight:CGFloat = 60
    
    convenience init(controller:CHome)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.genericDark
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let viewBoard:VHomePlayerBoard = VHomePlayerBoard(
            controller:controller)
        self.viewBoard = viewBoard
        
        addSubview(viewBoard)
        
        let layoutBoardHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:viewBoard,
            constant:kBoardHeight)
        let layoutBoardBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:viewBoard,
            toView:self)
        let layoutBoardLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewBoard,
            toView:self)
        let layoutBoardRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewBoard,
            toView:self)
        
        addConstraints([
            layoutBoardHeight,
            layoutBoardBottom,
            layoutBoardLeft,
            layoutBoardRight])
    }
}
