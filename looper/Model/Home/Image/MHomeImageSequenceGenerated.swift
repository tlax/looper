import UIKit

class MHomeImageSequenceGenerated:MHomeImageSequence
{
    init(sequence:MHomeImageSequenceRaw)
    {
        var items:[MHomeImageSequenceItem] = []
        
        for sequenceItem:MHomeImageSequenceItem in sequence.items
        {
            let originalImage:UIImage = sequenceItem.image
            let width:CGFloat = originalImage.size.width
            let height:CGFloat = originalImage.size.height
            
            let rect:CGRect = CGRect(
                x:0,
                y:0,
                width:width,
                height:height)
            UIGraphicsBeginImageContext(rect.size)
            originalImage.draw(in:rect)
            
            guard
                
                let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
            
            else
            {
                UIGraphicsEndImageContext()
                continue
            }
            
            UIGraphicsEndImageContext()
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
