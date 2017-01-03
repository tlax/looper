import UIKit

class MCameraCompressItemMedium:MCameraCompressItem
{
    override init()
    {
        let title:String = NSLocalizedString("MCameraCompressItemMedium_title", comment:"")
        super.init(title:title)
    }
    
    override init(title:String)
    {
        fatalError()
    }
}
