import Foundation

class MCameraCompressItem
{
    let title:String
    let percent:Int
    
    init(title:String, percent:Int)
    {
        self.title = title
        self.percent = percent
    }
    
    init()
    {
        fatalError()
    }
}
