import UIKit

class VNewSourceCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var circleView:UIView!
    private weak var labelTitle:UILabel!
    private weak var layoutCircleTop:NSLayoutConstraint!
    private weak var layoutCircleLeft:NSLayoutConstraint!
    private var icon:UIImage?
    private let kCircleSize:CGFloat = 60
    private let kBorderWidth:CGFloat = 1
    private let kTitleLeft:CGFloat = 12
    private let kTitleWidth:CGFloat = 200
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let circleView:UIView = UIView()
        circleView.isUserInteractionEnabled = false
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.clipsToBounds = true
        circleView.layer.cornerRadius = kCircleSize / 2.0
        circleView.layer.borderWidth = kBorderWidth
        circleView.layer.borderColor = UIColor.colourSuccess.cgColor
        self.circleView = circleView
        
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
        labelTitle.font = UIFont.regular(size:13)
        self.labelTitle = labelTitle
        
        circleView.addSubview(imageView)
        addSubview(labelTitle)
        addSubview(circleView)
        
        layoutCircleTop = NSLayoutConstraint.topToTop(
            view:circleView,
            toView:self)
        NSLayoutConstraint.size(
            view:circleView,
            constant:kCircleSize)
        layoutCircleLeft = NSLayoutConstraint.leftToLeft(
            view:circleView,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:circleView)
        
        NSLayoutConstraint.equalsVertical(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.leftToRight(
            view:labelTitle,
            toView:circleView,
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
        let remainWidth:CGFloat = width - kCircleSize
        let remainHeight:CGFloat = height - kCircleSize
        let marginLeft:CGFloat = remainWidth / 2.0
        let marginTop:CGFloat = remainHeight / 2.0
        layoutCircleLeft.constant = marginLeft
        layoutCircleTop.constant = marginTop
        
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
            labelTitle.textColor = UIColor.colourSuccess
            circleView.backgroundColor = UIColor.colourSuccess
            imageView.image = icon?.withRenderingMode(
                UIImageRenderingMode.alwaysTemplate)
        }
        else
        {
            labelTitle.textColor = UIColor.black
            circleView.backgroundColor = UIColor.white
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
