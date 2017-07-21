import UIKit

class VSourceVideoTimeBar:
View<VSourceVideoTime, MSourceVideoTime, CSourceVideoTime>
{
    required init(controller:CSourceVideoTime)
    {
        super.init(controller:controller)
        
        let backgroundImage:UIImageView = UIImageView()
        backgroundImage.isUserInteractionEnabled = false
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.clipsToBounds = true
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        backgroundImage.image = controller.model.item.image
        
        addSubview(backgroundImage)
        
        NSLayoutConstraint.equals(
            view:backgroundImage,
            toView:self)
    }
    
    required init?(coder: NSCoder)
    {
        return nil
    }
}
