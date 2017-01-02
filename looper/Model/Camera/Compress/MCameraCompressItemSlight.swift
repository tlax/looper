import UIKit

class MCameraCompressItemSlight:MCameraCompressItem
{
    override init()
    {
        let title:String = NSLocalizedString("", comment:"")
        super.init(title:title)
    }
    
    override init(title:String)
    {
        fatalError()
    }
}
