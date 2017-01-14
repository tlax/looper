import UIKit

class VCameraPreviewPlayer:UIView
{
    weak var buttonPlay:VCameraPreviewPlayerButton!
    weak var viewTimer:VCameraPreviewPlayerTimer!
    private weak var controller:CCameraPreview!
    private let kPlayHeight:CGFloat = 70
    private let kPlayTop:CGFloat = 25
    private let kTimerHeight:CGFloat = 80
    private let kTimerTop:CGFloat = 20
    
    convenience init(controller:CCameraPreview)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let buttonPlay:VCameraPreviewPlayerButton = VCameraPreviewPlayerButton(
            controller:controller)
        self.buttonPlay = buttonPlay
        
        let viewTimer:VCameraPreviewPlayerTimer = VCameraPreviewPlayerTimer(
            controller:controller)
        self.viewTimer = viewTimer
        
        addSubview(buttonPlay)
        addSubview(viewTimer)
        
        let constraintsPlayHorizontal:[NSLayoutConstraint] = NSLayoutConstraint.equalsHorizontal(
            view:buttonPlay,
            toView:self)
        let constraintsTimerHorizontal:[NSLayoutConstraint] = NSLayoutConstraint.equalsHorizontal(
            view:viewTimer,
            toView:self)
        
        let layoutPlayTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonPlay,
            toView:self,
            constant:kPlayTop)
        let layoutPlayHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:buttonPlay,
            constant:kPlayHeight)
        
        let layoutTimerTop:NSLayoutConstraint = NSLayoutConstraint.topToBottom(
            view:viewTimer,
            toView:buttonPlay,
            constant:kTimerTop)
        let layoutTimerHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:viewTimer,
            constant:kTimerHeight)
        
        addConstraints(constraintsPlayHorizontal)
        addConstraints(constraintsTimerHorizontal)
        
        addConstraints([
            layoutPlayTop,
            layoutPlayHeight,
            layoutTimerTop,
            layoutTimerHeight])
    }
}
