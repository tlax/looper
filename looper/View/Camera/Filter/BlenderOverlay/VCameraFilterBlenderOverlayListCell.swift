import UIKit

class VCameraFilterBlenderOverlayListCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private let kBorderWidth:CGFloat = 3
    private let kAlphaNotSelected:CGFloat = 0.7
    private let kAlphaSelected:CGFloat = 1
    private let kCornerRadius:CGFloat = 6
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = kBorderWidth
        imageView.layer.cornerRadius = kCornerRadius
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
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: private
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            alpha = kAlphaSelected
            imageView.layer.borderColor = UIColor.genericLight.cgColor
        }
        else
        {
            alpha = kAlphaNotSelected
            imageView.layer.borderColor = UIColor(white:0.9, alpha:1).cgColor
        }
    }
    
    //MARK: public
    
    func config(model:MCameraRecord)
    {
        imageView.image = model.items.first?.image
        hover()
    }
}
