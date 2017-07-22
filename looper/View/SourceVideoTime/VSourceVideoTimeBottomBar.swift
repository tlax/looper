import UIKit

class VSourceVideoTimeBottomBar:
    View<VSourceVideoTime, MSourceVideoTime, CSourceVideoTime>
{
    private let kBorderHeight:CGFloat = 1
    
    required init(controller:CSourceVideoTime)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.colourSuccess
        
        let border:VBorder = VBorder(
            colour:UIColor.black)
        
        addSubview(border)
        
        NSLayoutConstraint.topToTop(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
