import UIKit

class VCreateItemsCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var layoutImageWidth:NSLayoutConstraint!
    private let kImageLeft:CGFloat = 10
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.isUserInteractionEnabled = false
        self.imageView = imageView
        
        addSubview(imageView)
        
        NSLayoutConstraint.equalsVertical(
            view:imageView,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self,
            constant:kImageLeft)
        layoutImageWidth = NSLayoutConstraint.width(
            view:imageView)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let height:CGFloat = bounds.height
        layoutImageWidth.constant = height
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func config(model:MCreateItem)
    {
        guard
        
            let cgImage:CGImage = model.frames.first?.image
        
        else
        {
            imageView.image = nil
            
            return
        }
        
        let image:UIImage = UIImage(cgImage:cgImage)
        imageView.image = image
    }
}
