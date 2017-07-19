import UIKit

class VSlider:UIView, UIGestureRecognizerDelegate
{
    private weak var viewBase:UIView!
    private weak var viewBar:VSliderBar!
    private weak var layoutBarWidth:NSLayoutConstraint!
    private var sliderChange:((CGFloat) -> ())?
    private var slidingFinished:(() -> ())?
    private var panInitialWidth:CGFloat?
    private var percentUsed:CGFloat
    private let kHorizontalMargin:CGFloat = 20
    private let kCornerRadius:CGFloat = 10
    private let kBorderWidth:CGFloat = 1
    
    init(
        percentUsed:CGFloat = 0,
        sliderChange:((CGFloat) -> ())? = nil,
        slidingFinished:(() -> ())? = nil)
    {
        self.percentUsed = percentUsed
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.sliderChange = sliderChange
        self.slidingFinished = slidingFinished
        
        let viewBase:UIView = UIView()
        viewBase.clipsToBounds = true
        viewBase.backgroundColor = UIColor(white:0.95, alpha:1)
        viewBase.translatesAutoresizingMaskIntoConstraints = false
        viewBase.layer.cornerRadius = kCornerRadius
        viewBase.layer.borderWidth = kBorderWidth
        viewBase.layer.borderColor = UIColor(white:0, alpha:0.2).cgColor
        self.viewBase = viewBase
        
        let viewBar:VSliderBar = VSliderBar()
        self.viewBar = viewBar
        
        viewBase.addSubview(viewBar)
        addSubview(viewBase)
        
        NSLayoutConstraint.equalsVertical(
            view:viewBase,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBase,
            toView:self,
            margin:kHorizontalMargin)
        
        NSLayoutConstraint.equalsVertical(
            view:viewBar,
            toView:viewBase)
        NSLayoutConstraint.leftToLeft(
            view:viewBar,
            toView:viewBase)
        layoutBarWidth = NSLayoutConstraint.width(
            view:viewBar)
        
        let gesture:UIPanGestureRecognizer = UIPanGestureRecognizer(
            target:self,
            action:#selector(actionPanning(sender:)))
        gesture.delegate = self
        
        addGestureRecognizer(gesture)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        layoutSlider()
    }
    
    //MARK: actions
    
    func actionPanning(sender gesture:UIPanGestureRecognizer)
    {
        switch gesture.state
        {
        case UIGestureRecognizerState.began,
             UIGestureRecognizerState.possible:
            
            gestureBegan(gesture:gesture)
            
            break
            
        case UIGestureRecognizerState.changed:
            
            gestureChanged(gesture:gesture)
            
            break
            
        case UIGestureRecognizerState.ended,
             UIGestureRecognizerState.failed,
             UIGestureRecognizerState.cancelled:
            
            gestureEnded(gesture:gesture)
            
            break
        }
    }
    
    //MARK: private
    
    private func layoutSlider()
    {
        let width:CGFloat = viewBase.bounds.maxX
        let percentWidth:CGFloat = percentUsed * width
        layoutBarWidth.constant = percentWidth
    }
    
    private func gestureBegan(gesture:UIPanGestureRecognizer)
    {
        panInitialWidth = layoutBarWidth.constant
    }
    
    private func gestureChanged(gesture:UIPanGestureRecognizer)
    {
        guard
            
            let panInitialWidth:CGFloat = self.panInitialWidth
            
        else
        {
            return
        }
        
        let width:CGFloat = viewBase.bounds.maxX
        
        if width > 0
        {
            let translationX:CGFloat = gesture.translation(in:self).x
            var newWidth:CGFloat = panInitialWidth + translationX
            
            if newWidth < 0
            {
                newWidth = 0
            }
            else if newWidth > width
            {
                newWidth = width
            }
            
            layoutBarWidth.constant = newWidth
            let percentUsed:CGFloat = newWidth / width
            self.percentUsed = percentUsed
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.sliderChange?(percentUsed)
            }
        }
    }
    
    private func gestureEnded(gesture:UIPanGestureRecognizer)
    {
        panInitialWidth = nil
        slidingFinished?()
    }
    
    //MARK: public
    
    func changeSlider(percentUsed:CGFloat)
    {
        self.percentUsed = percentUsed
        layoutSlider()
    }
    
    //MARK: gesture delegate
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer:UIGestureRecognizer) -> Bool
    {
        guard
        
            let panning:UIPanGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer
        
        else
        {
            return false
        }
        
        let velocity:CGPoint = panning.velocity(in:self)
        let velocityX:CGFloat = fabs(velocity.x)
        let velocityY:CGFloat = fabs(velocity.y)
        
        if velocityY > velocityX
        {
            return false
        }
        
        return true
    }
}
