import UIKit

class VCameraPreviewPlayer:UIView
{
    weak var buttonPlay:VCameraPreviewPlayerButton!
    private weak var controller:CCameraPreview!
    private let kPlayHeight:CGFloat = 60
    
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
        
        addSubview(buttonPlay)
        
        let layoutPlayTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonPlay,
            toView:self)
        let layoutPlayHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:buttonPlay,
            constant:kPlayHeight)
        let layoutPlayLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:buttonPlay,
            toView:self)
        let layoutPlayRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:buttonPlay,
            toView:self)
        
        addConstraints([
            layoutPlayTop,
            layoutPlayHeight,
            layoutPlayLeft,
            layoutPlayRight])
    }
}
