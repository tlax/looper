import UIKit

extension NSLayoutConstraint
{
    class func leftToLeft(view:UIView, toView:UIView, constant:CGFloat) -> NSLayoutConstraint
    {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(
            item:view,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:toView,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:constant)
        
        return constraint
    }
    
    class func leftToRight(view:UIView, toView:UIView, constant:CGFloat) -> NSLayoutConstraint
    {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(
            item:view,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:toView,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:constant)
        
        return constraint
    }
    
    class func rightToRight(view:UIView, toView:UIView, constant:CGFloat) -> NSLayoutConstraint
    {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(
            item:view,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:toView,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:constant)
        
        return constraint
    }
    
    class func rightToLeft(view:UIView, toView:UIView, constant:CGFloat) -> NSLayoutConstraint
    {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(
            item:view,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:toView,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:constant)
        
        return constraint
    }
}
