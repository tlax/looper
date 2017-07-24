import UIKit

extension MSourceVideoImportFactory
{
    class func factorySequence(
        duration:TimeInterval,
        images:[CGImage]) -> MEditSequence
    {
        var items:[MEditSequenceItem] = []
        
        for image:CGImage in images
        {
            let item:MEditSequenceItem = MEditSequenceItem(
                image:image)
            items.append(item)
        }
        
        let sequence:MEditSequence = MEditSequence(
            items:items,
            duration:duration)
        
        return sequence
    }
}
