import UIKit

class VSourceVideoTimeInfoCell:UICollectionViewCell
{
    private weak var labelTitle:UILabel!
    private weak var labelValue:UILabel!
    private weak var layoutTitleRight:NSLayoutConstraint!
    private let kTitleWidth:CGFloat = 120
    private let kValueWidth:CGFloat = 120
    private let kValueLeft:CGFloat = 10
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.textColor = UIColor.white
        labelTitle.font = UIFont.bold(size:15)
        self.labelTitle = labelTitle
        
        let labelValue:UILabel = UILabel()
        labelValue.isUserInteractionEnabled = false
        labelValue.translatesAutoresizingMaskIntoConstraints = false
        labelValue.backgroundColor = UIColor.clear
        labelValue.textAlignment = NSTextAlignment.center
        labelValue.textColor = UIColor.black
        labelValue.font = UIFont.regular(size:15)
        self.labelValue = labelValue
        
        addSubview(labelTitle)
        addSubview(labelValue)
        
        NSLayoutConstraint.equalsVertical(
            view:labelTitle,
            toView:self)
        layoutTitleRight = NSLayoutConstraint.rightToRight(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.width(
            view:labelTitle,
            constant:kTitleWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:labelValue,
            toView:self)
        NSLayoutConstraint.leftToRight(
            view:labelValue,
            toView:labelTitle,
            constant:kValueLeft)
        NSLayoutConstraint.width(
            view:labelValue,
            constant:kValueWidth)
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
        
    }
}
