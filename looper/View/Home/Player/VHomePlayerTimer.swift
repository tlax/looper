import UIKit

class VHomePlayerTimer:UIView
{
    private weak var controller:CHome!
    private weak var label:UILabel!
    private weak var viewSlider:VHomePlayerTimerSlider!
    private let kLabelWidth:CGFloat = 70
    private let kSliderLeft:CGFloat = 30
    private let kSliderRight:CGFloat = -15
    
    convenience init(controller:CHome)
    {
        self.init()
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
        
        let viewSlider:VHomePlayerTimerSlider = VHomePlayerTimerSlider(
            controller:controller)
        self.viewSlider = viewSlider
        
        addSubview(label)
        addSubview(viewSlider)
        
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
        
        let layoutSliderTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:viewSlider,
            toView:self)
        let layoutSliderBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:viewSlider,
            toView:self)
        let layoutSliderLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewSlider,
            toView:self,
            constant:kSliderLeft)
        let layoutSliderRight:NSLayoutConstraint = NSLayoutConstraint.rightToLeft(
            view:viewSlider,
            toView:label,
            constant:kSliderRight)
        
        addConstraints([
            layoutLabelTop,
            layoutLabelBottom,
            layoutLabelRight,
            layoutLabelWidth,
            layoutSliderTop,
            layoutSliderBottom,
            layoutSliderLeft,
            layoutSliderRight])
    }
}
