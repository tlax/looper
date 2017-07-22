import Foundation

class MSourceVideoTimeItemDuration:MSourceVideoTimeItemProtocol
{
    private static let kSecondsInMinute:TimeInterval = 60
    
    private let stringValue:String
    
    required init(item:MSourceVideoItem)
    {
        stringValue = MSourceVideoTimeItemDuration.durationFrom(
            duration:item.asset.duration)
    }
    
    var title:String
    {
        get
        {
            return String.localizedModel(
                key:"MSourceVideoTimeItemDuration_title")
        }
    }
    
    var value:String
    {
        get
        {
            return stringValue
        }
    }
    
    //MARK: private
    
    private class func durationFrom(duration:TimeInterval) -> String
    {
        let minutes:Int = Int(duration / kSecondsInMinute)
        let seconds:Int = Int(
            duration.truncatingRemainder(
                dividingBy:kSecondsInMinute))
        var string:String
        
        if minutes > 9
        {
            string = "\(minutes)"
        }
        else
        {
            string = "0\(minutes)"
        }
        
        string = "\(string):"
        
        if seconds < 10
        {
            string = "\(string)0"
        }
        
        string = "\(string)\(seconds)"
        
        return string
    }
}
