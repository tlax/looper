import UIKit

class MCameraCompressItemSlight:MCameraCompressItem
{
    private let kResize:CGFloat = 0.5
    private let kPercent:Int = 80
    
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
        let lowerQuality:MCameraRecord = lowerImageQuality(
            record:record,
            resize:kResize)
        
        return lowerQuality
    }
}
