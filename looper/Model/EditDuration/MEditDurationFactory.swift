import Foundation

extension MEditDuration
{
    private static let kMinMinutes:Int = 0
    private static let kMaxMinutes:Int = 30
    private static let kMinSeconds:Int = 0
    private static let kMaxSeconds:Int = 60
    
    class func factoryMinutes() -> [MEditDurationItem]
    {
        var items:[MEditDurationItem] = []
        
        for minute:Int in kMinMinutes ..< kMaxMinutes
        {
            let item:MEditDurationItem = MEditDurationItem(
                value:minute)
            items.append(item)
        }
        
        return items
    }
    
    class func factorySeconds() -> [MEditDurationItem]
    {
        var items:[MEditDurationItem] = []
        
        for second:Int in kMinSeconds ..< kMaxSeconds
        {
            let item:MEditDurationItem = MEditDurationItem(
                value:second)
            items.append(item)
        }
        
        return items
    }
}
