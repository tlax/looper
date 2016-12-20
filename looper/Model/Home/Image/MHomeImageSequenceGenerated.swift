import UIKit

class MHomeImageSequenceGenerated:MHomeImageSequence
{
    private let kDefaultOrientation:UIImageOrientation = UIImageOrientation.up
    
    init(sequence:MHomeImageSequenceRaw)
    {
        var items:[MHomeImageSequenceItem] = []
        
        for sequenceItem:MHomeImageSequenceItem in sequence.items
        {
            let originalImage:UIImage = sequenceItem.image
            let scale:CGFloat = originalImage.scale
            
            guard
                
                let originalCgImage:CGImage = originalImage.cgImage
            
            else
            {
                continue
            }
            
            let normalizedImage:UIImage = UIImage(
                cgImage:originalCgImage,
                scale:scale,
                orientation:kDefaultOrientation)
            
            let generatedItem:MHomeImageSequenceItem = MHomeImageSequenceItem(
                image:normalizedImage)
            items.append(generatedItem)
        }
        
        super.init(items:items)
    }
    
    override init()
    {
        fatalError()
    }
    
    override init(items:[MHomeImageSequenceItem])
    {
        fatalError()
    }
}
