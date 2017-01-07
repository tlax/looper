import UIKit

class VCameraFilterNoneCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var layoutImageWidth:NSLayoutConstraint!
    private weak var layoutImageLeft:NSLayoutConstraint!
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
        
        let layoutImageTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self)
        let layoutImageBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:imageView,
            toView:self)
        layoutImageWidth = NSLayoutConstraint.width(
            view:imageView)
        layoutImageLeft = NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        
        addConstraints([
            layoutImageTop,
            layoutImageBottom,
            layoutImageWidth,
            layoutImageLeft])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        let remain:CGFloat = width - height
        let margin:CGFloat = remain / 2.0
        let cornerRadius:CGFloat = height / 2.0
        imageView.layer.cornerRadius = cornerRadius
        layoutImageWidth.constant = height
        layoutImageLeft.constant = margin
        
        super.layoutSubviews()
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
