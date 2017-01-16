import UIKit

class VCameraRotateImage:UIView
{
    private weak var controller:CCameraRotate!
    private weak var imageView:UIImageView!
    private weak var border:VBorder!
    private weak var layoutBorderTop:NSLayoutConstraint!
    private weak var layoutBorderLeft:NSLayoutConstraint!
    private weak var layoutBorderHeight:NSLayoutConstraint!
    private weak var layoutBorderWidth:NSLayoutConstraint!
    private let kImageMargin:CGFloat = 120
    private let kImageBorder:CGFloat = 2
    
    init(controller:CCameraRotate)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.image = controller.record.items.first?.image
        self.imageView = imageView
        
        addSubview(imageView)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self,
            margin:kImageMargin)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
    }
}
