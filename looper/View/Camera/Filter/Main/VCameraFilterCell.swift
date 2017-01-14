import UIKit

class VCameraFilterCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var label:UILabel!
    private weak var selectedIcon:UIImageView!
    private let kImageWidth:CGFloat = 120
    private let kSelectedWidth:CGFloat = 55
    private let kAlphaSelected:CGFloat = 1
    private let kAlphaNotSelected:CGFloat = 0.2
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        self.imageView = imageView
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.regular(size:18)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        self.label = label
        
        let selectedIcon:UIImageView = UIImageView()
        selectedIcon.translatesAutoresizingMaskIntoConstraints = false
        selectedIcon.clipsToBounds = true
        selectedIcon.isUserInteractionEnabled = false
        selectedIcon.contentMode = UIViewContentMode.center
        selectedIcon.image = #imageLiteral(resourceName: "assetCameraFilterSelect")
        self.selectedIcon = selectedIcon
        
        addSubview(label)
        addSubview(imageView)
        addSubview(selectedIcon)
        
        let constraintsImageVertical:[NSLayoutConstraint] = NSLayoutConstraint.equalsVertical(
            view:imageView,
            toView:self)
        let constraintsSelectedVertical:[NSLayoutConstraint] = NSLayoutConstraint.equalsVertical(
            view:selectedIcon,
            toView:self)
        let constraintsLabelVertical:[NSLayoutConstraint] = NSLayoutConstraint.equalsVertical(
            view:label,
            toView:self)
        
        let layoutImageLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        let layoutImageWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:imageView,
            constant:kImageWidth)
        
        let layoutSelectedRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:selectedIcon,
            toView:self)
        let layoutSelectedWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:selectedIcon,
            constant:kSelectedWidth)

        let layoutLabelLeft:NSLayoutConstraint = NSLayoutConstraint.leftToRight(
            view:label,
            toView:imageView)
        let layoutLabelRight:NSLayoutConstraint = NSLayoutConstraint.rightToLeft(
            view:label,
            toView:selectedIcon)
        
        addConstraints(constraintsImageVertical)
        addConstraints(constraintsSelectedVertical)
        addConstraints(constraintsLabelVertical)
        
        addConstraints([
            layoutImageWidth,
            layoutImageLeft,
            layoutSelectedWidth,
            layoutSelectedRight,
            layoutLabelLeft,
            layoutLabelRight])
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
            selectedIcon.isHidden = false
            label.alpha = kAlphaSelected
            imageView.alpha = kAlphaSelected
        }
        else
        {
            selectedIcon.isHidden = true
            label.alpha = kAlphaNotSelected
            imageView.alpha = kAlphaNotSelected
        }
    }
    
    //MARK: public
    
    func config(model:MCameraFilterItem)
    {
        imageView.image = model.image
        label.text = model.title
        
        hover()
    }
}
