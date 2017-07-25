import UIKit

class VSourceVideoTimeBarThumb:
    View<VSourceVideoTime, MSourceVideoTime, CSourceVideoTime>
{
    private let kBorderWidth:CGFloat = 5
    
    required init(controller:CSourceVideoTime)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        layer.borderWidth = kBorderWidth
        layer.borderColor = UIColor.white.cgColor
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.image = controller.model.item.image
        
        addSubview(imageView)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
