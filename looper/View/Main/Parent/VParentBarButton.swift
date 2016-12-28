import UIKit

class VParentBarButton:UIButton
{
    private weak var border:UIView!
    private let kBorderHeight:CGFloat = 2
    private let kBorderMargin:CGFloat = 15
    private let kAlphaNotHover:CGFloat = 1
    private let kAlphaHover:CGFloat = 0.5
    private let kInsetTop:CGFloat = 20
    
    convenience init(image:UIImage)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        setImage(
            image.withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.normal)
        setImage(
            image.withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        imageView!.contentMode = UIViewContentMode.center
        imageView!.clipsToBounds = true
        imageEdgeInsets = UIEdgeInsets(
            top:kInsetTop,
            left:0,
            bottom:0,
            right:0)
        
        let border:UIView = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = UIColor.genericLight
        border.isUserInteractionEnabled = false
        border.clipsToBounds = true
        self.border = border
        
        addSubview(border)
        
        let layoutBorderHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        let layoutBorderBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        let layoutBorderLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:border,
            toView:self,
            constant:kBorderMargin)
        let layoutBorderRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:border,
            toView:self,
            constant:kBorderMargin)
        
        addConstraints([
            layoutBorderHeight,
            layoutBorderBottom,
            layoutBorderLeft,
            layoutBorderRight])
        
        notActive()
    }
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: private
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            alpha = kAlphaHover
        }
        else
        {
            alpha = kAlphaNotHover
        }
    }
    
    //MARK: public
    
    func active()
    {
        imageView!.tintColor = UIColor.genericLight
        isUserInteractionEnabled = false
        border.isHidden = true
    }
    
    func notActive()
    {
        imageView!.tintColor = UIColor.genericLight.withAlphaComponent(kAlphaHover)
        isUserInteractionEnabled = true
        border.isHidden = false
    }
}
