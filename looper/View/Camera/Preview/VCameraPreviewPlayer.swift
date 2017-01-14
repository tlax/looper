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
        
        NSLayoutConstraint.equalsHorizontal(
            view:buttonPlay,
            toView:self)
        NSLayoutConstraint.topToTop(
            view:buttonPlay,
            toView:self,
            constant:kPlayTop)
        NSLayoutConstraint.height(
            view:buttonPlay,
            constant:kPlayHeight)
        
        NSLayoutConstraint.equalsHorizontal(
            view:viewTimer,
            toView:self)
        NSLayoutConstraint.topToBottom(
            view:viewTimer,
            toView:buttonPlay,
            constant:kTimerTop)
        NSLayoutConstraint.height(
            view:viewTimer,
            constant:kTimerHeight)
    }
}
