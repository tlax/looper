import UIKit

class VCameraVideoLoaderFrames:UIView
{
    private weak var controller:CCameraVideoLoader!
    private weak var slider:UISlider!
    private weak var label:UILabel!
    private let kSliderHeight:CGFloat = 60
    private let kSliderMarginHorizontal:CGFloat = 20
    private let kTitleHeight:CGFloat = 35
    private let kLabelHeight:CGFloat = 24
    private let kMinValue:Float = 1
    private let kMaxValue:Float = 15
    private let kDefaultValue:Float = 5
    
    init(controller:CCameraVideoLoader)
    {
        super.init(frame:CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        clipsToBounds = true
        self.controller = controller
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.textColor = UIColor.black
        labelTitle.font = UIFont.regular(size:18)
        labelTitle.text = NSLocalizedString("VCameraVideoLoaderFrames_labelTitle", comment:"")
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.black
        label.font = UIFont.bold(size:17)
        self.label = label
        
        let slider:UISlider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = kMinValue
        slider.maximumValue = kMaxValue
        slider.minimumTrackTintColor = UIColor.genericLight
        slider.value = kDefaultValue
        slider.addTarget(
            self,
            action:#selector(actionSlider(sender:)),
            for:UIControlEvents.valueChanged)
        self.slider = slider
        
        addSubview(labelTitle)
        addSubview(label)
        addSubview(slider)
        
        NSLayoutConstraint.topToTop(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:slider,
            toView:labelTitle)
        NSLayoutConstraint.height(
            view:slider,
            constant:kSliderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:slider,
            toView:self,
            margin:kSliderMarginHorizontal)
        
        NSLayoutConstraint.topToBottom(
            view:label,
            toView:slider)
        NSLayoutConstraint.height(
            view:label,
            constant:kLabelHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self)
        
        print()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionSlider(sender slider:UISlider)
    {
        print()
    }
    
    //MARK: private
    
    private func print()
    {
        let amount:Int = frames()
        let string:String = "\(amount)"
        label.text = string
    }
    
    //MARK: public
    
    func frames() -> Int
    {
        let value:Float = slider.value
        let roundValue:Int = Int(roundf(value))
        
        return roundValue
    }
}
