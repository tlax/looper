import UIKit

class VHomeControlCell:UICollectionViewCell
{
    private weak var label:UILabel!
    private let kLabelHeight:CGFloat = 15
    private let kLabelBottom:CGFloat = -10
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.regular(size:14)
        label.textColor = UIColor.white
        self.label = label
        
        addSubview(label)
        
        let layoutLabelHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:label,
            constant:kLabelHeight)
        let layoutLabelBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:label,
            toView:self,
            constant:kLabelBottom)
        let layoutLabelLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:label,
            toView:self)
        let layoutLabelRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:label,
            toView:self)
        
        addConstraints([
            layoutLabelHeight,
            layoutLabelBottom,
            layoutLabelLeft,
            layoutLabelRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(model:MHomeControlItem, controller:CHome)
    {
        label.text = model.name
    }
}
