import UIKit

class VHomePlayerTimer:UIView
{
    private weak var controller:CHome!
    private weak var label:UILabel!
    private weak var viewSlider:VHomePlayerTimerSlider!
    private weak var layoutSliderWidth:NSLayoutConstraint!
    private let numberFormatter:NumberFormatter
    private let kLabelWidth:CGFloat = 70
    private let kLabelTitleHeight:CGFloat = 30
    private let kSliderLeft:CGFloat = 20
    private let kSliderRight:CGFloat = 10
    private let kMaxFractions:Int = 1
    
    init(controller:CHome)
    {
        numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = kMaxFractions
        numberFormatter.minimumFractionDigits = kMaxFractions
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.regular(size:16)
        label.textColor = UIColor.white
        self.label = label
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.regular(size:12)
        labelTitle.textColor = UIColor.white
        labelTitle.text = NSLocalizedString("VHomePlayerTimer_time", comment:"")
        
        let viewSlider:VHomePlayerTimerSlider = VHomePlayerTimerSlider(
            controller:controller)
        self.viewSlider = viewSlider
        
        addSubview(label)
        addSubview(labelTitle)
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
        let layoutTitleBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToTop(
            view:labelTitle,
            toView:self)
        let layoutTitleWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:labelTitle,
            constant:kLabelWidth)
        let layoutTitleRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:labelTitle,
            toView:self)
        
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
            layoutTitleBottom,
            layoutTitleWidth,
            layoutTitleRight])
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
}
