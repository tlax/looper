import UIKit

class VHomeControlBlenderPiecesItem:UIView
{
    let originalX:CGFloat
    let originalY:CGFloat
    weak var layoutTop:NSLayoutConstraint!
    weak var layoutLeft:NSLayoutConstraint!
    weak var model:MHomeImageSequenceRaw!
    private weak var imageView:UIImageView!
    private let kCornerRadius:CGFloat = 8
    private let kImageMargin:CGFloat = 3
    private let kAnimationDuration:TimeInterval = 0.3
    
    init(
        model:MHomeImageSequenceRaw,
        originalX:CGFloat,
        originalY:CGFloat,
        size_2:CGFloat)
    {
        self.originalX = originalX
        self.originalY = originalY
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        layer.cornerRadius = size_2
        self.model = model
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.image = model.items.first?.image
        imageView.layer.cornerRadius = size_2 - kImageMargin
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
    
    func clear()
    {
        model.percentX = nil
        model.percentY = nil
        notSelected()
    }
    
    func selected()
    {
        layer.cornerRadius = bounds.midX
        imageView.layer.cornerRadius = imageView.bounds.midX
        
        backgroundColor = UIColor.white
        superview?.bringSubview(toFront:self)
    }
    
    func notSelected()
    {
        backgroundColor = UIColor.genericLight
    }
    
    func placed()
    {
        layer.cornerRadius = kCornerRadius
        imageView.layer.cornerRadius = kCornerRadius
        
        backgroundColor = UIColor.black
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
