import UIKit

class VSourceVideoCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        self.imageView = imageView
        
        addSubview(imageView)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(model:MSourceVideoItem)
    {
        guard
        
            let image:UIImage = model.image
        
        else
        {
            model.requestImage
            { [weak self] (image:UIImage?) in
                
                self?.imageView.image = image
            }
            
            return
        }
        
        imageView.image = image
    }
}
