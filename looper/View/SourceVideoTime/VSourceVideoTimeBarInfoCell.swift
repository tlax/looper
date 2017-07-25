import UIKit

class VSourceVideoTimeBarInfoCell:UICollectionViewCell
{
    private weak var labelTitle:UILabel!
    private weak var labelValue:UILabel!
    private let kTitleHeight:CGFloat = 18
    private let kValueHeight:CGFloat = 22
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
    
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.textColor = UIColor(white:0, alpha:0.7)
        labelTitle.font = UIFont.medium(size:13)
        self.labelTitle = labelTitle
        
        let labelValue:UILabel = UILabel()
        labelValue.isUserInteractionEnabled = false
        labelValue.translatesAutoresizingMaskIntoConstraints = false
        labelValue.backgroundColor = UIColor.clear
        labelValue.textAlignment = NSTextAlignment.center
        labelValue.textColor = UIColor.white
        labelValue.font = UIFont.medium(size:16)
        self.labelValue = labelValue
        
        addSubview(labelTitle)
        addSubview(labelValue)
        
        NSLayoutConstraint.topToTop(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:labelValue,
            toView:labelTitle)
        NSLayoutConstraint.height(
            view:labelValue,
            constant:kValueHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelValue,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(model:MSourceVideoTimeItemProtocol)
    {
        labelTitle.text = model.title
        labelValue.text = model.value
    }
}
