import UIKit

class VHomePlayerTimer:UIView
{
    private weak var controller:CHome!
    private weak var label:UILabel!
    private var currentTime:TimeInterval
    private let kLabelWidth:CGFloat = 70
    private let kSliderMarginLeft:CGFloat = 30
    private let kSliderMarginRight:CGFloat = 15
    private let kMinTime:TimeInterval = 0.5
    private let kMaxTime:TimeInterval = 10
    private let kStartTime:TimeInterval = 2
    
    init(controller:CHome)
    {
        currentTime = kStartTime
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.regular(size:14)
        label.textColor = UIColor.white
        self.label = label
        
        addSubview(label)
        
        let layoutLabelTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:label,
            toView:self)
        let layoutLabelBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:label,
            toView:self)
        let layoutLabelRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:label,
            toView:self)
        let layoutLabelWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:label,
            constant:kLabelWidth)
        
        addConstraints([
            layoutLabelTop,
            layoutLabelBottom,
            layoutLabelRight,
            layoutLabelWidth])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
