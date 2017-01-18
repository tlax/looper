import UIKit

class MCameraCompressItemMedium:MCameraCompressItem
{
    private let kResize:CGFloat = 0.8
    private let kQuality:CGFloat = 0.5
    private let kPercent:Int = 30
    private let kRemoveInterval:Int = 2
    
    override init()
    {
        let title:String = NSLocalizedString("MCameraCompressItemMedium_title", comment:"")
        let color:UIColor = UIColor(red:0.9, green:0.5, blue:0, alpha:1)
        
        super.init(title:title, percent:kPercent, color:color)
    }
    
    override func compress(record:MCameraRecord) -> MCameraRecord?
    {
        let removeRecord:MCameraRecord = removeInterItems(
            record:record,
            intervalRemove:kRemoveInterval)
        let lowerQuality:MCameraRecord = lowerImageQuality(
            record:removeRecord,
            quality:kQuality,
            resize:kResize)
        
        return lowerQuality
    }
}
