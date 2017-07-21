import UIKit

class VCreateMenuCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var labelTitle:UILabel!
    private var image:UIImage?
    private let kCornerRadius:CGFloat = 3
    private let kBorderWidth:CGFloat = 1
    private let kImageHeight:CGFloat = 60
    private let kTitleHeight:CGFloat = 25
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        layer.cornerRadius = kCornerRadius
        layer.borderWidth = kBorderWidth
        layer.borderColor = UIColor(white:0, alpha:0.1).cgColor
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.tintColor = UIColor.white
        self.imageView = imageView
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.font = UIFont.regular(size:12)
        self.labelTitle = labelTitle
        
        addSubview(imageView)
        addSubview(labelTitle)
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self)
        NSLayoutConstraint.height(
            view:imageView,
            constant:kImageHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
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
            backgroundColor = UIColor.colourSuccess
            labelTitle.textColor = UIColor.white
            imageView.image = image?.withRenderingMode(
                UIImageRenderingMode.alwaysTemplate)
        }
        else
        {
            backgroundColor = UIColor.white
            labelTitle.textColor = UIColor.black
            imageView.image = image?.withRenderingMode(
                UIImageRenderingMode.alwaysOriginal)
        }
    }
    
    //MARK: public
    
    func config(model:MSourceProtocol)
    {
        image = model.icon
        labelTitle.text = model.title
        
        hover()
    }
}
