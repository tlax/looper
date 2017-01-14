import UIKit

class VParentBarButton:UIButton
{
    private weak var border:VBorder!
    private let kBorderHeight:CGFloat = 1
    private let kAlphaNotHover:CGFloat = 1
    private let kAlphaHover:CGFloat = 0.3
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
        
        let border:VBorder = VBorder(color:UIColor.black)
        self.border = border
        
        addSubview(border)
        
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        
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
        imageView!.tintColor = UIColor.black
        isUserInteractionEnabled = false
        border.isHidden = false
    }
    
    func notActive()
    {
        imageView!.tintColor = UIColor(white:0, alpha:kAlphaHover)
        isUserInteractionEnabled = true
        border.isHidden = true
    }
}
