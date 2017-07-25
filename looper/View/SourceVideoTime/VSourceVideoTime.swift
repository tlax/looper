import UIKit

class VSourceVideoTime:ViewMain
{
    private weak var layoutNextLeft:NSLayoutConstraint!
    private let kBarHeight:CGFloat = 360
    private let kSliderHeight:CGFloat = 150
    private let kNextWidth:CGFloat = 195
    private let kNextTop:CGFloat = 328
    private let kNextHeight:CGFloat = 64
    
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
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let remainWidth:CGFloat = width - kNextWidth
        let marginLeft:CGFloat = remainWidth / 2.0
        layoutNextLeft.constant = marginLeft
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func factoryViews(controller:CSourceVideoTime)
    {
        let viewBar:VSourceVideoTimeBar = VSourceVideoTimeBar(
            controller:controller)
        
        let viewSlider:VSourceVideoTimeSlider = VSourceVideoTimeSlider(
            controller:controller)
        
        let viewNext:VSourceVideoTimeNext = VSourceVideoTimeNext(
            controller:controller)
        
        addSubview(viewBar)
        addSubview(viewSlider)
        addSubview(viewNext)
        
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
        
        NSLayoutConstraint.topToTop(
            view:viewNext,
            toView:self,
            constant:kNextTop)
        NSLayoutConstraint.height(
            view:viewNext,
            constant:kNextHeight)
        layoutNextLeft = NSLayoutConstraint.leftToLeft(
            view:viewNext,
            toView:self)
        NSLayoutConstraint.width(
            view:viewNext,
            constant:kNextWidth)
    }
}
