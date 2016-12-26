import UIKit

class VHomeControlCell:UICollectionViewCell
{
    private weak var label:UILabel!
    private weak var imageView:UIImageView!
    private let kLabelHeight:CGFloat = 30
    private let kImageHeight:CGFloat = 35
    private let kImageTop:CGFloat = 20
    private let kAlphaSelected:CGFloat = 0.2
    private let kAlphaNotSelected:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.contentMode = UIViewContentMode.center
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView = imageView
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.regular(size:10)
        label.textColor = UIColor.white
        self.label = label
        
        addSubview(imageView)
        addSubview(label)
        
        let layoutLabelHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:label,
            constant:kLabelHeight)
        let layoutLabelBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:label,
            toView:self)
        let layoutLabelLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:label,
            toView:self)
        let layoutLabelRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:label,
            toView:self)
        
        let layoutImageTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self,
            constant:kImageTop)
        let layoutImageHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:imageView,
            constant:kImageHeight)
        let layoutImageLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        let layoutImageRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:imageView,
            toView:self)
        
        addConstraints([
            layoutLabelHeight,
            layoutLabelBottom,
            layoutLabelLeft,
            layoutLabelRight,
            layoutImageTop,
            layoutImageHeight,
            layoutImageLeft,
            layoutImageRight])
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
            isUserInteractionEnabled = false
            alpha = kAlphaSelected
        }
        else
        {
            isUserInteractionEnabled = true
            alpha = kAlphaNotSelected
        }
    }
    
    //MARK: public
    
    func config(model:MHomeControlItem, controller:CHome)
    {
        label.text = model.name
        imageView.image = model.image.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        
        let color:UIColor
        
        if model.active
        {
            color = UIColor.genericLight
            isUserInteractionEnabled = true
        }
        else
        {
            color = UIColor(white:1, alpha:0.3)
            isUserInteractionEnabled = false
        }
        
        imageView.tintColor = color
        label.textColor = color
        
        hover()
    }
}
