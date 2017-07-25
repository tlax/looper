import UIKit

class VNewSourceCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var backView:UIView!
    private weak var labelTitle:UILabel!
    private weak var layoutImageTop:NSLayoutConstraint!
    private weak var layoutImageLeft:NSLayoutConstraint!
    private var icon:UIImage?
    private let kImageSize:CGFloat = 50
    private let kTitleLeft:CGFloat = 10
    private let kTitleWidth:CGFloat = 200
    private let kBackgroundLeft:CGFloat = -12
    private let kBackgroundRight:CGFloat = 30
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let backView:UIView = UIView()
        backView.isUserInteractionEnabled = false
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.clipsToBounds = true
        backView.layer.cornerRadius = kImageSize / 2.0
        self.backView = backView
        
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
        labelTitle.font = UIFont.medium(size:12)
        self.labelTitle = labelTitle
        
        addSubview(backView)
        addSubview(imageView)
        addSubview(labelTitle)
        
        layoutImageTop = NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self)
        NSLayoutConstraint.size(
            view:imageView,
            constant:kImageSize)
        layoutImageLeft = NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.equalsVertical(
            view:backView,
            toView:imageView)
        NSLayoutConstraint.leftToLeft(
            view:backView,
            toView:imageView,
            constant:kBackgroundLeft)
        NSLayoutConstraint.rightToRight(
            view:backView,
            toView:self,
            constant:kBackgroundRight)
        
        NSLayoutConstraint.equalsVertical(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.leftToRight(
            view:labelTitle,
            toView:imageView,
            constant:kTitleLeft)
        NSLayoutConstraint.width(
            view:labelTitle,
            constant:kTitleWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let height:CGFloat = bounds.height
        let remainWidth:CGFloat = width - kImageSize
        let remainHeight:CGFloat = height - kImageSize
        let marginLeft:CGFloat = remainWidth / 2.0
        let marginTop:CGFloat = remainHeight / 2.0
        layoutImageLeft.constant = marginLeft
        layoutImageTop.constant = marginTop
        
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
            labelTitle.textColor = UIColor.white
            backView.backgroundColor = UIColor.colourSuccess
            imageView.image = icon?.withRenderingMode(
                UIImageRenderingMode.alwaysTemplate)
        }
        else
        {
            labelTitle.textColor = UIColor.colourBackgroundDark
            backView.backgroundColor = UIColor.clear
            imageView.image = icon?.withRenderingMode(
                UIImageRenderingMode.alwaysOriginal)
        }
    }
    
    //MARK: public
    
    func config(model:MSourceProtocol)
    {
        icon = model.icon
        labelTitle.text = model.title
        hover()
    }
}
