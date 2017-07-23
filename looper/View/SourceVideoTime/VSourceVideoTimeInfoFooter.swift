import UIKit

class VSourceVideoTimeInfoFooter:UICollectionReusableView
{
    private weak var controller:CSourceVideoTime?
    private weak var slider:UISlider!
    private weak var labelSlider:UILabel!
    private let kSliderHeight:CGFloat = 60
    private let kSliderMarginHorizontal:CGFloat = 30
    private let kTitleTop:CGFloat = 25
    private let kTitleHeight:CGFloat = 19
    private let kLabelSliderHeight:CGFloat = 28
    private let kMinValue:Float = 1
    private let kMaxValue:Float = 20
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let slider:UISlider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = kMinValue
        slider.maximumValue = kMaxValue
        slider.minimumTrackTintColor = UIColor.colourSuccess
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
        labelTitle.textColor = UIColor.black
        labelTitle.font = UIFont.regular(size:13)
        labelTitle.text = String.localizedView(
            key:"VSourceVideoTimeInfoFooter_labelTitle")
        
        let labelSlider:UILabel = UILabel()
        labelSlider.isUserInteractionEnabled = false
        labelSlider.translatesAutoresizingMaskIntoConstraints = false
        labelSlider.backgroundColor = UIColor.clear
        labelSlider.textAlignment = NSTextAlignment.center
        labelSlider.textColor = UIColor.black
        labelSlider.font = UIFont.bold(size:22)
        self.labelSlider = labelSlider
        
        addSubview(labelTitle)
        addSubview(labelSlider)
        addSubview(slider)
        
        NSLayoutConstraint.topToTop(
            view:labelTitle,
            toView:self,
            constant:kTitleTop)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:slider,
            toView:labelSlider)
        NSLayoutConstraint.height(
            view:slider,
            constant:kSliderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:slider,
            toView:self,
            margin:kSliderMarginHorizontal)
        
        NSLayoutConstraint.topToBottom(
            view:labelSlider,
            toView:labelTitle)
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
        print()
        controller?.model.framesPerSecond = frames()
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
    
    //MARK: public
    
    func config(controller:CSourceVideoTime)
    {
        self.controller = controller
        slider.value = Float(controller.model.framesPerSecond)
        
        print()
    }
}
