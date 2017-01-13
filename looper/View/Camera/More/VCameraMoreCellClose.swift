import UIKit

class VCameraMoreCellClose:VCameraMoreCell
{
    private let kBorderHeight:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
     
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.medium(size:14)
        label.textColor = UIColor(white:0, alpha:0.3)
        label.text = NSLocalizedString("VCameraMoreCellClose_label", comment:"")
        
        let border:UIView = UIView()
        border.isUserInteractionEnabled = false
        border.translatesAutoresizingMaskIntoConstraints = false
        border.clipsToBounds = true
        border.backgroundColor = UIColor(white:0, alpha:0.1)
        
        addSubview(border)
        addSubview(label)
        
        let constraintsLabel:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:label,
            toView:self)
        
        let layoutBorderTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:border,
            toView:self)
        let layoutBorderHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        let layoutBorderLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:border,
            toView:self)
        let layoutBorderRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:border,
            toView:self)
 
        addConstraints(constraintsLabel)
        
        addConstraints([
            layoutBorderTop,
            layoutBorderHeight,
            layoutBorderLeft,
            layoutBorderRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
