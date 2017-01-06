import UIKit

class MCameraCompress
{
    let items:[MCameraCompressItem]
    var currentCompress:MCameraCompressItem?
    private weak var model:MCameraRecord?
    private let kBytesPerKilo:CGFloat = 1000
    private let kPercentMulti:CGFloat = 100
    private let kMaxDecimal:Int = 2
    private let kMinInteger:Int = 1
    
    init(model:MCameraRecord)
    {
        let itemNone:MCameraCompressItemNone = MCameraCompressItemNone()
        let itemSlight:MCameraCompressItemSlight = MCameraCompressItemSlight()
        let itemMedium:MCameraCompressItemMedium = MCameraCompressItemMedium()
        let itemMax:MCameraCompressItemMax = MCameraCompressItemMax()
        
        items = [
            itemNone,
            itemSlight,
            itemMedium,
            itemMax
        ]
        
        currentCompress = items.first
        self.model = model
    }
    
    //MARK: public
    
    func loadSizes()
    {
        guard
            
            let model:MCameraRecord = self.model
        
        else
        {
            return
        }
        
        let numberFormatter:NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = kMaxDecimal
        numberFormatter.minimumIntegerDigits = kMinInteger
        
        var totalBytes:Int = 0
        
        for item:MCameraRecordItem in model.items
        {
            let image:UIImage = item.image
            
            guard
            
                let data:Data = UIImageJPEGRepresentation(image, 1)
            
            else
            {
                continue
            }
            
            totalBytes += data.count
        }
        
        let kiloBytes:CGFloat = CGFloat(totalBytes) / kBytesPerKilo
        
        for item:MCameraCompressItem in items
        {
            let percent:CGFloat = CGFloat(item.percent) / kPercentMulti
            let itemSize:CGFloat = percent * kiloBytes
            let itemNumber:NSNumber = itemSize as NSNumber
            
            guard
                
                let sizeString:String = numberFormatter.string(from:itemNumber)
            
            else
            {
                continue
            }
            
            item.size = sizeString
            
            print("size: \(sizeString)")
        }
    }
}
