import UIKit

class VEditBar:View<VEdit, MEdit, CEdit>
{
    private let kBorderHeight:CGFloat = 1
    
    required init(controller:CEdit)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        
        let border:VBorder = VBorder(colour:UIColor(white:0, alpha:0.2))
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        
        addSubview(imageView)
        addSubview(border)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        guard
        
            let cgImage:CGImage = controller.model.sequence?.items.first?.image
        
        else
        {
            return
        }
        
        let image:UIImage = UIImage(cgImage:cgImage)
        imageView.image = image
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
