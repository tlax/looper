import UIKit

class VCameraCompressCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var label:UILabel!
    private weak var percent:UILabel!
    private weak var selectedIcon:UIImageView!
    private let kLabelLeft:CGFloat = 10
    private let kLabelWidth:CGFloat = 70
    private let kSelectedWidth:CGFloat = 75
    private let kAlphaSelected:CGFloat = 1
    private let kAlphaNotSelected:CGFloat = 0.4
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.regular(size:16)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        self.label = label
        
        let percent:UILabel = UILabel()
        percent.isUserInteractionEnabled = false
        percent.translatesAutoresizingMaskIntoConstraints = false
        percent.backgroundColor = UIColor.clear
        percent.font = UIFont.bold(size:25)
        percent.textColor = UIColor.genericLight
        percent.textAlignment = NSTextAlignment.right
        self.percent = percent
        
        let selectedIcon:UIImageView = UIImageView()
        selectedIcon.translatesAutoresizingMaskIntoConstraints = false
        selectedIcon.clipsToBounds = true
        selectedIcon.isUserInteractionEnabled = false
        selectedIcon.contentMode = UIViewContentMode.center
        selectedIcon.image = #imageLiteral(resourceName: "assetCameraFilterSelect")
        self.selectedIcon = selectedIcon
        
        addSubview(label)
        addSubview(percent)
        addSubview(selectedIcon)
        
        let layoutSelectedTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:selectedIcon,
            toView:self)
        let layoutSelectedBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:selectedIcon,
            toView:self)
        let layoutSelectedRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:selectedIcon,
            toView:self)
        let layoutSelectedWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:selectedIcon,
            constant:kSelectedWidth)
        
        let layoutLabelTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:label,
            toView:self)
        let layoutLabelBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:label,
            toView:self)
        let layoutLabelLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:label,
            toView:self,
            constant:kLabelLeft)
        let layoutLabelRight:NSLayoutConstraint = NSLayoutConstraint.rightToLeft(
            view:label,
            toView:selectedIcon)
        
        let layoutPercentTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:percent,
            toView:self)
        let layoutPercentBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:percent,
            toView:self)
        let layoutPercentLeft:NSLayoutConstraint = NSLayoutConstraint.leftToRight(
            view:percent,
            toView:label)
        let layoutPercentRight:NSLayoutConstraint = NSLayoutConstraint.rightToLeft(
            view:percent,
            toView:selectedIcon)
        
        addConstraints([
            layoutSelectedTop,
            layoutSelectedBottom,
            layoutSelectedWidth,
            layoutSelectedRight,
            layoutLabelTop,
            layoutLabelBottom,
            layoutLabelLeft,
            layoutLabelRight,
            layoutPercentTop,
            layoutPercentBottom,
            layoutPercentLeft,
            layoutPercentRight])
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
            percent.alpha = kAlphaSelected
        }
        else
        {
            selectedIcon.isHidden = true
            label.alpha = kAlphaNotSelected
            percent.alpha = kAlphaNotSelected
        }
    }
    
    //MARK: public
    
    func config(model:MCameraCompressItem)
    {
        label.text = model.title
        
        hover()
    }
}
