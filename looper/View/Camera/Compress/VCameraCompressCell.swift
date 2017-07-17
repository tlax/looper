import UIKit

class VCameraCompressCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var label:UILabel!
    private weak var percent:UILabel!
    private weak var selectedIcon:UIImageView!
    private let attributesTitle:[String:AnyObject]
    private let attributesSize:[String:AnyObject]
    private let stringSuffix:NSAttributedString
    private let kSuffix:String = " Kb"
    private let kLabelLeft:CGFloat = 6
    private let kLabelWidth:CGFloat = 250
    private let kPercentWidth:CGFloat = 80
    private let kSelectedWidth:CGFloat = 55
    private let kAlphaSelected:CGFloat = 1
    private let kAlphaNotSelected:CGFloat = 0.18
    
    override init(frame:CGRect)
    {
        attributesTitle = [
            NSFontAttributeName:UIFont.medium(size:14),
            NSForegroundColorAttributeName:UIColor.black]
        
        attributesSize = [
            NSFontAttributeName:UIFont.regular(size:24),
            NSForegroundColorAttributeName:UIColor(white:0.2, alpha:1)]
        
        let attributesSuffix:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:13),
            NSForegroundColorAttributeName:UIColor(white:0.4, alpha:1)]
        
        stringSuffix = NSAttributedString(
            string:kSuffix,
            attributes:attributesSuffix)
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        self.label = label
        
        let percent:UILabel = UILabel()
        percent.isUserInteractionEnabled = false
        percent.translatesAutoresizingMaskIntoConstraints = false
        percent.backgroundColor = UIColor.clear
        percent.font = UIFont.bold(size:22)
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
        
        NSLayoutConstraint.equalsVertical(
            view:selectedIcon,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:selectedIcon,
            toView:self)
        NSLayoutConstraint.width(
            view:selectedIcon,
            constant:kSelectedWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:label,
            toView:self)
        NSLayoutConstraint.leftToRight(
            view:label,
            toView:percent,
            constant:kLabelLeft)
        NSLayoutConstraint.width(
            view:label,
            constant:kLabelWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:percent,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:percent,
            toView:self)
        NSLayoutConstraint.width(
            view:percent,
            constant:kPercentWidth)
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
        percent.text = "\(model.percent)%"
        percent.textColor = model.color
     
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        let stringTitle:NSAttributedString = NSAttributedString(
            string:model.title,
            attributes:attributesTitle)
        let stringSize:NSAttributedString = NSAttributedString(
            string:model.size,
            attributes:attributesSize)
        
        mutableString.append(stringTitle)
        mutableString.append(stringSize)
        mutableString.append(stringSuffix)
        
        label.attributedText = mutableString
        
        hover()
    }
}
