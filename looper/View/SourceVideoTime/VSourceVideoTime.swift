import UIKit

class VSourceVideoTime:ViewMain
{
    private let kBarHeight:CGFloat = 360
    private let kSliderHeight:CGFloat = 150
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        guard
        
            let controller:CSourceVideoTime = self.controller as? CSourceVideoTime
        
        else
        {
            return
        }
        
        factoryViews(controller:controller)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func factoryViews(controller:CSourceVideoTime)
    {
        let viewBar:VSourceVideoTimeBar = VSourceVideoTimeBar(
            controller:controller)
        
        let viewSlider:VSourceVideoTimeSlider = VSourceVideoTimeSlider(
            controller:controller)
        
        addSubview(viewBar)
        addSubview(viewSlider)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.height(
            view:viewSlider,
            constant:kSliderHeight)
        NSLayoutConstraint.bottomToBottom(
            view:viewSlider,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:viewSlider,
            toView:self)
    }
}
