import UIKit

class VCameraPreviewPlayerTimer:UIView
{
    weak var viewSlider:VCameraPreviewPlayerTimerSlider!
    private weak var controller:CCameraPreview!
    private weak var label:UILabel!
    private let numberFormatter:NumberFormatter
    private let attributesLabel:[String:AnyObject]
    private let stringSeconds:NSAttributedString
    private let kSeconds:String = "s"
    private let kLabelTop:CGFloat = 20
    private let kLabelHeight:CGFloat = 32
    private let kSliderTop:CGFloat = -38
    private let kAlphaActive:CGFloat = 1
    private let kAlphaNotActive:CGFloat = 0.3
    
    init(controller:CCameraPreview)
    {
        numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.minimumFractionDigits = 0
        
        let attributesSeconds:[String:AnyObject] = [
            NSFontAttributeName:UIFont.medium(size:13),
            NSForegroundColorAttributeName:UIColor.genericLight]
        attributesLabel = [
            NSFontAttributeName:UIFont.medium(size:16),
            NSForegroundColorAttributeName:UIColor.genericLight]
        stringSeconds = NSAttributedString(
            string:kSeconds,
            attributes:attributesSeconds)
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.center
        self.label = label
        
        let viewSlider:VCameraPreviewPlayerTimerSlider = VCameraPreviewPlayerTimerSlider(
            controller:controller)
        self.viewSlider = viewSlider
        
        addSubview(label)
        addSubview(viewSlider)
        
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self)
        NSLayoutConstraint.topToTop(
            view:label,
            toView:self,
            constant:kLabelTop)
        NSLayoutConstraint.height(
            view:label,
            constant:kLabelHeight)
        
        NSLayoutConstraint.equalsHorizontal(
            view:viewSlider,
            toView:self)
        NSLayoutConstraint.topToBottom(
            view:viewSlider,
            toView:label,
            constant:kSliderTop)
        NSLayoutConstraint.bottomToBottom(
            view:viewSlider,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func print()
    {
        let time:NSNumber = controller.currentTime as NSNumber
        
        guard
            
            let timeString:String = numberFormatter.string(
                from:time)
        
        else
        {
            return
        }
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        let stringLabel:NSAttributedString = NSAttributedString(
            string:timeString,
            attributes:attributesLabel)
        
        mutableString.append(stringLabel)
        mutableString.append(stringSeconds)
        
        label.attributedText = mutableString
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
