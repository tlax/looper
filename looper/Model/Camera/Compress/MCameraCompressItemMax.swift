import UIKit

class MCameraCompressItemMax:MCameraCompressItem
{
    private let kPercent:Int = 10
    
    override init()
    {
        let title:String = NSLocalizedString("MCameraCompressItemMax_title", comment:"")
        let color:UIColor = UIColor.red
        
        super.init(title:title, percent:kPercent, color:color)
    }
    
    override init(title:String, percent:Int, color:UIColor)
    {
        fatalError()
    }
}
