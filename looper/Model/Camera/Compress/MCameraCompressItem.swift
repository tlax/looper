import UIKit

class MCameraCompressItem
{
    let title:String
    let percent:Int
    let color:UIColor
    
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
    
    func lowerImageQuality(record:MCameraRecord, quality:CGFloat) -> MCameraRecord
    {
        let lowerRecord:MCameraRecord = MCameraRecord()
        
        for originalItem:MCameraRecordItem in record.items
        {
            let originalImage:UIImage = originalItem.image
            let newItem:MCameraRecordItem
            
            guard
            
                let data:Data = UIImageJPEGRepresentation(
                                originalImage,
                                quality),
                let newImage:UIImage = UIImage(data:data)
            
            else
            {
                newItem = MCameraRecordItem(image:originalImage)
                lowerRecord.items.append(newItem)
                
                continue
            }
            
            newItem = MCameraRecordItem(image:newImage)
            lowerRecord.items.append(newItem)
        }
        
        return lowerRecord
    }
}
