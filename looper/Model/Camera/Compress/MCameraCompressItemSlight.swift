import UIKit

class MCameraCompressItemSlight:MCameraCompressItem
{
    private let kPercent:Int = 80
    
    override init()
    {
        let title:String = NSLocalizedString("MCameraCompressItemSlight_title", comment:"")
        
        super.init(title:title, percent:kPercent)
    }
    
    override init(title:String, percent:Int)
    {
        fatalError()
    }
}
