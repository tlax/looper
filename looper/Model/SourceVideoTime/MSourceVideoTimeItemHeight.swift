import Foundation

class MSourceVideoTimeItemHeight:MSourceVideoTimeItemProtocol
{
    private let stringValue:String
    
    required init(item:MSourceVideoItem)
    {
        stringValue = "\(item.asset.pixelHeight)"
    }
    
    var title:String
    {
        get
        {
            return String.localizedModel(
                key:"MSourceVideoTimeItemHeight_title")
        }
    }
    
    var value:String
    {
        get
        {
            return stringValue
        }
    }
}
