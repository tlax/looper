import UIKit

class VCameraFilterBlenderOverlayListCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private let kBorderWidth:CGFloat = 2
    private let kAlphaNotSelected:CGFloat = 0.7
    private let kAlphaSelected:CGFloat = 1
    
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
        self.imageView = imageView
        
        addSubview(imageView)
        
        let constraintsImage:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
        
        addConstraints(constraintsImage)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
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
            imageView.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    //MARK: public
    
    func config(model:MCameraRecord)
    {
        imageView.image = model.items.first?.image
        hover()
    }
}
