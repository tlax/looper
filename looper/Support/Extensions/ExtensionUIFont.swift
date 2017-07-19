import UIKit

extension UIFont
{
    static let kFontRegular:String = "ArialMT"
    static let kFontBold:String = "Arial-BoldMT"
    static let kFontGame:String = "Pixeled"
    
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
    
    class func game(size:CGFloat) -> UIFont
    {
        let font:UIFont = UIFont(name:kFontGame, size:size)!
        
        return font
    }
}
