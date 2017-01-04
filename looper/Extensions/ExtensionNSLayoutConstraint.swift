import UIKit

extension NSLayoutConstraint
{
    class func topToTop(view:UIView, toView:UIView, constant:CGFloat = 0) -> NSLayoutConstraint
    {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(
            item:view,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:toView,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:constant)
        
        return constraint
    }
    
    class func topToBottom(view:UIView, toView:UIView, constant:CGFloat = 0) -> NSLayoutConstraint
    {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(
            item:view,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:toView,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:constant)
        
        return constraint
    }
    
    class func bottomToBottom(view:UIView, toView:UIView, constant:CGFloat = 0) -> NSLayoutConstraint
    {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(
            item:view,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:toView,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:constant)
        
        return constraint
    }
    
    class func bottomToTop(view:UIView, toView:UIView, constant:CGFloat = 0) -> NSLayoutConstraint
    {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(
            item:view,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:toView,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:constant)
        
        return constraint
    }
    
    class func leftToLeft(view:UIView, toView:UIView, constant:CGFloat = 0) -> NSLayoutConstraint
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
    
    class func leftToRight(view:UIView, toView:UIView, constant:CGFloat = 0) -> NSLayoutConstraint
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
    
    class func rightToRight(view:UIView, toView:UIView, constant:CGFloat = 0) -> NSLayoutConstraint
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
    
    class func rightToLeft(view:UIView, toView:UIView, constant:CGFloat = 0) -> NSLayoutConstraint
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
    
    class func width(view:UIView, constant:CGFloat = 0) -> NSLayoutConstraint
    {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(
            item:view,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:constant)
        
        return constraint
    }
    
    class func height(view:UIView, constant:CGFloat = 0) -> NSLayoutConstraint
    {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(
            item:view,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:constant)
        
        return constraint
    }
    
    class func equals(view:UIView, parent:UIView) -> [NSLayoutConstraint]
    {
        let top:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:view,
            toView:parent)
        let bottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:view,
            toView:parent)
        let left:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:view,
            toView:parent)
        let right:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:view,
            toView:parent)
        
        let constraints:[NSLayoutConstraint] = [
            top,
            bottom,
            left,
            right
        ]
        
        return constraints
    }
}
