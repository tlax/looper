import UIKit

extension UIColor
{
    open class var colourSuccess:UIColor //#4990E2
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
    
    open class var colourFail:UIColor //#DC0000
    {
        get
        {
            return UIColor(
                red:0.862745098039216,
                green:0,
                blue:0,
                alpha:1)
        }
    }
}
