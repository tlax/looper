import UIKit

class VHomeControlCameraTicker:UIView
{
    private weak var controller:CHome!
    private weak var viewProcess:VHomeControlCameraTickerProcess!
    private weak var viewFrames:VHomeControlCameraTickerFrames!
    private weak var layoutProcessWidth:NSLayoutConstraint!
    private weak var layoutFramesWidth:NSLayoutConstraint!
    
    convenience init(controller:CHome)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let viewProcess:VHomeControlCameraTickerProcess = VHomeControlCameraTickerProcess()
        self.viewProcess = viewProcess
        
        let viewFrames:VHomeControlCameraTickerFrames = VHomeControlCameraTickerFrames(
            controller:controller)
        self.viewFrames = viewFrames
        
        addSubview(viewProcess)
        addSubview(viewFrames)
        
        let layoutProcessTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:viewProcess,
            toView:self)
        let layoutProcessBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:viewProcess,
            toView:self)
        let layoutProcessLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewProcess,
            toView:viewFrames)
        layoutProcessWidth = NSLayoutConstraint.width(
            view:viewProcess)
        
        let layoutFramesTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:viewFrames,
            toView:self)
        let layoutFramesBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:viewFrames,
            toView:self)
        let layoutFramesLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewFrames,
            toView:self)
        layoutFramesWidth = NSLayoutConstraint.width(
            view:viewFrames)
        
        addConstraints([
            layoutProcessTop,
            layoutProcessBottom,
            layoutProcessLeft,
            layoutProcessWidth,
            layoutFramesTop,
            layoutFramesBottom,
            layoutFramesLeft,
            layoutFramesWidth])
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let width_2:CGFloat = width / 2.0
        layoutFramesWidth.constant = width_2
        layoutProcessWidth.constant = width_2
        
        super.layoutSubviews()
    }
}
