import UIKit

class VCameraCropImage:UIView
{
    private weak var controller:CCameraCrop!
    private weak var imageView:UIImageView!
    private weak var layoutImageTop:NSLayoutConstraint!
    private weak var layoutImageBottom:NSLayoutConstraint!
    private weak var layoutImageLeft:NSLayoutConstraint!
    private weak var layoutImageRight:NSLayoutConstraint!
    private let kMinMargin:CGFloat = 60
    
    init(controller:CCameraCrop)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.image = controller.record.items.first?.image
        self.imageView = imageView
        
        addSubview(imageView)
        
        layoutImageTop = NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self)
        layoutImageBottom = NSLayoutConstraint.bottomToBottom(
            view:imageView,
            toView:self)
        layoutImageLeft = NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        layoutImageRight = NSLayoutConstraint.rightToRight(
            view:imageView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        
        if width <= height
        {
            let deltaSize:CGFloat = height - width
            let deltaSize_2:CGFloat = deltaSize / 2.0
            let marginDelta:CGFloat = kMinMargin + deltaSize_2
            
            layoutImageLeft.constant = kMinMargin
            layoutImageRight.constant = -kMinMargin
            layoutImageTop.constant = marginDelta
            layoutImageBottom.constant = -marginDelta
        }
        else
        {
            let deltaSize:CGFloat = width - height
            let deltaSize_2:CGFloat = deltaSize / 2.0
            let marginDelta:CGFloat = kMinMargin + deltaSize_2
            
            layoutImageTop.constant = kMinMargin
            layoutImageBottom.constant = -kMinMargin
            layoutImageLeft.constant = marginDelta
            layoutImageRight.constant = -marginDelta
        }
        
        super.layoutSubviews()
    }
}
