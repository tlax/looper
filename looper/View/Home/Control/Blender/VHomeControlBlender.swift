import UIKit

class VHomeControlBlender:UIView
{
    private weak var viewMenu:VHomeControlBlenderMenu!
    private weak var viewBoard:VHomeControlBlenderBoard!
    private weak var viewPieces:VHomeControlBlenderPieces!
    private weak var layoutBoardHeight:NSLayoutConstraint!
    private weak var layoutPiecesHeight:NSLayoutConstraint!
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
        
        let viewPieces:VHomeControlBlenderPieces = VHomeControlBlenderPieces()
        self.viewPieces = viewPieces
        
        addSubview(viewBoard)
        addSubview(viewPieces)
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
        layoutBoardHeight = NSLayoutConstraint.height(
            view:viewBoard)
        let layoutBoardLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewBoard,
            toView:self)
        let layoutBoardRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewBoard,
            toView:self)
        
        let layoutPiecesTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:viewPieces,
            toView:self)
        layoutPiecesHeight = NSLayoutConstraint.height(
            view:viewPieces)
        let layoutPiecesLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewPieces,
            toView:self)
        let layoutPiecesRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewPieces,
            toView:self)
        
        addConstraints([
            layoutMenuHeight,
            layoutMenuBottom,
            layoutMenuLeft,
            layoutMenuRight,
            layoutBoardTop,
            layoutBoardHeight,
            layoutBoardLeft,
            layoutBoardRight,
            layoutPiecesTop,
            layoutPiecesHeight,
            layoutPiecesLeft,
            layoutPiecesRight])
    }
}
