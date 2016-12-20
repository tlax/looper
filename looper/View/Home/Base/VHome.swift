import UIKit

class VHome:VView
{
    weak var viewControl:VHomeControl!
    weak var viewTimeline:VHomeTimeline!
    weak var viewDisplay:VHomeDisplay!
    weak var viewPlayer:VHomePlayer!
    private weak var controller:CHome!
    private weak var layoutControlBottom:NSLayoutConstraint!
    private weak var layoutDisplayHeight:NSLayoutConstraint!
    private weak var layoutPlayerHeight:NSLayoutConstraint!
    private let kTimelineHeight:CGFloat = 35
    private let kPlayerMinHeight:CGFloat = 80
    private let kAnimationDurationCamera:TimeInterval = 0.6
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CHome
        
        let viewControl:VHomeControl = VHomeControl(controller:self.controller)
        self.viewControl = viewControl
        
        let viewTimeline:VHomeTimeline = VHomeTimeline(controller:self.controller)
        self.viewTimeline = viewTimeline
        
        let viewDisplay:VHomeDisplay = VHomeDisplay(controller:self.controller)
        self.viewDisplay = viewDisplay
        
        let viewPlayer:VHomePlayer = VHomePlayer(controller:self.controller)
        self.viewPlayer = viewPlayer
        
        addSubview(viewDisplay)
        addSubview(viewTimeline)
        addSubview(viewControl)
        addSubview(viewPlayer)
        
        let totalHeight:CGFloat = UIScreen.main.bounds.maxY
        let controlBottom:CGFloat = viewControl.kCollectionHeight - totalHeight
        
        let layoutControlTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:viewControl,
            toView:self)
        layoutControlBottom = NSLayoutConstraint.bottomToBottom(
            view:viewControl,
            toView:self,
            constant:controlBottom)
        let layoutControlLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewControl,
            toView:self)
        let layoutControlRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewControl,
            toView:self)
        
        let layoutTimelineTop:NSLayoutConstraint = NSLayoutConstraint.topToBottom(
            view:viewTimeline,
            toView:viewControl)
        let layoutTimelineHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:viewTimeline,
            constant:kTimelineHeight)
        let layoutTimelineLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewTimeline,
            toView:self)
        let layoutTimelineRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewTimeline,
            toView:self)
        
        let layoutDisplayTop:NSLayoutConstraint = NSLayoutConstraint.topToBottom(
            view:viewDisplay,
            toView:viewTimeline)
        layoutDisplayHeight = NSLayoutConstraint.height(
            view:viewDisplay,
            constant:kPlayerMinHeight)
        let layoutDisplayLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewDisplay,
            toView:self)
        let layoutDisplayRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewDisplay,
            toView:self)
        
        let layoutPlayerTop:NSLayoutConstraint = NSLayoutConstraint.topToBottom(
            view:viewPlayer,
            toView:viewDisplay)
        layoutPlayerHeight = NSLayoutConstraint.height(
            view:viewPlayer,
            constant:kPlayerMinHeight)
        let layoutPlayerLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewPlayer,
            toView:self)
        let layoutPlayerRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewPlayer,
            toView:self)
        
        addConstraints([
            layoutControlTop,
            layoutControlBottom,
            layoutControlLeft,
            layoutControlRight,
            layoutTimelineTop,
            layoutTimelineHeight,
            layoutTimelineLeft,
            layoutTimelineRight,
            layoutDisplayTop,
            layoutDisplayHeight,
            layoutDisplayLeft,
            layoutDisplayRight,
            layoutPlayerTop,
            layoutPlayerHeight,
            layoutPlayerLeft,
            layoutPlayerRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let totalWidth:CGFloat = bounds.maxX
        let totalHeight:CGFloat = bounds.maxY
        let displayHeight:CGFloat
        let playerHeight:CGFloat
        
        if totalWidth < totalHeight
        {
            displayHeight = totalWidth
            playerHeight = totalHeight - (viewControl.kCollectionHeight + kTimelineHeight + totalWidth)
        }
        else
        {
            playerHeight = kPlayerMinHeight
            displayHeight = totalHeight - (viewControl.kCollectionHeight + kTimelineHeight + kPlayerMinHeight)
        }
        
        layoutDisplayHeight.constant = displayHeight
        layoutPlayerHeight.constant = playerHeight
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func showCamera()
    {
        viewControl.showCamera()
        layoutControlBottom.constant = viewControl.kCollectionHeight
        
        UIView.animate(
            withDuration:kAnimationDurationCamera,
            animations:
        { [weak self] in
            
            self?.layoutIfNeeded()
        })
        { [weak self] (done:Bool) in
            
            self?.controller.parentController.changeBar(barHidden:true)
        }
    }
    
    func hideCamera()
    {
        let totalHeight:CGFloat = bounds.maxY
        layoutControlBottom.constant = viewControl.kCollectionHeight - totalHeight
        
        UIView.animate(
            withDuration:kAnimationDurationCamera,
            animations:
        { [weak self] in
            
            self?.layoutIfNeeded()
        })
        { [weak self] (done:Bool) in
            
            self?.viewTimeline.refresh()
            self?.viewControl.hideCamera()
            self?.controller.parentController.changeBar(barHidden:false)
        }
    }
}
