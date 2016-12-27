import UIKit

class VHomePlayer:UIView
{
    weak var viewTimer:VHomePlayerTimer!
    weak var viewBoard:VHomePlayerBoard!
    private weak var controller:CHome!
    private let kBoardHeight:CGFloat = 60
    private let kTimerHeight:CGFloat = 40
    private let kTimerBottom:CGFloat = -5
    
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
        
        let viewTimer:VHomePlayerTimer = VHomePlayerTimer(
            controller:controller)
        self.viewTimer = viewTimer
        
        addSubview(viewBoard)
        addSubview(viewTimer)
        
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
        
        let layoutTimerHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:viewTimer,
            constant:kTimerHeight)
        let layoutTimerBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToTop(
            view:viewTimer,
            toView:viewBoard,
            constant:kTimerBottom)
        let layoutTimerLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewTimer,
            toView:self)
        let layouttimerRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewTimer,
            toView:self)
        
        addConstraints([
            layoutBoardHeight,
            layoutBoardBottom,
            layoutBoardLeft,
            layoutBoardRight,
            layoutTimerHeight,
            layoutTimerBottom,
            layoutTimerLeft,
            layouttimerRight])
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedImagesUpdated(sender:)),
            name:Notification.imagesUpdated,
            object:nil)
        
        refresh()
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: notifications
    
    func notifiedImagesUpdated(sender notification:Notification)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.refresh()
        }
    }
    
    //MARK: public
    
    func refresh()
    {
        viewBoard.buttonMain.forceStop()
        
        if controller.modelImage.renderedSequence == nil
        {
            viewBoard.blocked()
            viewTimer.blocked()
        }
        else
        {
            viewBoard.notBlocked()
            viewTimer.notBlocked()
        }
    }
    
    func playingNotBlocking()
    {
        viewBoard.notBlocked()
        viewTimer.notBlocked()
    }
    
    func playingBlocking()
    {
        viewBoard.partialBlocked()
        viewTimer.blocked()
    }
}
