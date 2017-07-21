import UIKit

class VSourceVideoTimeBarThumb:
    View<VSourceVideoTime, MSourceVideoTime, CSourceVideoTime>
{
    private let kImageMargin:CGFloat = -2
    private let kBorderWidth:CGFloat = 1
    
    required init(controller:CSourceVideoTime)
    {
        super.init(controller:controller)
        layer.borderWidth = kBorderWidth
        layer.borderColor = UIColor.black.cgColor
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.image = controller.model.item.image
        
        addSubview(imageView)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self,
            margin:kImageMargin)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
