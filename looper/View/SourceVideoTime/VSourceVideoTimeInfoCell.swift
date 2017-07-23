import UIKit

class VSourceVideoTimeInfoCell:UICollectionViewCell
{
    private weak var labelTitle:UILabel!
    private weak var labelValue:UILabel!
    private weak var layoutTitleRight:NSLayoutConstraint!
    private let kLabelWidth:CGFloat = 90
    private let kCornerRadius:CGFloat = 5
    private let kBorderWidth:CGFloat = 1
    private let kBaseMarginVertical:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        
        let viewBase:UIView = UIView()
        viewBase.translatesAutoresizingMaskIntoConstraints = false
        viewBase.isUserInteractionEnabled = false
        viewBase.clipsToBounds = true
        viewBase.layer.cornerRadius = kCornerRadius
        viewBase.layer.borderWidth = kBorderWidth
        viewBase.layer.borderColor = UIColor.colourSuccess.cgColor
        
        let viewBackground:UIView = UIView()
        viewBackground.isUserInteractionEnabled = false
        viewBackground.translatesAutoresizingMaskIntoConstraints = false
        viewBackground.clipsToBounds = true
        viewBackground.backgroundColor = UIColor.colourSuccess
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.textColor = UIColor.white
        labelTitle.font = UIFont.bold(size:13)
        self.labelTitle = labelTitle
        
        let labelValue:UILabel = UILabel()
        labelValue.isUserInteractionEnabled = false
        labelValue.translatesAutoresizingMaskIntoConstraints = false
        labelValue.backgroundColor = UIColor.clear
        labelValue.textAlignment = NSTextAlignment.center
        labelValue.textColor = UIColor.black
        labelValue.font = UIFont.regular(size:13)
        self.labelValue = labelValue
        
        viewBase.addSubview(viewBackground)
        addSubview(viewBase)
        addSubview(labelTitle)
        addSubview(labelValue)
        
        NSLayoutConstraint.equalsVertical(
            view:viewBase,
            toView:self,
            margin:kBaseMarginVertical)
        NSLayoutConstraint.leftToLeft(
            view:viewBase,
            toView:labelTitle)
        NSLayoutConstraint.rightToRight(
            view:viewBase,
            toView:labelValue)
        
        NSLayoutConstraint.equalsVertical(
            view:viewBackground,
            toView:viewBase)
        NSLayoutConstraint.leftToLeft(
            view:viewBackground,
            toView:viewBase)
        NSLayoutConstraint.width(
            view:viewBackground,
            constant:kLabelWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:labelTitle,
            toView:self)
        layoutTitleRight = NSLayoutConstraint.rightToRight(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.width(
            view:labelTitle,
            constant:kLabelWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:labelValue,
            toView:self)
        NSLayoutConstraint.leftToRight(
            view:labelValue,
            toView:labelTitle)
        NSLayoutConstraint.width(
            view:labelValue,
            constant:kLabelWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let width_2:CGFloat = width / 2.0
        layoutTitleRight.constant = -width_2
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func config(model:MSourceVideoTimeItemProtocol)
    {
        labelTitle.text = model.title
        labelValue.text = model.value
    }
}
