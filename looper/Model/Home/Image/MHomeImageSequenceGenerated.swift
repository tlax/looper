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
            let minSize:CGFloat = min(width, height)
            let remainLeft:CGFloat = width - minSize
            let remainTop:CGFloat = height - minSize
            let marginLeft:CGFloat = remainLeft / -2.0
            let marginTop:CGFloat = remainTop / -2.0
            
            let imageSize:CGSize = CGSize(
                width:minSize,
                height:minSize)
            let drawingRect:CGRect = CGRect(
                x:marginLeft,
                y:marginTop,
                width:width,
                height:height)
            UIGraphicsBeginImageContext(imageSize)
            originalImage.draw(in:drawingRect)
            
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
