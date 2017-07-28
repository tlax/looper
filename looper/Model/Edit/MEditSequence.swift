import Foundation

class MEditSequence
{
    let items:[MEditSequenceItem]
    var duration:TimeInterval
    var crop:MEditSequenceCrop
    
    init(items:[MEditSequenceItem], duration:TimeInterval)
    {
        self.items = items
        self.duration = duration
        crop = MEditSequenceCrop(
            top:0,
            bottom:0,
            left:0,
            right:0)
    }
}
