import UIKit

class MCameraCompressItemNone:MCameraCompressItem
{
    private let kPercent:Int = 100
    
    override init()
    {
        let title:String = NSLocalizedString("MCameraCompressItemNone_title", comment:"")
        
        super.init(title:title, percent:kPercent)
    }
    
    override init(title:String, percent:Int)
    {
        fatalError()
    }
}
