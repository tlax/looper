import Foundation

class MEditSequence
{
    let items:[MEditSequenceItem]
    var duration:TimeInterval
    
    init(items:[MEditSequenceItem], duration:TimeInterval)
    {
        self.items = items
        self.duration = duration
    }
}
