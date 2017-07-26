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
        
    }
    
    private func exportDuration()
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
    
    //MARK: public
    
    func config(edit:MEdit)
    {
        self.edit = edit
    }
}
