import UIKit

class VCameraFilterNoneHeader:UICollectionReusableView
{
    private let kLabelMarginHorizontal:CGFloat = 20
    private let kLabelMarginTop:CGFloat = 67
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.regular(size:20)
        label.textColor = UIColor.black
        label.text = NSLocalizedString("VCameraFilterNoneHeader_label", comment:"")
        
        addSubview(label)
        
        let layoutLabelTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:label,
            toView:self,
            constant:kLabelMarginTop)
        let layoutLabelBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:label,
            toView:self)
        let layoutLabelLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:label,
            toView:self,
            constant:kLabelMarginHorizontal)
        let layoutLabelRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:label,
            toView:self,
            constant:kLabelMarginHorizontal)
        
        addConstraints([
            layoutLabelTop,
            layoutLabelBottom,
            layoutLabelLeft,
            layoutLabelRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
