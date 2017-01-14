import UIKit

class VCameraCellControlsButton:UIButton
{
    private let kBorderWidth:CGFloat = 1
    
    init(image:UIImage, border:Bool)
    {
        super.init(frame:CGRect.zero)
        backgroundColor = UIColor.genericLight
        translatesAutoresizingMaskIntoConstraints = false
        setImage(
            image.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        setImage(
            image.withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        imageView!.tintColor = UIColor(white:0, alpha:0.1)
        imageView!.clipsToBounds = true
        imageView!.contentMode = UIViewContentMode.center
        
        if border
        {
            let viewBorder:UIView = UIView()
            viewBorder.isUserInteractionEnabled = false
            viewBorder.translatesAutoresizingMaskIntoConstraints = false
            viewBorder.clipsToBounds = true
            viewBorder.backgroundColor = UIColor.black
            
            addSubview(viewBorder)
            
            let constraintsBorderVertical:[NSLayoutConstraint] = NSLayoutConstraint.equalsVertical(
                view:viewBorder,
                toView:self)
            
            let layoutBorderLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
                view:viewBorder,
                toView:self)
            let layoutBorderWidth:NSLayoutConstraint = NSLayoutConstraint.width(
                view:viewBorder,
                constant:kBorderWidth)
            
            addConstraints(constraintsBorderVertical)
            
            addConstraints([
                layoutBorderLeft,
                layoutBorderWidth])
        }
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
