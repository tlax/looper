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
    
    private weak var controller:CCameraRotate!
    private weak var imageView:UIImageView!
    private weak var viewHandler:VCameraRotateHandler!
    private var initialPoint:CGPoint?
    private var movingX:CGFloat?
    private var movingY:CGFloat?
    private var quadrant:Quadrant?
    private var maxMove:CGFloat
    private let kTotalRotation:CGFloat = CGFloat(M_PI + M_PI)
    private let kBarHeight:CGFloat = 64
    private let kImageMargin:CGFloat = 120
    private let kImageBorder:CGFloat = 1
    
    override init(controller:CController)
    {
        maxMove = 0
        
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CCameraRotate
        
        let blur:VBlur = VBlur.extraLight()
        
        let viewBar:VCameraRotateBar = VCameraRotateBar(controller:self.controller)
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.image = self.controller.record.items.first?.image
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = kImageBorder
        
        let viewHandler:VCameraRotateHandler = VCameraRotateHandler()
        self.viewHandler = viewHandler
        
        addSubview(blur)
        addSubview(viewHandler)
        addSubview(imageView)
        addSubview(viewBar)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        NSLayoutConstraint.equals(
            view:imageView,
            toView:viewHandler,
            margin:kImageMargin)
        
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
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
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
        initialPoint = nil
        movingX = nil
        movingY = nil
    }
    
    override func touchesCancelled(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        initialPoint = nil
        movingX = nil
        movingY = nil
    }
    
    //MARK: private
    
    private func rotate(delta:CGFloat)
    {
        var percent:CGFloat = fabs(delta) / maxMove
        
        if percent > 1
        {
            percent = 1
        }
        
        if delta >= 0
        {
            let radians:CGFloat = kTotalRotation * percent
            let transform:CGAffineTransform = CGAffineTransform.init(rotationAngle:radians)
            imageView.transform = transform
            
            viewHandler.handRight(delta:percent)
        }
        else
        {
            let radians:CGFloat = kTotalRotation * -percent
            let transform:CGAffineTransform = CGAffineTransform.init(rotationAngle:radians)
            imageView.transform = transform
            
            viewHandler.handLeft(delta:percent)
        }
    }
}
