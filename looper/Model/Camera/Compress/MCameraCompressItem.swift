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
}
