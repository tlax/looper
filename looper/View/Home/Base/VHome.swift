import UIKit

class VHome:VView
{
    weak var viewControl:VHomeControl!
    weak var viewTimeline:VHomeTimeline!
    weak var viewDisplay:VHomeDisplay!
    private weak var controller:CHome!
    private weak var layoutControlBottom:NSLayoutConstraint!
    private weak var layoutDisplayHeight:NSLayoutConstraint!
    private let kTimelineHeight:CGFloat = 97
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
        
        addSubview(viewDisplay)
        addSubview(viewTimeline)
        addSubview(viewControl)
        
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
            view:viewDisplay)
        let layoutDisplayLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewDisplay,
            toView:self)
        let layoutDisplayRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewDisplay,
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
            layoutDisplayRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
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
