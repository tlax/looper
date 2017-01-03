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
}
