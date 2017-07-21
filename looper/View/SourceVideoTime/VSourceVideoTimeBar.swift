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
        
        let blur:VBlur = VBlur.light()
        
        addSubview(backgroundImage)
        addSubview(blur)
        
        NSLayoutConstraint.equals(
            view:backgroundImage,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
