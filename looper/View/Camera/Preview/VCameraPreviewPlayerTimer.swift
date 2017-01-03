import UIKit

class VCameraPreviewPlayerTimer:UIView
{
    weak var viewSlider:VCameraPreviewPlayerTimerSlider!
    private weak var controller:CCameraPreview!
    private weak var label:UILabel!
    private let numberFormatter:NumberFormatter
    private let kLabelHeight:CGFloat = 27
    private let kSliderTop:CGFloat = -24
    private let kAlphaActive:CGFloat = 1
    private let kAlphaNotActive:CGFloat = 0.3
    
    init(controller:CCameraPreview)
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
        label.font = UIFont.medium(size:20)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.genericLight
        self.label = label
        
        let viewSlider:VCameraPreviewPlayerTimerSlider = VCameraPreviewPlayerTimerSlider(
            controller:controller)
        self.viewSlider = viewSlider
        
        addSubview(label)
        addSubview(viewSlider)
        
        let layoutLabelTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:label,
            toView:self)
        let layoutLabelHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:label,
            constant:kLabelHeight)
        let layoutLabelRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:label,
            toView:self)
        let layoutLabelLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:label,
            toView:self)
        
        let layoutSliderTop:NSLayoutConstraint = NSLayoutConstraint.topToBottom(
            view:viewSlider,
            toView:label,
            constant:kSliderTop)
        let layoutSliderBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:viewSlider,
            toView:self)
        let layoutSliderLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewSlider,
            toView:self)
        let layoutSliderRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewSlider,
            toView:self)
        
        addConstraints([
            layoutLabelTop,
            layoutLabelHeight,
            layoutLabelRight,
            layoutLabelLeft,
            layoutSliderTop,
            layoutSliderBottom,
            layoutSliderLeft,
            layoutSliderRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func print()
    {
        let time:NSNumber = viewSlider.currentTime as NSNumber
        
        guard
            
            let timeString:String = numberFormatter.string(
                from:time)
        
        else
        {
            return
        }
        
        let timeComposite:String = "\(timeString)s"
        
        label.text = timeComposite
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
