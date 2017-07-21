import UIKit

class VSourceVideoCell:UICollectionViewCell
{
    private weak var model:MSourceVideoItem?
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
    
    //MARK: private
    
    private func refresh()
    {
        imageView.image = model?.image
    }
    
    //MARK: public
    
    func config(model:MSourceVideoItem)
    {
        self.model = model
        refresh()
        
        if model.image == nil
        {
            model.requestImage
            { [weak self] in
                
                self?.refresh()
            }
        }
    }
}
