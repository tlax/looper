import UIKit

class MCameraCompressItemMedium:MCameraCompressItem
{
    private let kPercent:Int = 50
    
    override init()
    {
        let title:String = NSLocalizedString("MCameraCompressItemMedium_title", comment:"")
        let color:UIColor = UIColor.orange
        
        super.init(title:title, percent:kPercent, color:color)
    }
    
    override init(title:String, percent:Int, color:UIColor)
    {
        fatalError()
    }
}
