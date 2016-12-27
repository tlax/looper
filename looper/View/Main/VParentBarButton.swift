import UIKit

class VParentBarButton:UIButton
{
    private let kAlphaNotHover:CGFloat = 1
    private let kAlphaHover:CGFloat = 0.2
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
        
        notSelected()
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
    }
    
    func notActive()
    {
        imageView!.tintColor = UIColor(white:0.85, alpha:1)
        isUserInteractionEnabled = true
    }
}
