import UIKit

class VCameraFilterBlenderCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var layoutImageLeft:NSLayoutConstraint!
    private let kImageTop:CGFloat = 200
    private let kImageSize:CGFloat = 80
    private let kAlphaSelected:CGFloat = 1
    private let kAlphaNotSelected:CGFloat = 0.3
    private let imageRadius:CGFloat
    
    override init(frame:CGRect)
    {
        imageRadius = kImageSize / 2.0
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.backgroundColor = UIColor.black
        imageView.layer.borderColor = UIColor(white:0.9, alpha:1).cgColor
        imageView.layer.borderWidth = 1
        self.imageView = imageView
        
        addSubview(imageView)
        
        let layoutImageTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self,
            constant:kImageTop)
        let layoutImageHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:imageView,
            constant:kImageSize)
        layoutImageLeft = NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        let layoutImageWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:imageView,
            constant:kImageSize)
        
        addConstraints([
            layoutImageTop,
            layoutImageHeight,
            layoutImageLeft,
            layoutImageWidth])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainImage:CGFloat = width - kImageSize
        let marginImage:CGFloat = remainImage / 2.0
        
        imageView.layer.cornerRadius = imageRadius
        layoutImageLeft.constant = marginImage
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
            alpha = kAlphaSelected
        }
        else
        {
            alpha = kAlphaNotSelected
        }
    }
    
    //MARK: public
    
    func config(model:MCameraRecord?)
    {
        imageView.image = model?.items.first?.image
    }
}
