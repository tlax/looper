import UIKit

class MCameraCompressItemNone:MCameraCompressItem
{
    private let kPercent:Int = 100
    
    init()
    {
        let title:String = NSLocalizedString("MCameraCompressItemNone_title", comment:"")
        let color:UIColor = UIColor.genericLight
        
        super.init(title:title, percent:kPercent, color:color)
    }
    
    override func compress(record:MCameraRecord) -> MCameraRecord?
    {
        return record
    }
}
