import UIKit

class MCameraCompressItemMedium:MCameraCompressItem
{
    private let kPercent:Int = 50
    
    override init()
    {
        let title:String = NSLocalizedString("MCameraCompressItemMedium_title", comment:"")
        
        super.init(title:title, percent:kPercent)
    }
    
    override init(title:String, percent:Int)
    {
        fatalError()
    }
}
