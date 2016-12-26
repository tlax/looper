import UIKit

class VHomePlayerTimer:UIView
{
    weak var viewSlider:VHomePlayerTimerSlider!
    private weak var controller:CHome!
    private weak var label:UILabel!
    private weak var layoutSliderWidth:NSLayoutConstraint!
    private let numberFormatter:NumberFormatter
    private let kLabelWidth:CGFloat = 35
    private let kLabelTitleWidth:CGFloat = 90
    private let kLabelTitleHeight:CGFloat = 16
    private let kLabelTitleLeft:CGFloat = 26
    private let kSliderLeft:CGFloat = 5
    private let kSliderRight:CGFloat = 0
    private let kAlphaActive:CGFloat = 1
    private let kAlphaNotActive:CGFloat = 0.3
    
    init(controller:CHome)
    {
        numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.minimumFractionDigits = 0
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.regular(size:18)
        label.textColor = UIColor.white
        self.label = label
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.regular(size:14)
        labelTitle.textColor = UIColor(white:1, alpha:0.6)
        labelTitle.text = NSLocalizedString("VHomePlayerTimer_time", comment:"")
        
        let viewSlider:VHomePlayerTimerSlider = VHomePlayerTimerSlider(
            controller:controller)
        self.viewSlider = viewSlider
        
        addSubview(labelTitle)
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
        
        let layoutTitleHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:labelTitle,
            constant:kLabelTitleHeight)
        let layoutTitleTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:labelTitle,
            toView:self)
        let layoutTitleWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:labelTitle,
            constant:kLabelTitleWidth)
        let layoutTitleLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:labelTitle,
            toView:self,
            constant:kLabelTitleLeft)
        
        let layoutSliderTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:viewSlider,
            toView:self)
        let layoutSliderBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:viewSlider,
            toView:self)
        layoutSliderWidth = NSLayoutConstraint.width(
            view:viewSlider)
        let layoutSliderRight:NSLayoutConstraint = NSLayoutConstraint.rightToLeft(
            view:viewSlider,
            toView:label,
            constant:-kSliderRight)
        
        addConstraints([
            layoutLabelTop,
            layoutLabelBottom,
            layoutLabelRight,
            layoutLabelWidth,
            layoutSliderTop,
            layoutSliderBottom,
            layoutSliderWidth,
            layoutSliderRight,
            layoutTitleHeight,
            layoutTitleTop,
            layoutTitleWidth,
            layoutTitleLeft])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let totalWidth:CGFloat = bounds.maxX
        let remainWidth:CGFloat = totalWidth - (kSliderRight + kSliderLeft + kLabelWidth)
        layoutSliderWidth.constant = remainWidth
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func print()
    {
        let time:NSNumber = viewSlider.currentTime as NSNumber
        label.text = numberFormatter.string(
            from:time)
    }
    
    func blocked()
    {
        alpha = kAlphaNotActive
        isUserInteractionEnabled = false
    }
    
    func notBlocked()
    {
        alpha = kAlphaActive
        isUserInteractionEnabled = true
    }
}
