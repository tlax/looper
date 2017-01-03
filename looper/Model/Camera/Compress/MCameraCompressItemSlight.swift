import UIKit

class MCameraCompressItemSlight:MCameraCompressItem
{
    private let kPercent:Int = 80
    
    override init()
    {
        let title:String = NSLocalizedString("MCameraCompressItemSlight_title", comment:"")
        let color:UIColor = UIColor.green
        
        super.init(title:title, percent:kPercent, color:color)
    }
    
    override init(title:String, percent:Int, color:UIColor)
    {
        fatalError()
    }
}
