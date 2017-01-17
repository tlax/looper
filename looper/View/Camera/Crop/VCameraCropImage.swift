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
    private let kTopMargin:CGFloat = 50
    private let kMinMargin:CGFloat = 30
    private let kThumbSize:CGFloat = 80
    private let kBackgroundMargin:CGFloat = -2
    
    init(controller:CCameraCrop)
    {
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
        
        let thumbTopLeft:VCameraCropImageThumb = VCameraCropImageThumb()
        self.thumbTopLeft = thumbTopLeft
        
        let thumbTopRight:VCameraCropImageThumb = VCameraCropImageThumb()
        self.thumbTopRight = thumbTopRight
        
        let thumbBottomLeft:VCameraCropImageThumb = VCameraCropImageThumb()
        self.thumbBottomLeft = thumbBottomLeft
        
        let thumbBottomRight:VCameraCropImageThumb = VCameraCropImageThumb()
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
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        let width_margin:CGFloat = width - kMinMargin
        let width_margin2:CGFloat = width_margin - kMinMargin
        let imageMaxY:CGFloat = width_margin2 + kTopMargin
        let marginBottom:CGFloat = height - imageMaxY
        
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
        
        let newLocation:CGPoint = touch.location(in:self)
        let newLocationX:CGFloat = newLocation.x
        let newLocationY:CGFloat = newLocation.y
        draggingThumb.position(
            positionX:newLocationX,
            positionY:newLocationY)
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
}
