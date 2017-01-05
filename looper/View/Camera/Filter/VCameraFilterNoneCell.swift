import UIKit

class VCameraFilterNoneCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private let kAlphaNotHover:CGFloat = 1
    private let kAlphaHover:CGFloat = 0.5
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        self.imageView = imageView
        
        addSubview(imageView)
        
        let constraintsImage:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:imageView,
            parent:self)
        
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
            alpha = kAlphaHover
        }
        else
        {
            alpha = kAlphaNotHover
        }
    }
    
    //MARK: public
    
    func config(model:MCameraRecord)
    {
        var image:UIImage?
        
        for item:MCameraRecordItem in model.items
        {
            if item.active
            {
                image = item.image
                
                break
            }
        }
        
        imageView.image = image
        hover()
    }
}