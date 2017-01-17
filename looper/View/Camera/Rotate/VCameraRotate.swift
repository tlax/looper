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
    var orientation:UIImageOrientation
    private weak var controller:CCameraRotate!
    private weak var viewImage:VCameraRotateImage!
    private weak var viewHandler:VCameraRotateHandler!
    private weak var buttonDone:UIButton!
    private weak var buttonReset:UIButton!
    private weak var spinner:VSpinner!
    private weak var layoutDoneLeft:NSLayoutConstraint!
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
    private let kAlphaLoading:CGFloat = 0.3
    private let kButtonDoneHeight:CGFloat = 35
    private let kButtonResetHeight:CGFloat = 50
    private let kButtonWidth:CGFloat = 120
    
    override init(controller:CController)
    {
        orientation = UIImageOrientation.up
        currentDelta = 0
        previousDelta = 0
        maxMove = 0
        animateDeltaExpected = 0
        
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CCameraRotate
        
        let blur:VBlur = VBlur.extraLight()
        
        let buttonDone:UIButton = UIButton()
        buttonDone.translatesAutoresizingMaskIntoConstraints = false
        buttonDone.clipsToBounds = true
        buttonDone.backgroundColor = UIColor.genericLight
        buttonDone.layer.cornerRadius = kButtonDoneHeight / 2.0
        buttonDone.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonDone.setTitleColor(
            UIColor(white:1, alpha:0.1),
            for:UIControlState.highlighted)
        buttonDone.setTitle(
            NSLocalizedString("VCameraScale_done", comment:""),
            for:UIControlState.normal)
        buttonDone.titleLabel!.font = UIFont.bold(size:17)
        buttonDone.addTarget(
            self,
            action:#selector(actionDone(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonDone = buttonDone
        
        let buttonReset:UIButton = UIButton()
        buttonReset.translatesAutoresizingMaskIntoConstraints = false
        buttonReset.clipsToBounds = true
        buttonReset.backgroundColor = UIColor.clear
        buttonReset.setTitleColor(
            UIColor.black,
            for:UIControlState.normal)
        buttonReset.setTitleColor(
            UIColor(white:0, alpha:0.2),
            for:UIControlState.highlighted)
        buttonReset.setTitle(
            NSLocalizedString("VCameraScale_reset", comment:""),
            for:UIControlState.normal)
        buttonReset.titleLabel!.font = UIFont.medium(size:14)
        buttonReset.addTarget(
            self,
            action:#selector(actionReset(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonReset = buttonReset
        
        let viewImage:VCameraRotateImage = VCameraRotateImage(controller:self.controller)
        self.viewImage = viewImage
        
        let viewHandler:VCameraRotateHandler = VCameraRotateHandler()
        self.viewHandler = viewHandler
        
        let spinner:VSpinner = VSpinner()
        spinner.stopAnimating()
        self.spinner = spinner
        
        addSubview(blur)
        addSubview(viewImage)
        addSubview(spinner)
        addSubview(viewHandler)
        addSubview(buttonDone)
        addSubview(buttonReset)
        
        NSLayoutConstraint.bottomToTop(
            view:buttonDone,
            toView:buttonReset)
        NSLayoutConstraint.height(
            view:buttonDone,
            constant:kButtonDoneHeight)
        NSLayoutConstraint.width(
            view:buttonDone,
            constant:kButtonWidth)
        layoutDoneLeft = NSLayoutConstraint.leftToLeft(
            view:buttonDone,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:buttonReset,
            toView:self)
        NSLayoutConstraint.height(
            view:buttonReset,
            constant:kButtonResetHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:buttonReset,
            toView:buttonDone)
        
        NSLayoutConstraint.equalsHorizontal(
            view:viewHandler,
            toView:self)
        NSLayoutConstraint.topToTop(
            view:viewHandler,
            toView:self)
        NSLayoutConstraint.bottomToTop(
            view:viewHandler,
            toView:buttonDone)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        NSLayoutConstraint.equals(
            view:viewImage,
            toView:viewHandler)
        NSLayoutConstraint.equals(
            view:spinner,
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
        let remain:CGFloat = maxMove - kButtonWidth
        let margin:CGFloat = remain / 2.0
        layoutDoneLeft.constant = margin
        
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
    
    //MARK: actions
    
    func actionDone(sender button:UIButton)
    {
        button.isUserInteractionEnabled = false
        controller.save()
    }
    
    func actionReset(sender button:UIButton)
    {
        controller.viewRotate.reset()
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
                orientation = UIImageOrientation.up
            }
            else
            {
                newPercent = kPercentThreeQuarters
                
                if currentDelta >= 0
                {
                    orientation = UIImageOrientation.left
                }
                else
                {
                    orientation = UIImageOrientation.right
                }
            }
        }
        else if percent >= kPercentHalf
        {
            if percent - kPercentHalf >= kPercentThreshold
            {
                newPercent = kPercentThreeQuarters
                
                if currentDelta >= 0
                {
                    orientation = UIImageOrientation.left
                }
                else
                {
                    orientation = UIImageOrientation.right
                }
            }
            else
            {
                newPercent = kPercentHalf
                orientation = UIImageOrientation.down
            }
        }
        else if percent >= kPercentQuarter
        {
            if percent - kPercentQuarter >= kPercentThreshold
            {
                newPercent = kPercentHalf
                orientation = UIImageOrientation.down
            }
            else
            {
                newPercent = kPercentQuarter
                
                if currentDelta >= 0
                {
                    orientation = UIImageOrientation.right
                }
                else
                {
                    orientation = UIImageOrientation.left
                }
            }
        }
        else
        {
            if percent >= kPercentThreshold
            {
                newPercent = kPercentQuarter
                
                if currentDelta >= 0
                {
                    orientation = UIImageOrientation.right
                }
                else
                {
                    orientation = UIImageOrientation.left
                }
            }
            else
            {
                newPercent = 0
                orientation = UIImageOrientation.up
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
    
    private func rotateCurrentDelta()
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
    
    //MARK: public
    
    func reset()
    {
        timer?.invalidate()
        
        orientation = UIImageOrientation.up
        animateDeltaExpected = 0
        
        if currentDelta >= 0
        {
            animation = Animation.decrease
        }
        else
        {
            animation = Animation.increase
        }
        
        timer = Timer.scheduledTimer(
            timeInterval:kTimerDuration,
            target:self,
            selector:#selector(tickAnimation(sender:)),
            userInfo:nil,
            repeats:true)
    }
    
    func startLoading()
    {
        timer?.invalidate()
        
        spinner.startAnimating()
        viewHandler.isHidden = true
        viewImage.isHidden = true
        viewBar.isUserInteractionEnabled = false
        viewBar.alpha = kAlphaLoading
    }
}
