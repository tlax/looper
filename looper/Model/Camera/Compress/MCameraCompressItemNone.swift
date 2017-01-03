import UIKit

class MCameraCompressItemNone:MCameraCompressItem
{
    override init()
    {
        let title:String = NSLocalizedString("MCameraCompressItemNone_title", comment:"")
        super.init(title:title)
    }
    
    override init(title:String)
    {
        fatalError()
    }
}
