import UIKit

class VCameraFilterBlenderCell:UICollectionViewCell
{
    private weak var selector:UIImageView!
    private weak var imageView:UIImageView!
    private weak var background:UIView!
    private weak var layoutImageLeft:NSLayoutConstraint!
    private let kCornerRadius:CGFloat = 8
    private let kImageTop:CGFloat = 250
    private let kImageSize:CGFloat = 134
    private let kSelectorHeight:CGFloat = 75
    private let kAlphaSelected:CGFloat = 1
    private let kAlphaNotSelected:CGFloat = 0.25
    private let kBackgroundMargin:CGFloat = 3
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let selector:UIImageView = UIImageView()
        selector.isUserInteractionEnabled = false
        selector.translatesAutoresizingMaskIntoConstraints = false
        selector.clipsToBounds = true
        selector.image = #imageLiteral(resourceName: "assetCameraFilterBlenderSelect")
        selector.contentMode = UIViewContentMode.center
        self.selector = selector
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.backgroundColor = UIColor.black
        imageView.layer.cornerRadius = kCornerRadius
        self.imageView = imageView
        
        let background:UIView = UIView()
        background.isUserInteractionEnabled = false
        background.translatesAutoresizingMaskIntoConstraints = false
        background.clipsToBounds = true
        background.layer.cornerRadius = kCornerRadius + kBackgroundMargin
        self.background = background
        
        addSubview(selector)
        addSubview(background)
        addSubview(imageView)
        
        let constraintsBackground:[NSLayoutConstraint] = NSLayoutConstraint.equalsHorizontal(
            view:background,
            toView:imageView,
            margin:kBackgroundMargin)
        let constraintsSelectorHorizontal:[NSLayoutConstraint] = NSLayoutConstraint.equalsHorizontal(
            view:selector,
            toView:self)
        
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
        
        let layoutSelectorBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToTop(
            view:selector,
            toView:imageView)
        let layoutSelectorHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:selector,
            constant:kSelectorHeight)
        
        addConstraints(constraintsBackground)
        addConstraints(constraintsSelectorHorizontal)
        
        addConstraints([
            layoutImageTop,
            layoutImageHeight,
            layoutImageLeft,
            layoutImageWidth,
            layoutSelectorBottom,
            layoutSelectorHeight])
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
            selector.isHidden = false
            background.backgroundColor = UIColor.genericLight
        }
        else
        {
            alpha = kAlphaNotSelected
            selector.isHidden = true
            background.backgroundColor = UIColor(white:0.96, alpha:1)
        }
    }
    
    //MARK: public
    
    func config(model:MCameraRecord?)
    {
        imageView.image = model?.items.first?.image
        hover()
    }
}
