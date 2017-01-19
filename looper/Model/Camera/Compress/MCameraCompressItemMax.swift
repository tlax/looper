import UIKit

class MCameraCompressItemMax:MCameraCompressItem
{
    private let kResize:CGFloat = 0.6
    private let kQuality:CGFloat = 0.1
    private let kPercent:Int = 10
    private let kRemoveInterval:Int = 3
    
    init()
    {
        let title:String = NSLocalizedString("MCameraCompressItemMax_title", comment:"")
        let color:UIColor = UIColor(red:0.9, green:0, blue:0, alpha:1)
        
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
