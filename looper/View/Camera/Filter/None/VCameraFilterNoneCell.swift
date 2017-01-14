import UIKit

class VCameraFilterNoneCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var selectedIcon:UIImageView!
    private weak var layoutImageWidth:NSLayoutConstraint!
    private weak var layoutImageLeft:NSLayoutConstraint!
    private let kAlphaNotHover:CGFloat = 0.6
    private let kAlphaHover:CGFloat = 1
    private let kSelectedWidth:CGFloat = 60
    
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
        
        let selectedIcon:UIImageView = UIImageView()
        selectedIcon.translatesAutoresizingMaskIntoConstraints = false
        selectedIcon.clipsToBounds = true
        selectedIcon.isUserInteractionEnabled = false
        selectedIcon.contentMode = UIViewContentMode.center
        selectedIcon.image = #imageLiteral(resourceName: "assetCameraFilterSelect")
        self.selectedIcon = selectedIcon
        
        addSubview(imageView)
        addSubview(selectedIcon)
        
        let constraintsImageVertical:[NSLayoutConstraint] = NSLayoutConstraint.equalsVertical(
            view:imageView,
            toView:self)
        let constraintsSelectedVertical:[NSLayoutConstraint] = NSLayoutConstraint.equalsVertical(
            view:selectedIcon,
            toView:self)
        
        layoutImageWidth = NSLayoutConstraint.width(
            view:imageView)
        layoutImageLeft = NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        
        let layoutSelectedRight:NSLayoutConstraint = NSLayoutConstraint.rightToLeft(
            view:selectedIcon,
            toView:imageView)
        let layoutSelectedWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:selectedIcon,
            constant:kSelectedWidth)
        
        addConstraints(constraintsImageVertical)
        addConstraints(constraintsSelectedVertical)
        
        addConstraints([
            layoutImageWidth,
            layoutImageLeft,
            layoutSelectedRight,
            layoutSelectedWidth])
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
            selectedIcon.isHidden = false
        }
        else
        {
            alpha = kAlphaNotHover
            selectedIcon.isHidden = true
        }
    }
    
    //MARK: public
    
    func config(model:MCameraRecord)
    {
        imageView.image = model.items.first?.image
        hover()
    }
}
