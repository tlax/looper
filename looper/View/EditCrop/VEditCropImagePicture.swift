import UIKit

class VEditCropImagePicture:View<VEditCrop, MEditCrop, CEditCrop>
{
    weak var image:UIImage?
    weak var layoutLeft:NSLayoutConstraint!
    weak var layoutRight:NSLayoutConstraint!
    weak var layoutTop:NSLayoutConstraint!
    weak var layoutBottom:NSLayoutConstraint!
    private let kBorderWidth:CGFloat = 1
    
    required init(controller:CEditCrop)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.layer.borderWidth = kBorderWidth
        imageView.layer.borderColor = UIColor(white:1, alpha:0.5).cgColor
        
        addSubview(imageView)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
        
        guard
            
            let cgImage:CGImage = controller.model.edit.sequence?.items.first?.image
            
        else
        {
            return
        }
        
        let image:UIImage = UIImage(cgImage:cgImage)
        imageView.image = image
        self.image = image
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
