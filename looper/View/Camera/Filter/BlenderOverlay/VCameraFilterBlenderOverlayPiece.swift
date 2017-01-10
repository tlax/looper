import UIKit

class VCameraFilterBlenderOverlayPiece:UIView
{
    weak var model:MCameraRecord!
    weak var layoutTop:NSLayoutConstraint!
    weak var layoutLeft:NSLayoutConstraint!
    weak var layoutWidth:NSLayoutConstraint!
    weak var layoutHeight:NSLayoutConstraint!
    private weak var imageView:UIImageView!
    private let draggingMargin2:CGFloat
    private let kCornerRadius:CGFloat = 10
    private let kImageMargin:CGFloat = 3
    private let kAnimationDuration:TimeInterval = 1
    private let kDraggingAnimationDuration:TimeInterval = 0.3
    private let kAlphaDragging:CGFloat = 0.5
    private let kAlphaNotDragging:CGFloat = 1
    private let kDraggingMargin:CGFloat = 30
    
    init(model:MCameraRecord)
    {
        draggingMargin2 = kDraggingMargin + kDraggingMargin
        
        super.init(frame:CGRect.zero)
        isUserInteractionEnabled = false
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = kCornerRadius
        self.model = model
        
        let imageView:UIImageView = UIImageView()
        imageView.alpha = 0
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = model.items.first?.image
        imageView.layer.cornerRadius = kCornerRadius
        self.imageView = imageView
        
        addSubview(imageView)
        
        let layoutImageTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self,
            constant:kImageMargin)
        let layoutImageBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:imageView,
            toView:self,
            constant:-kImageMargin)
        let layoutImageLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self,
            constant:kImageMargin)
        let layoutImageRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:imageView,
            toView:self,
            constant:-kImageMargin)
        
        addConstraints([
            layoutImageTop,
            layoutImageBottom,
            layoutImageLeft,
            layoutImageRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func animateShow()
    {
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
        { [weak self] in
            
            self?.imageView.alpha = 1
        })
        { [weak self] (done:Bool) in
            
            self?.insideBase()
        }
    }
    
    func insideBase()
    {
        backgroundColor = UIColor.genericLight
    }
    
    func outsideBase()
    {
        backgroundColor = UIColor(white:0, alpha:0.8)
    }
    
    func startDragging()
    {
        alpha = kAlphaDragging
        
        layoutTop.constant -= kDraggingMargin
        layoutLeft.constant -= kDraggingMargin
        layoutWidth.constant += draggingMargin2
        layoutHeight.constant += draggingMargin2
        
        UIView.animate(
            withDuration:kDraggingAnimationDuration)
        { [weak self] in
            
            self?.superview?.layoutIfNeeded()
        }
    }
    
    func stopDragging()
    {
        alpha = kAlphaNotDragging
        
        layoutTop.constant += kDraggingMargin
        layoutLeft.constant += kDraggingMargin
        layoutWidth.constant -= draggingMargin2
        layoutHeight.constant -= draggingMargin2
        
        UIView.animate(
            withDuration:kDraggingAnimationDuration)
        { [weak self] in
            
            self?.superview?.layoutIfNeeded()
        }
    }
}
