import UIKit

class ViewParent:UIView
{
    let kAnimationDuration:TimeInterval = 0.25
    weak var panRecognizer:UIPanGestureRecognizer!
    private weak var controller:ControllerParent!
    private var panningX:CGFloat?
    private let kMaxXPanning:CGFloat = 60
    private let kMaxXDelta:CGFloat = 210
    private let kMinXDelta:CGFloat = 30
    
    init(controller:ControllerParent)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.white
        self.controller = controller
        
        let panRecognizer:UIPanGestureRecognizer = UIPanGestureRecognizer(
            target:self,
            action:#selector(actionPanRecognized(sender:)))
        panRecognizer.isEnabled = false
        self.panRecognizer = panRecognizer
        
        addGestureRecognizer(panRecognizer)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionPanRecognized(sender panGesture:UIPanGestureRecognizer)
    {
        let location:CGPoint = panGesture.location(in:self)
        let xPos:CGFloat = location.x
        
        switch panGesture.state
        {
        case UIGestureRecognizerState.began,
             UIGestureRecognizerState.possible:
            
            if xPos < kMaxXPanning
            {
                self.panningX = xPos
            }
            
            break
            
        case UIGestureRecognizerState.changed:
            
            if let panningX:CGFloat = self.panningX
            {
                var deltaX:CGFloat = xPos - panningX
                
                if deltaX > kMaxXDelta
                {
                    panRecognizer.isEnabled = false
                }
                else
                {
                    if deltaX < 0
                    {
                        deltaX = 0
                    }
                    
                    guard
                        
                        let topView:View = subviews.last as? View
                        
                    else
                    {
                        return
                    }
                    
                    topView.layoutLeft.constant = deltaX
                }
            }
            
            break
            
        case UIGestureRecognizerState.cancelled,
             UIGestureRecognizerState.ended,
             UIGestureRecognizerState.failed:
            
            if let panningX:CGFloat = self.panningX
            {
                let deltaX:CGFloat = xPos - panningX
                
                if deltaX > kMinXDelta
                {
                    gesturePop()
                }
                else
                {
                    gestureRestore()
                }
            }
            
            panningX = nil
            
            break
        }
    }
    
    //MARK: private
    
    private func gesturePop()
    {
        controller.pop(horizontal:ControllerParent.Horizontal.right)
    }
    
    private func gestureRestore()
    {
        guard
            
            let topView:ViewProtocol = subviews.last as? ViewProtocol
            
        else
        {
            return
        }
        
        topView.layoutLeft.constant = 0
        
        UIView.animate(withDuration:kAnimationDuration)
        {
            self.layoutIfNeeded()
        }
    }
}
