import UIKit

class VStoreCellPurchased:VStoreCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        backgroundColor = UIColor.genericBlue
        isUserInteractionEnabled = false
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.medium(size:16)
        label.textColor = UIColor.white
        label.text = NSLocalizedString("VStoreCellPurchased_label", comment:"")
        
        addSubview(label)
        
        let constraintsLabel:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:label,
            parent:self)
        
        addConstraints(constraintsLabel)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
