import UIKit

class VCameraViewLoaderFrames:UIView
{
    private weak var controller:CCameraVideoLoader!
    private let kCornerRadius:CGFloat = 14
    
    init(controller:CCameraVideoLoader)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
