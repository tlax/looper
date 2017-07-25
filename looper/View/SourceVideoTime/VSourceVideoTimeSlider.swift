import UIKit

class VSourceVideoTimeSlider:
    View<VSourceVideoTime, MSourceVideoTime, CSourceVideoTime>
{
    private weak var slider:UISlider!
    private weak var labelSlider:UILabel!
    private let kSliderBottom:CGFloat = -20
    private let kSliderHeight:CGFloat = 60
    private let kSliderMarginHorizontal:CGFloat = 30
    private let kTitleHeight:CGFloat = 20
    private let kLabelSliderHeight:CGFloat = 32
    private let kMinValue:Float = 1
    private let kMaxValue:Float = 20
    
    required init(controller:CSourceVideoTime)
    {
        super.init(controller:controller)
        
        let sliderValue:Float = Float(controller.model.framesPerSecond)
        
        let slider:UISlider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = kMinValue
        slider.maximumValue = kMaxValue
        slider.value = sliderValue
        slider.minimumTrackTintColor = UIColor.colourSuccess
        slider.maximumTrackTintColor = UIColor.colourBackgroundGray
        slider.addTarget(
            self,
            action:#selector(actionSlider(sender:)),
            for:UIControlEvents.valueChanged)
        self.slider = slider
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.textColor = UIColor.colourBackgroundDark
        labelTitle.font = UIFont.regular(size:12)
        labelTitle.text = String.localizedView(
            key:"VSourceVideoTimeSlider_labelTitle")
        
        let labelSlider:UILabel = UILabel()
        labelSlider.isUserInteractionEnabled = false
        labelSlider.translatesAutoresizingMaskIntoConstraints = false
        labelSlider.backgroundColor = UIColor.clear
        labelSlider.textAlignment = NSTextAlignment.center
        labelSlider.textColor = UIColor.colourBackgroundDark
        labelSlider.font = UIFont.bold(size:24)
        self.labelSlider = labelSlider
        
        addSubview(labelTitle)
        addSubview(labelSlider)
        addSubview(slider)
        
        NSLayoutConstraint.bottomToBottom(
            view:slider,
            toView:self,
            constant:kSliderBottom)
        NSLayoutConstraint.height(
            view:slider,
            constant:kSliderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:slider,
            toView:self,
            margin:kSliderMarginHorizontal)
        
        NSLayoutConstraint.bottomToTop(
            view:labelTitle,
            toView:labelSlider)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
        
        NSLayoutConstraint.bottomToTop(
            view:labelSlider,
            toView:slider)
        NSLayoutConstraint.height(
            view:labelSlider,
            constant:kLabelSliderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelSlider,
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
        let value:Int = frames()
        
        print()
        controller.model.framesPerSecond = value
    }
    
    //MARK: private
    
    private func print()
    {
        let amount:Int = frames()
        let string:String = "\(amount)"
        labelSlider.text = string
    }
    
    private func frames() -> Int
    {
        let value:Float = slider.value
        let roundValue:Int = Int(roundf(value))
        
        return roundValue
    }
}
