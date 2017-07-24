import UIKit

extension UIFont
{
    static let kFontRegular:String = "HelveticaNeue"
    static let kFontLight:String = "HelveticaNeue-Thin"
    static let kFontBold:String = "HelveticaNeue-Bold"
    
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
