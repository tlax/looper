import UIKit

class VHomeControlBlenderPiecesItem:UIView
{
    let originalX:CGFloat
    let originalY:CGFloat
    weak var layoutTop:NSLayoutConstraint!
    weak var layoutLeft:NSLayoutConstraint!
    weak var model:MHomeImageSequenceItem!
    private weak var imageView:UIImageView!
    private let kCornerRadius:CGFloat = 8
    private let kImageMargin:CGFloat = 3
    private let kAnimationDuration:TimeInterval = 0.3
    
    init(model:MHomeImageSequenceItem, originalX:CGFloat, originalY:CGFloat)
    {
        self.originalX = originalX
        self.originalY = originalY
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        layer.cornerRadius = kCornerRadius
        self.model = model
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.image = model.image
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
        
        notSelected()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func selected()
    {
        backgroundColor = UIColor.white
        superview?.bringSubview(toFront:self)
    }
    
    func notSelected()
    {
        backgroundColor = UIColor.genericLight
    }
    
    func restartPlace()
    {
        layoutLeft.constant = originalX
        layoutTop.constant = originalY
        
        UIView.animate(
            withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.superview?.layoutIfNeeded()
        }
    }
}
