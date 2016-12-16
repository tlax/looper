import UIKit

class VHome:VView
{
    weak var viewControl:VHomeControl!
    weak var viewTimeline:VHomeTimeline!
    weak var viewDisplay:VHomeDisplay!
    private weak var controller:CHome!
    private weak var layoutControlBottom:NSLayoutConstraint!
    private weak var layoutDisplayHeight:NSLayoutConstraint!
    private let kControlMinHeight:CGFloat = 64
    private let kTimelineHeight:CGFloat = 80
    private let kAnimationDurationCamera:TimeInterval = 0.3
    
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
        
        let totalHeight:CGFloat = bounds.maxY
        let controlBottom:CGFloat = kControlMinHeight - totalHeight
        
        let layoutControlTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:viewControl,
            toView:self,
            constant:0)
        layoutControlBottom = NSLayoutConstraint.bottomToBottom(
            view:viewControl,
            toView:self,
            constant:controlBottom)
        let layoutControlLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewControl,
            toView:self,
            constant:0)
        let layoutControlRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewControl,
            toView:self,
            constant:0)
        
        let layoutTimelineTop:NSLayoutConstraint = NSLayoutConstraint.topToBottom(
            view:viewTimeline,
            toView:viewControl,
            constant:0)
        let layoutTimelineHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:viewTimeline,
            constant:kControlMinHeight)
        let layoutTimelineLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewTimeline,
            toView:self,
            constant:0)
        let layoutTimelineRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewTimeline,
            toView:self,
            constant:0)
        
        let layoutDisplayTop:NSLayoutConstraint = NSLayoutConstraint.topToBottom(
            view:viewDisplay,
            toView:viewTimeline,
            constant:0)
        layoutDisplayHeight = NSLayoutConstraint.height(
            view:viewDisplay,
            constant:0)
        let layoutDisplayLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewDisplay,
            toView:self,
            constant:0)
        let layoutDisplayRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewDisplay,
            toView:self,
            constant:0)
        
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
        layoutControlBottom.constant = 0
        
        UIView.animate(
            withDuration:kAnimationDurationCamera)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
}
