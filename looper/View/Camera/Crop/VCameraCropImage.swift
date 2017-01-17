import UIKit

class VCameraCropImage:UIView
{
    private weak var controller:CCameraCrop!
    private weak var thumbTopLeft:VCameraCropImageThumb!
    private weak var thumbTopRight:VCameraCropImageThumb!
    private weak var thumbBottomLeft:VCameraCropImageThumb!
    private weak var thumbBottomRight:VCameraCropImageThumb!
    private weak var imageView:UIImageView!
    private weak var layoutImageBottom:NSLayoutConstraint!
    private weak var layoutImageLeft:NSLayoutConstraint!
    private weak var layoutImageRight:NSLayoutConstraint!
    private weak var draggingThumb:VCameraCropImageThumb?
    private let imageSize:CGFloat
    private var hadLayout:Bool
    private var minDistance:CGFloat
    private let kTopMargin:CGFloat = 50
    private let kMinMargin:CGFloat = 30
    private let kThumbSize:CGFloat = 80
    private let kBackgroundMargin:CGFloat = -2
    
    init(controller:CCameraCrop)
    {
        hadLayout = false
        minDistance = 0
        
        if let imageSize:CGFloat = controller.record.items.first?.image.size.width
        {
            self.imageSize = imageSize
        }
        else
        {
            self.imageSize = 0
        }
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let background:VBorder = VBorder(color:UIColor.black)
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.image = controller.record.items.first?.image
        self.imageView = imageView
        
        let thumbTopLeft:VCameraCropImageThumb = VCameraCropImageThumb.topLeft()
        self.thumbTopLeft = thumbTopLeft
        
        let thumbTopRight:VCameraCropImageThumb = VCameraCropImageThumb.topRight()
        self.thumbTopRight = thumbTopRight
        
        let thumbBottomLeft:VCameraCropImageThumb = VCameraCropImageThumb.bottomLeft()
        self.thumbBottomLeft = thumbBottomLeft
        
        let thumbBottomRight:VCameraCropImageThumb = VCameraCropImageThumb.bottomRight()
        self.thumbBottomRight = thumbBottomRight
        
        addSubview(background)
        addSubview(imageView)
        addSubview(thumbTopLeft)
        addSubview(thumbTopRight)
        addSubview(thumbBottomLeft)
        addSubview(thumbBottomRight)
        
        thumbTopLeft.initConstraints(size:kThumbSize)
        thumbTopRight.initConstraints(size:kThumbSize)
        thumbBottomLeft.initConstraints(size:kThumbSize)
        thumbBottomRight.initConstraints(size:kThumbSize)
        
        NSLayoutConstraint.equals(
            view:background,
            toView:imageView,
            margin:kBackgroundMargin)
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self,
            constant:kTopMargin)
        layoutImageBottom = NSLayoutConstraint.bottomToBottom(
            view:imageView,
            toView:self)
        layoutImageLeft = NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        layoutImageRight = NSLayoutConstraint.rightToRight(
            view:imageView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        if !hadLayout
        {
            let width:CGFloat = bounds.maxX
            
            if width > 0
            {
                hadLayout = true
                
                let height:CGFloat = bounds.maxY
                let width_margin:CGFloat = width - kMinMargin
                let width_margin2:CGFloat = width_margin - kMinMargin
                let imageMaxY:CGFloat = width_margin2 + kTopMargin
                let marginBottom:CGFloat = height - imageMaxY
                let imageRatio:CGFloat = width_margin2 / imageSize
                minDistance = ceil(imageRatio * MCamera.kImageMinSize)
                
                layoutImageLeft.constant = kMinMargin
                layoutImageRight.constant = -kMinMargin
                layoutImageBottom.constant = -marginBottom
                
                thumbTopLeft.position(
                    positionX:kMinMargin,
                    positionY:kTopMargin)
                thumbTopRight.position(
                    positionX:width_margin,
                    positionY:kTopMargin)
                thumbBottomLeft.position(
                    positionX:kMinMargin,
                    positionY:imageMaxY)
                thumbBottomRight.position(
                    positionX:width_margin,
                    positionY:imageMaxY)
            }
        }
        
        super.layoutSubviews()
    }
    
    override func touchesBegan(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        if draggingThumb == nil
        {
            guard
            
                let touch:UITouch = touches.first,
                let draggingThumb:VCameraCropImageThumb = touch.view as? VCameraCropImageThumb
            
            else
            {
                return
            }
            
            self.draggingThumb = draggingThumb
        }
    }
    
    override func touchesMoved(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        guard
        
            let draggingThumb:VCameraCropImageThumb = self.draggingThumb,
            let touch:UITouch = touches.first
        
        else
        {
            return
        }
        
        let point:CGPoint = touch.location(in:self)
    
        switch draggingThumb.location
        {
        case VCameraCropImageThumb.Location.topLeft:
            
            movingTopLeft(point:point)
            
            break
            
        case VCameraCropImageThumb.Location.topRight:
            
            movingTopRight(point:point)
            
            break
            
        case VCameraCropImageThumb.Location.bottomLeft:
            
            movingBottomLeft(point:point)
            
            break
            
        case VCameraCropImageThumb.Location.bottomRight:
            
            movingBottomRight(point:point)
            
            break
        }
    }
    
    override func touchesCancelled(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        draggingEnded()
    }
    
    override func touchesEnded(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        draggingEnded()
    }
    
    //MARK: private
    
    private func draggingEnded()
    {
        draggingThumb = nil
    }
    
    private func movingTopLeft(point:CGPoint)
    {
        var pointX:CGFloat = point.x
        var pointY:CGFloat = point.y
        let rightX:CGFloat = thumbTopRight.positionX
        let bottomY:CGFloat = thumbBottomLeft.positionY
        var deltaX:CGFloat = rightX - pointX
        var deltaY:CGFloat = bottomY - pointY
        
        if deltaX < minDistance
        {
            deltaX = minDistance
        }
        
        if deltaY < minDistance
        {
            deltaY = minDistance
        }
        
        let minDelta:CGFloat = min(deltaX, deltaY)
        pointX = rightX - minDelta
        pointY = bottomY - minDelta
        
        thumbTopLeft.position(
            positionX:pointX,
            positionY:pointY)
        thumbTopRight.position(
            positionX:rightX,
            positionY:pointY)
        thumbBottomLeft.position(
            positionX:pointX,
            positionY:bottomY)
    }
    
    private func movingTopRight(point:CGPoint)
    {
        
    }
    
    private func movingBottomLeft(point:CGPoint)
    {
        
    }
    
    private func movingBottomRight(point:CGPoint)
    {
        
    }
}
