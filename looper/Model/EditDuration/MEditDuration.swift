import Foundation

class MEditDuration:Model
{
    private(set) weak var edit:MEdit!
    var selectedMinute:Int
    var selectedSecond:Int
    let minutes:[MEditDurationItem]
    let seconds:[MEditDurationItem]
    private let kSecondsPerMinute:Int = 60
    private let kMinSeconds:Int = 1
    
    required init()
    {
        minutes = MEditDuration.factoryMinutes()
        seconds = MEditDuration.factorySeconds()
        selectedMinute = 0
        selectedSecond = 0
        
        super.init()
    }
    
    //MARK: private
    
    private func importDuration()
    {
        guard
        
            let duration:TimeInterval = edit.sequence?.duration
        
        else
        {
            return
        }
        
        let totalSeconds:Int = Int(duration)
        let minutesValue:Int = totalSeconds / kSecondsPerMinute
        let secondsValue:Int = totalSeconds % kSecondsPerMinute
        let countMinutes:Int = minutes.count
        let countSeconds:Int = seconds.count
        
        for indexMinute:Int in 0 ..< countMinutes
        {
            let itemMinute:MEditDurationItem = minutes[indexMinute]
            let itemValue:Int = itemMinute.value
            
            if itemValue == minutesValue
            {
                selectedMinute = indexMinute
                
                break
            }
        }
        
        for indexSecond:Int in 0 ..< countSeconds
        {
            let itemSecond:MEditDurationItem = seconds[indexSecond]
            let itemValue:Int = itemSecond.value
            
            if itemValue == secondsValue
            {
                selectedSecond = indexSecond
                
                break
            }
        }
    }
    
    //MARK: public
    
    func config(edit:MEdit)
    {
        self.edit = edit
        importDuration()
    }
    
    func exportDuration()
    {
        let minute:MEditDurationItem = minutes[selectedMinute]
        let second:MEditDurationItem = seconds[selectedSecond]
        let minuteValue:Int = minute.value
        let secondValue:Int = second.value
        let minuteSeconds:Int = minuteValue * kSecondsPerMinute
        var totalSeconds:Int = minuteSeconds + secondValue
        
        if totalSeconds < kMinSeconds
        {
            totalSeconds = kMinSeconds
        }
        
        let duration:TimeInterval = TimeInterval(totalSeconds)
        edit.sequence?.duration = duration
    }
    
    func currentMinute() -> MEditDurationItem
    {
        let item:MEditDurationItem = minutes[selectedMinute]
        
        return item
    }
    
    func currentSecond() -> MEditDurationItem
    {
        let item:MEditDurationItem = seconds[selectedSecond]
        
        return item
    }
}
