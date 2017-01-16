import UIKit

class VCameraRotate:VView
{
    private enum Quadrant
    {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }
    
    private enum Animation
    {
        case increase
        case decrease
    }
    
    weak var timer:Timer?
    private weak var controller:CCameraRotate!
    private weak var viewImage:VCameraRotateImage!
    private weak var viewHandler:VCameraRotateHandler!
    private var animateDeltaExpected:CGFloat
    private var animation:Animation?
    private var initialPoint:CGPoint?
    private var movingX:CGFloat?
    private var movingY:CGFloat?
    private var quadrant:Quadrant?
    private var currentDelta:CGFloat
    private var previousDelta:CGFloat
    private var maxMove:CGFloat
    private let kAnimationDelta:CGFloat = 3
    private let kTimerDuration:TimeInterval = 0.02
    private let kTotalRotation:CGFloat = CGFloat(M_PI + M_PI)
    private let kPercentThreeQuarters:CGFloat = 0.75
    private let kPercentHalf:CGFloat = 0.5
    private let kPercentQuarter:CGFloat = 0.25
    private let kPercentThreshold:CGFloat = 0.125
    private let kBarHeight:CGFloat = 64
    
    override init(controller:CController)
    {
        currentDelta = 0
        previousDelta = 0
        maxMove = 0
        animateDeltaExpected = 0
        
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CCameraRotate
        
        let blur:VBlur = VBlur.extraLight()
        let viewBar:VCameraRotateBar = VCameraRotateBar(controller:self.controller)
        
        let viewImage:VCameraRotateImage = VCameraRotateImage(controller:self.controller)
        self.viewImage = viewImage
        
        let viewHandler:VCameraRotateHandler = VCameraRotateHandler()
        self.viewHandler = viewHandler
        
        addSubview(blur)
        addSubview(viewImage)
        addSubview(viewHandler)
        addSubview(viewBar)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        
        NSLayoutConstraint.equalsHorizontal(
            view:viewHandler,
            toView:self)
        NSLayoutConstraint.topToBottom(
            view:viewHandler,
            toView:viewBar)
        NSLayoutConstraint.bottomToBottom(
            view:viewHandler,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:viewImage,
            toView:viewHandler)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    deinit
    {
        timer?.invalidate()
    }
    
    override func layoutSubviews()
    {
        maxMove = bounds.maxX
        
        super.layoutSubviews()
    }
    
    override func touchesBegan(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        if initialPoint == nil
        {
            guard
                
                let touch:UITouch = touches.first,
                let view:VCameraRotateHandler = touch.view as? VCameraRotateHandler
                
            else
            {
                return
            }
            
            timer?.invalidate()
            initialPoint = touch.location(in:view)
            
            let initialX:CGFloat = initialPoint!.x
            let initialY:CGFloat = initialPoint!.y
            
            if initialX <= view.bounds.midX
            {
                if initialY <= view.bounds.midY
                {
                    quadrant = Quadrant.topLeft
                }
                else
                {
                    quadrant = Quadrant.bottomLeft
                }
            }
            else
            {
                if initialY <= view.bounds.midY
                {
                    quadrant = Quadrant.topRight
                }
                else
                {
                    quadrant = Quadrant.bottomRight
                }
            }
        }
    }
    
    override func touchesMoved(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        guard
            
            let initialPoint:CGPoint = self.initialPoint,
            let touch:UITouch = touches.first,
            let view:VCameraRotateHandler = touch.view as? VCameraRotateHandler,
            let quadrant:Quadrant = self.quadrant
            
        else
        {
            return
        }
        
        let currentPoint:CGPoint = touch.location(in:view)
        
        if let movingX:CGFloat = self.movingX
        {
            let deltaX:CGFloat = movingX - currentPoint.x
            
            switch quadrant
            {
            case Quadrant.topLeft,
                 Quadrant.topRight:
                
                rotate(delta:-deltaX)
                
                break
                
            case Quadrant.bottomLeft,
                 Quadrant.bottomRight:
                
                rotate(delta:deltaX)
                
                break
            }
        }
        else if let movingY:CGFloat = self.movingY
        {
            let deltaY:CGFloat = movingY - currentPoint.y

            switch quadrant
            {
            case Quadrant.topLeft,
                 Quadrant.bottomLeft:
                
                rotate(delta:deltaY)

                break
                
            case Quadrant.topRight,
                 Quadrant.bottomRight:
                
                rotate(delta:-deltaY)
                
                break
            }
        }
        else
        {
            let initialX:CGFloat = initialPoint.x
            let initialY:CGFloat = initialPoint.y
            let deltaX:CGFloat = fabs(initialX - currentPoint.x)
            let deltaY:CGFloat = fabs(initialY - currentPoint.y)
            
            if deltaX > deltaY
            {
                movingX = initialX
            }
            else
            {
                movingY = initialY
            }
        }
    }
    
    override func touchesEnded(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        finishRotate()
    }
    
    override func touchesCancelled(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        finishRotate()
    }
    
    func tickAnimation(sender timer:Timer)
    {
        guard
        
            let animation:Animation = self.animation
        
        else
        {
            timer.invalidate()
            
            return
        }
        
        switch animation
        {
        case Animation.increase:

            currentDelta += kAnimationDelta
            
            if currentDelta > animateDeltaExpected
            {
                currentDelta = animateDeltaExpected
                
                timer.invalidate()
            }
            
            break
        
        case Animation.decrease:
            
            currentDelta -= kAnimationDelta
            
            if currentDelta < animateDeltaExpected
            {
                currentDelta = animateDeltaExpected
                
                timer.invalidate()
            }
            
            break
        }
        
        rotateCurrentDelta()
        
        if !timer.isValid
        {
            previousDelta = currentDelta
        }
    }
    
    //MARK: private
    
    private func animateTo()
    {
        let percent:CGFloat = fabs(currentDelta) / maxMove
        let newPercent:CGFloat
        
        if percent >= kPercentThreeQuarters
        {
            if percent - kPercentThreeQuarters >= kPercentThreshold
            {
                newPercent = 1
            }
            else
            {
                newPercent = kPercentThreeQuarters
            }
        }
        else if percent >= kPercentHalf
        {
            if percent - kPercentHalf >= kPercentThreshold
            {
                newPercent = kPercentThreeQuarters
            }
            else
            {
                newPercent = kPercentHalf
            }
        }
        else if percent >= kPercentQuarter
        {
            if percent - kPercentQuarter >= kPercentThreshold
            {
                newPercent = kPercentHalf
            }
            else
            {
                newPercent = kPercentQuarter
            }
        }
        else
        {
            if percent >= kPercentThreshold
            {
                newPercent = kPercentQuarter
            }
            else
            {
                newPercent = 0
            }
        }
        
        if currentDelta >= 0
        {
            animateDeltaExpected = newPercent * maxMove
        }
        else
        {
            animateDeltaExpected = -newPercent * maxMove
        }
        
        if animateDeltaExpected >= currentDelta
        {
            animation = Animation.increase
        }
        else
        {
            animation = Animation.decrease
        }
        
        timer = Timer.scheduledTimer(
            timeInterval:kTimerDuration,
            target:self,
            selector:#selector(tickAnimation(sender:)),
            userInfo:nil,
            repeats:true)
    }
    
    private func finishRotate()
    {
        initialPoint = nil
        movingX = nil
        movingY = nil
        previousDelta = currentDelta
        
        animateTo()
    }
    
    private func rotate(delta:CGFloat)
    {
        currentDelta = delta + previousDelta
        
        if currentDelta >= 0
        {
            if currentDelta > maxMove
            {
                currentDelta = maxMove
            }
        }
        else
        {
            if currentDelta < -maxMove
            {
                currentDelta = -maxMove
            }
        }
        
        rotateCurrentDelta()
    }
    
    func rotateCurrentDelta()
    {
        let percent:CGFloat = fabs(currentDelta) / maxMove
        let radians:CGFloat = kTotalRotation * percent
        let transform:CGAffineTransform
        
        if currentDelta >= 0
        {
            transform = CGAffineTransform.init(rotationAngle:radians)
            viewHandler.handRight(delta:percent)
        }
        else
        {
            transform = CGAffineTransform.init(rotationAngle:-radians)
            viewHandler.handLeft(delta:percent)
        }
        
        viewImage.transform = transform
    }
}
