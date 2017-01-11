import UIKit

extension UIColor
{
    open class var genericBackground:UIColor
    {
        get
        {
            return UIColor(
                red:0.96,
                green:0.97,
                blue:0.98,
                alpha:1)
        }
    }
    
    open class var genericDark:UIColor
    {
        get
        {
            return UIColor(
                red:0.15,
                green:0.2,
                blue:0.25,
                alpha:1)
        }
    }
    
    open class var genericLight:UIColor // #5387FD
    {
        get
        {
            return UIColor(
                red:0.325490196078431,
                green:0.529411764705882,
                blue:0.992156862745098,
                alpha:1)
        }
    }
    
    open class var genericAlternative:UIColor // #92CA2E
    {
        get
        {
            return UIColor(
                red:0.572549019607843,
                green:0.792156862745098,
                blue:0.180392156862745,
                alpha:1)
        }
    }
}
