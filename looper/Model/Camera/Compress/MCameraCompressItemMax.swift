import UIKit

class MCameraCompressItemMax:MCameraCompressItem
{
    private let kPercent:Int = 10
    
    override init()
    {
        let title:String = NSLocalizedString("MCameraCompressItemMax_title", comment:"")
        
        super.init(title:title, percent:kPercent)
    }
    
    override init(title:String, percent:Int)
    {
        fatalError()
    }
}
