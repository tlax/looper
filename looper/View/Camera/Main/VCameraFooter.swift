import UIKit

class VCameraFooter:UICollectionReusableView
{
    private let kLabelMargin:CGFloat = 10
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.regular(size:19)
        label.textColor = UIColor(white:0.4, alpha:1)
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.text = NSLocalizedString("VCameraFooter_label", comment:"")
        
        addSubview(label)
        
        NSLayoutConstraint.equalsVertical(
            view:label,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self,
            margin:-kLabelMargin)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
