import UIKit

class VCameraCropImageShade:UIView
{
    private let kBorderSize:CGFloat = 2
    
    init(
        borderTop:Bool = false,
        borderBottom:Bool = false,
        borderLeft:Bool = false,
        borderRight:Bool = false)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        
        let blur:VBlur = VBlur.dark()
        
        addSubview(blur)
        
        if borderTop
        {
            let border:VBorder = VBorder(color:UIColor.white)
            
            addSubview(border)
            
            NSLayoutConstraint.topToTop(
                view:border,
                toView:self)
            NSLayoutConstraint.height(
                view:border,
                constant:kBorderSize)
            NSLayoutConstraint.equalsHorizontal(
                view:border,
                toView:self)
        }
        
        if borderBottom
        {
            let border:VBorder = VBorder(color:UIColor.white)
            
            addSubview(border)
            
            NSLayoutConstraint.bottomToBottom(
                view:border,
                toView:self)
            NSLayoutConstraint.height(
                view:border,
                constant:kBorderSize)
            NSLayoutConstraint.equalsHorizontal(
                view:border,
                toView:self)
        }
        
        if borderLeft
        {
            let border:VBorder = VBorder(color:UIColor.white)
            
            addSubview(border)
            
            NSLayoutConstraint.equalsVertical(
                view:border,
                toView:self)
            NSLayoutConstraint.leftToLeft(
                view:border,
                toView:self)
            NSLayoutConstraint.width(
                view:border,
                constant:kBorderSize)
        }
        
        if borderRight
        {
            let border:VBorder = VBorder(color:UIColor.white)
            
            addSubview(border)
            
            NSLayoutConstraint.equalsVertical(
                view:border,
                toView:self)
            NSLayoutConstraint.rightToRight(
                view:border,
                toView:self)
            NSLayoutConstraint.width(
                view:border,
                constant:kBorderSize)
        }
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
