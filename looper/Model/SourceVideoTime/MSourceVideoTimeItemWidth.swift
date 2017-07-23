import Foundation

class MSourceVideoTimeItemWidth:MSourceVideoTimeItemProtocol
{
    private let stringValue:String
    
    required init(item:MSourceVideoItem)
    {
        stringValue = "\(duration:item.asset.pixelWidth)"
    }
    
    var title:String
    {
        get
        {
            return String.localizedModel(
                key:"MSourceVideoTimeItemWidth_title")
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
