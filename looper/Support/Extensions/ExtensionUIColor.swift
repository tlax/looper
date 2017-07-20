import UIKit

extension UIColor
{
    open class var colourSuccess:UIColor
    {
        get
        {
            return UIColor(
                red:0.290196078431373,
                green:0.564705882352941,
                blue:0.886274509803922,
                alpha:1)
        }
    }
    
    open class var colourFail:UIColor
    {
        get
        {
            return UIColor(
                red:1,
                green:0.4666666666666667,
                blue:0,
                alpha:1)
        }
    }
    
    open class var colourGradientLight:UIColor
    {
        get
        {
            return UIColor(
                red:0.47450980392156855,
                green:0.7137254901960784,
                blue:0.996078431372549,
                alpha:1)
        }
    }
    
    open class var colourGradientDark:UIColor
    {
        get
        {
            return UIColor(
                red:0.16078431372549015,
                green:0.4235294117647058,
                blue:0.7254901960784313,
                alpha:1)
        }
    }
    
    open class var colourBackgroundGray:UIColor
    {
        get
        {
            return UIColor(
                red:0.95,
                green:0.96,
                blue:0.97,
                alpha:1)
        }
    }
}
