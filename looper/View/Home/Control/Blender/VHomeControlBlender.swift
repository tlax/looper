import UIKit

class VHomeControlBlender:UIView
{
    weak var viewMenu:VHomeControlBlenderMenu!
    weak var viewBoard:VHomeControlBlenderBoard!
    weak var viewPieces:VHomeControlBlenderPieces!
    weak var viewGesturer:VHomeControlBlenderGesturer!
    private weak var layoutBoardHeight:NSLayoutConstraint!
    private weak var layoutPiecesHeight:NSLayoutConstraint!
    private weak var layoutGesturerHeight:NSLayoutConstraint!
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
        
        let viewGesturer:VHomeControlBlenderGesturer = VHomeControlBlenderGesturer(
            controller:controller)
        self.viewGesturer = viewGesturer
        
        addSubview(viewBoard)
        addSubview(viewPieces)
        addSubview(viewGesturer)
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
        
        let layoutGesturerTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:viewGesturer,
            toView:self)
        layoutGesturerHeight = NSLayoutConstraint.height(
            view:viewGesturer)
        let layoutGesturerLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewGesturer,
            toView:self)
        let layoutGesturerRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewGesturer,
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
            layoutPiecesRight,
            layoutGesturerTop,
            layoutGesturerHeight,
            layoutGesturerLeft,
            layoutGesturerRight])
    }
    
    override func layoutSubviews()
    {
        let totalHeight:CGFloat = bounds.maxY
        let usableHeight:CGFloat = totalHeight - kMenuHeight
        
        if usableHeight >= 0
        {
            layoutBoardHeight.constant = usableHeight
            layoutPiecesHeight.constant = usableHeight
            layoutGesturerHeight.constant = usableHeight
        }
        
        super.layoutSubviews()
    }
}
