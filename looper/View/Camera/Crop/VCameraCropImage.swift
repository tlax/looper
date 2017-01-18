import UIKit

class VCameraCropImage:UIView
{
    let imageSize:CGFloat
    var imageRatio:CGFloat
    weak var thumbTopLeft:VCameraCropImageThumb!
    weak var thumbTopRight:VCameraCropImageThumb!
    weak var thumbBottomLeft:VCameraCropImageThumb!
    weak var thumbBottomRight:VCameraCropImageThumb!
    private weak var controller:CCameraCrop!
    private weak var imageView:UIImageView!
    private weak var background:VBorder!
    private weak var label:UILabel!
    private weak var layoutImageBottom:NSLayoutConstraint!
    private weak var layoutImageLeft:NSLayoutConstraint!
    private weak var layoutImageRight:NSLayoutConstraint!
    private weak var viewMover:VCameraCropImageMover!
    private weak var draggingThumb:VCameraCropImageThumb?
    private weak var draggingMover:VCameraCropImageMover?
    private let attributes:[String:AnyObject]
    private let stringTimes:NSAttributedString
    private var minDistance:CGFloat
    private var hadLayout:Bool
    private var shadesCreated:Bool
    private let kTimes:String = " x "
    private let thumbSize_2:CGFloat
    private let kTopMargin:CGFloat = 60
    private let kMinMargin:CGFloat = 40
    private let kThumbSize:CGFloat = 60
    private let kBackgroundMargin:CGFloat = -3
    private let kLabelHeight:CGFloat = 100
    
    init(controller:CCameraCrop)
    {
        hadLayout = false
        shadesCreated = false
        imageRatio = 0
        minDistance = 0
        thumbSize_2 = kThumbSize / 2.0
        
        if let imageSize:CGFloat = controller.record.items.first?.image.size.width
        {
            self.imageSize = imageSize
        }
        else
        {
            self.imageSize = 0
        }
        
        let attributesTimes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:17),
            NSForegroundColorAttributeName:UIColor.blue]
        attributes = [
            NSFontAttributeName:UIFont.bold(size:30),
            NSForegroundColorAttributeName:UIColor.genericLight]
        
        stringTimes = NSAttributedString(
            string:kTimes,
            attributes:attributesTimes)
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let background:VBorder = VBorder(color:UIColor.black)
        self.background = background
        
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
        
        let viewMover:VCameraCropImageMover = VCameraCropImageMover()
        self.viewMover = viewMover
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.center
        self.label = label
        
        addSubview(label)
        addSubview(background)
        addSubview(imageView)
        addSubview(viewMover)
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
        
        NSLayoutConstraint.height(
            view:label,
            constant:kLabelHeight)
        NSLayoutConstraint.bottomToBottom(
            view:label,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:label,
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
                imageRatio = width_margin2 / imageSize
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
                
                let touch:UITouch = touches.first
                
            else
            {
                return
            }
            
            if let draggingMover:VCameraCropImageMover = touch.view as? VCameraCropImageMover
            {
                self.draggingMover = draggingMover
                
                let point:CGPoint = touch.location(in:self)
                let pointX:CGFloat = point.x
                let pointY:CGFloat = point.y
                let posTop:CGFloat = thumbTopLeft.positionY
                let posBottom:CGFloat = thumbBottomLeft.positionY
                let posLeft:CGFloat = thumbTopLeft.positionX
                let posRight:CGFloat = thumbTopRight.positionX
                let deltaTop:CGFloat = pointY - posTop
                let deltaBottom:CGFloat = posBottom - pointY
                let deltaLeft:CGFloat = pointX - posLeft
                let deltaRight:CGFloat = posRight - pointX
                
                draggingMover.start(
                    deltaTop:deltaTop,
                    deltaBottom:deltaBottom,
                    deltaLeft:deltaLeft,
                    deltaRight:deltaRight)
            }
            else if let draggingThumb:VCameraCropImageThumb = touch.view as? VCameraCropImageThumb
            {
                self.draggingThumb = draggingThumb
            }
        }
    }
    
    override func touchesMoved(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        guard
        
            let touch:UITouch = touches.first
        
        else
        {
            return
        }
        
        let point:CGPoint = touch.location(in:self)
    
        if let _:VCameraCropImageMover = self.draggingMover
        {
            movingMover(point:point)
        }
        else if let draggingThumb:VCameraCropImageThumb = self.draggingThumb
        {
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
            
            print()
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
        draggingMover = nil
        viewMover.clear()
    }
    
    private func movingMover(point:CGPoint)
    {
        guard
            
            let deltaTop:CGFloat = viewMover.deltaTop,
            let deltaBottom:CGFloat = viewMover.deltaBottom,
            let deltaLeft:CGFloat = viewMover.deltaLeft,
            let deltaRight:CGFloat = viewMover.deltaRight
        
        else
        {
            return
        }
        
        let newPointX:CGFloat = point.x
        let newPointY:CGFloat = point.y
        let newTop:CGFloat = newPointY - deltaTop
        let newBottom:CGFloat = newPointY + deltaBottom
        let newLeft:CGFloat = newPointX - deltaLeft
        let newRight:CGFloat = newPointX + deltaRight
        
        thumbTopLeft.position(
            positionX:newLeft,
            positionY:newTop)
        thumbTopRight.position(
            positionX:newRight,
            positionY:newTop)
        thumbBottomLeft.position(
            positionX:newLeft,
            positionY:newBottom)
        thumbBottomRight.position(
            positionX:newRight,
            positionY:newBottom)
    }
    
    private func movingTopLeft(point:CGPoint)
    {
        var pointX:CGFloat = point.x
        var pointY:CGFloat = point.y
        let originalX:CGFloat = thumbTopLeft.originalX
        let originalY:CGFloat = thumbTopLeft.originalY
        let rightX:CGFloat = thumbTopRight.positionX
        let bottomY:CGFloat = thumbBottomLeft.positionY
        
        if pointX < originalX
        {
            pointX = originalX
        }
        
        if pointY < originalY
        {
            pointY = originalY
        }
        
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
        var pointX:CGFloat = point.x
        var pointY:CGFloat = point.y
        let originalX:CGFloat = thumbTopRight.originalX
        let originalY:CGFloat = thumbTopRight.originalY
        let leftX:CGFloat = thumbTopLeft.positionX
        let bottomY:CGFloat = thumbBottomRight.positionY
        
        if pointX > originalX
        {
            pointX = originalX
        }
        
        if pointY < originalY
        {
            pointY = originalY
        }
        
        var deltaX:CGFloat = pointX - leftX
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
        pointX = leftX + minDelta
        pointY = bottomY - minDelta
        
        thumbTopRight.position(
            positionX:pointX,
            positionY:pointY)
        thumbTopLeft.position(
            positionX:leftX,
            positionY:pointY)
        thumbBottomRight.position(
            positionX:pointX,
            positionY:bottomY)
    }
    
    private func movingBottomLeft(point:CGPoint)
    {
        var pointX:CGFloat = point.x
        var pointY:CGFloat = point.y
        let originalX:CGFloat = thumbBottomLeft.originalX
        let originalY:CGFloat = thumbBottomLeft.originalY
        let rightX:CGFloat = thumbBottomRight.positionX
        let topY:CGFloat = thumbTopLeft.positionY
        
        if pointX < originalX
        {
            pointX = originalX
        }
        
        if pointY > originalY
        {
            pointY = originalY
        }
        
        var deltaX:CGFloat = rightX - pointX
        var deltaY:CGFloat = pointY - topY
        
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
        pointY = topY + minDelta
        
        thumbBottomLeft.position(
            positionX:pointX,
            positionY:pointY)
        thumbBottomRight.position(
            positionX:rightX,
            positionY:pointY)
        thumbTopLeft.position(
            positionX:pointX,
            positionY:topY)
    }
    
    private func movingBottomRight(point:CGPoint)
    {
        var pointX:CGFloat = point.x
        var pointY:CGFloat = point.y
        let originalX:CGFloat = thumbBottomRight.originalX
        let originalY:CGFloat = thumbBottomRight.originalY
        let leftX:CGFloat = thumbBottomLeft.positionX
        let topY:CGFloat = thumbTopRight.positionY
        
        if pointX > originalX
        {
            pointX = originalX
        }
        
        if pointY > originalY
        {
            pointY = originalY
        }
        
        var deltaX:CGFloat = pointX - leftX
        var deltaY:CGFloat = pointY - topY
        
        if deltaX < minDistance
        {
            deltaX = minDistance
        }
        
        if deltaY < minDistance
        {
            deltaY = minDistance
        }
        
        let minDelta:CGFloat = min(deltaX, deltaY)
        pointX = leftX + minDelta
        pointY = topY + minDelta
        
        thumbBottomRight.position(
            positionX:pointX,
            positionY:pointY)
        thumbBottomLeft.position(
            positionX:leftX,
            positionY:pointY)
        thumbTopRight.position(
            positionX:pointX,
            positionY:topY)
    }
    
    //MARK: public
    
    func print()
    {
        let posRight:CGFloat = thumbTopRight.positionX
        let posLeft:CGFloat = thumbTopLeft.positionX
        let deltaPos:CGFloat = posRight - posLeft
        let size:Int = Int(ceil(deltaPos / imageRatio))
        let string:String = "\(size)"
        let stringSize:NSAttributedString = NSAttributedString(
            string:string,
            attributes:attributes)
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringSize)
        mutableString.append(stringTimes)
        mutableString.append(stringSize)
        
        label.attributedText = mutableString
    }
    
    func createShades()
    {
        if !shadesCreated
        {
            shadesCreated = true
            
            let shadeTop:VCameraCropImageShade = VCameraCropImageShade.borderBottom()
            let shadeBottom:VCameraCropImageShade = VCameraCropImageShade.borderTop()
            let shadeLeft:VCameraCropImageShade = VCameraCropImageShade.borderRight()
            let shadeRight:VCameraCropImageShade = VCameraCropImageShade.borderLeft()
            let shadeCornerTopLeft:VCameraCropImageShade = VCameraCropImageShade.noBorder()
            let shadeCornerTopRight:VCameraCropImageShade = VCameraCropImageShade.noBorder()
            let shadeCornerBottomLeft:VCameraCropImageShade = VCameraCropImageShade.noBorder()
            let shadeCornerBottomRight:VCameraCropImageShade = VCameraCropImageShade.noBorder()
            
            insertSubview(shadeTop, aboveSubview:imageView)
            insertSubview(shadeBottom, aboveSubview:imageView)
            insertSubview(shadeLeft, aboveSubview:imageView)
            insertSubview(shadeRight, aboveSubview:imageView)
            insertSubview(shadeCornerTopLeft, aboveSubview:imageView)
            insertSubview(shadeCornerTopRight, aboveSubview:imageView)
            insertSubview(shadeCornerBottomLeft, aboveSubview:imageView)
            insertSubview(shadeCornerBottomRight, aboveSubview:imageView)
            
            NSLayoutConstraint.topToTop(
                view:shadeTop,
                toView:background)
            NSLayoutConstraint.bottomToTop(
                view:shadeTop,
                toView:thumbTopLeft,
                constant:thumbSize_2)
            NSLayoutConstraint.leftToLeft(
                view:shadeTop,
                toView:thumbTopLeft,
                constant:thumbSize_2)
            NSLayoutConstraint.rightToRight(
                view:shadeTop,
                toView:thumbTopRight,
                constant:-thumbSize_2)
            
            NSLayoutConstraint.topToBottom(
                view:shadeBottom,
                toView:thumbBottomLeft,
                constant:-thumbSize_2)
            NSLayoutConstraint.bottomToBottom(
                view:shadeBottom,
                toView:background)
            NSLayoutConstraint.leftToLeft(
                view:shadeBottom,
                toView:thumbBottomLeft,
                constant:thumbSize_2)
            NSLayoutConstraint.rightToRight(
                view:shadeBottom,
                toView:thumbBottomRight,
                constant:-thumbSize_2)
            
            NSLayoutConstraint.topToTop(
                view:shadeLeft,
                toView:thumbTopLeft,
                constant:thumbSize_2)
            NSLayoutConstraint.bottomToBottom(
                view:shadeLeft,
                toView:thumbBottomLeft,
                constant:-thumbSize_2)
            NSLayoutConstraint.leftToLeft(
                view:shadeLeft,
                toView:background)
            NSLayoutConstraint.rightToLeft(
                view:shadeLeft,
                toView:thumbTopLeft,
                constant:thumbSize_2)
            
            NSLayoutConstraint.topToTop(
                view:shadeRight,
                toView:thumbTopRight,
                constant:thumbSize_2)
            NSLayoutConstraint.bottomToBottom(
                view:shadeRight,
                toView:thumbBottomRight,
                constant:-thumbSize_2)
            NSLayoutConstraint.leftToRight(
                view:shadeRight,
                toView:thumbTopRight,
                constant:-thumbSize_2)
            NSLayoutConstraint.rightToRight(
                view:shadeRight,
                toView:background)
            
            NSLayoutConstraint.topToTop(
                view:shadeCornerTopLeft,
                toView:background)
            NSLayoutConstraint.bottomToTop(
                view:shadeCornerTopLeft,
                toView:shadeLeft)
            NSLayoutConstraint.leftToLeft(
                view:shadeCornerTopLeft,
                toView:background)
            NSLayoutConstraint.rightToLeft(
                view:shadeCornerTopLeft,
                toView:shadeTop)
            
            NSLayoutConstraint.topToTop(
                view:shadeCornerTopRight,
                toView:background)
            NSLayoutConstraint.bottomToTop(
                view:shadeCornerTopRight,
                toView:shadeRight)
            NSLayoutConstraint.leftToRight(
                view:shadeCornerTopRight,
                toView:shadeTop)
            NSLayoutConstraint.rightToRight(
                view:shadeCornerTopRight,
                toView:background)
            
            NSLayoutConstraint.topToBottom(
                view:shadeCornerBottomLeft,
                toView:shadeLeft)
            NSLayoutConstraint.bottomToBottom(
                view:shadeCornerBottomLeft,
                toView:background)
            NSLayoutConstraint.leftToLeft(
                view:shadeCornerBottomLeft,
                toView:background)
            NSLayoutConstraint.rightToLeft(
                view:shadeCornerBottomLeft,
                toView:shadeBottom)
            
            NSLayoutConstraint.topToBottom(
                view:shadeCornerBottomRight,
                toView:shadeRight)
            NSLayoutConstraint.bottomToBottom(
                view:shadeCornerBottomRight,
                toView:background)
            NSLayoutConstraint.leftToRight(
                view:shadeCornerBottomRight,
                toView:shadeBottom)
            NSLayoutConstraint.rightToRight(
                view:shadeCornerBottomRight,
                toView:background)
            
            NSLayoutConstraint.topToBottom(
                view:viewMover,
                toView:shadeTop)
            NSLayoutConstraint.bottomToTop(
                view:viewMover,
                toView:shadeBottom)
            NSLayoutConstraint.leftToRight(
                view:viewMover,
                toView:shadeLeft)
            NSLayoutConstraint.rightToLeft(
                view:viewMover,
                toView:shadeRight)
            
            print()
        }
    }
}
