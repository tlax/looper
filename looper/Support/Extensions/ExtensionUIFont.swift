import UIKit

extension UIFont
{
    static let kFontRegular:String = "ContinuumMedium"
    static let kFontLight:String = "ContinuumLight"
    static let kFontBold:String = "ContinuumBold"
    
    class func regular(size:CGFloat) -> UIFont
    {
        let font:UIFont = UIFont(name:kFontRegular, size:size)!
        
        return font
    }
    
    class func bold(size:CGFloat) -> UIFont
    {
        let font:UIFont = UIFont(name:kFontBold, size:size)!
        
        return font
    }
    
    class func light(size:CGFloat) -> UIFont
    {
        let font:UIFont = UIFont(name:kFontLight, size:size)!
        
        return font
    }
}
