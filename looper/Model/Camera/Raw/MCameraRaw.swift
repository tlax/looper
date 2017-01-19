import Foundation
import UIKit

class MCameraRaw
{
    var items:[MCameraRawItem]
    let speed:MCameraSpeed
    
    init(speed:MCameraSpeed)
    {
        items = []
        self.speed = speed
    }
    
    //MARK: public
    
    func render() -> MCameraRecordEditable
    {
        let record:MCameraRecordEditable = MCameraRecordEditable(speed:speed)
        
        for item:MCameraRawItem in self.items
        {
            let originalImage:UIImage = item.normalizedImage()
            let width:CGFloat = originalImage.size.width
            let height:CGFloat = originalImage.size.height
            let minRawSize:CGFloat = min(width, height)
            let minSize:CGFloat = min(minRawSize, MCamera.kImageMaxSize)
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
            
            let renderedItem:MCameraRecordItem = MCameraRecordItem(
                image:normalizedImage)
            record.items.append(renderedItem)
        }
        
        return record
    }
}
