import UIKit

class MCameraCompressItem
{
    let title:String
    let percent:Int
    let color:UIColor
    private let kCompressQuality:CGFloat = 0.1
    
    init(title:String, percent:Int, color:UIColor)
    {
        self.title = title
        self.percent = percent
        self.color = color
    }
    
    init()
    {
        fatalError()
    }
    
    //MARK: public
    
    func compress(record:MCameraRecord) -> MCameraRecord?
    {
        return nil
    }
    
    func removeInterItems(record:MCameraRecord, intervalRemove:Int) -> MCameraRecord
    {
        let removedRecord:MCameraRecord = MCameraRecord()
        let countItems:Int = record.items.count
        var indexItem:Int = 0
        
        while indexItem < countItems
        {
            let item:MCameraRecordItem = record.items[indexItem]
            removedRecord.items.append(item)
            
            indexItem += intervalRemove + 1
        }
        
        return removedRecord
    }
    
    func lowerImageQuality(record:MCameraRecord, resize:CGFloat) -> MCameraRecord
    {
        let lowerRecord:MCameraRecord = MCameraRecord()
        
        for originalItem:MCameraRecordItem in record.items
        {
            let newItem:MCameraRecordItem
            let originalImage:UIImage = originalItem.image
            
            guard
                
                let originalData:Data = UIImageJPEGRepresentation(
                                        originalImage,
                                        kCompressQuality),
                let compressedImage:UIImage = UIImage(data:originalData)
            
            else
            {
                newItem = MCameraRecordItem(image:originalImage)
                lowerRecord.items.append(newItem)
                
                continue
            }
            
            let originalSize:CGFloat = originalImage.size.width
            let scaledSize:CGFloat = originalSize * resize
            let imageSize:CGSize = CGSize(
                width:scaledSize,
                height:scaledSize)
            let drawingRect:CGRect = CGRect(
                origin:CGPoint.zero,
                size:imageSize)
            
            UIGraphicsBeginImageContext(imageSize)
            compressedImage.draw(in:drawingRect)
            
            guard
                
                let scaledImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
            
            else
            {
                UIGraphicsEndImageContext()
                newItem = MCameraRecordItem(image:originalImage)
                lowerRecord.items.append(newItem)
                
                continue
            }
            
            UIGraphicsEndImageContext()
            newItem = MCameraRecordItem(image:scaledImage)
            lowerRecord.items.append(newItem)
        }
        
        return lowerRecord
    }
}
