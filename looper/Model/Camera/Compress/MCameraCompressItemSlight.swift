import UIKit

class MCameraCompressItemSlight:MCameraCompressItem
{
    private let kPercent:Int = 50
    private let kRemoveInterval:Int = 1
    
    override init()
    {
        let title:String = NSLocalizedString("MCameraCompressItemSlight_title", comment:"")
        let color:UIColor = UIColor(red:0.5, green:0.7, blue:0, alpha:1)
        
        super.init(title:title, percent:kPercent, color:color)
    }
    
    override init(title:String, percent:Int, color:UIColor)
    {
        fatalError()
    }
    
    override func compress(record:MCameraRecord) -> MCameraRecord?
    {
        let removeRecord:MCameraRecord = removeInterItems(
            record:record,
            intervalRemove:kRemoveInterval)
        
        return removeRecord
    }
}
