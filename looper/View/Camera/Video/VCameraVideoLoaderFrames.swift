import UIKit

class VCameraVideoLoaderFrames:UIView
{
    private weak var controller:CCameraVideoLoader!
    private weak var label:UILabel!
    private let kSliderHeight:CGFloat = 70
    private let kMarginHorizontal:CGFloat = 20
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
        
        let slider:UISlider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = kMinValue
        slider.maximumValue = kMaxValue
        slider.value = kDefaultValue
        slider.addTarget(
            self,
            action:#selector(actionSlider(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(slider)
        
        NSLayoutConstraint.topToTop(
            view:slider,
            toView:self)
        NSLayoutConstraint.height(
            view:slider,
            constant:kSliderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:slider,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionSlider(sender slider:UISlider)
    {
        
    }
}
