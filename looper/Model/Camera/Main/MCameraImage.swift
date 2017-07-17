import Foundation
import UIKit

class MCameraImage
{
    private let image:UIImage
    
    init(image:UIImage)
    {
        self.image = image
    }
    
    //MARK: public
    
    func render() -> MCameraRecordItem?
    {
        let width:CGFloat = image.size.width
        let height:CGFloat = image.size.height
        let minRawSize:CGFloat = min(width, height)
        let minSize:CGFloat = min(minRawSize, MCamera.kImageMaxSize)
        let deltaWidth:CGFloat = width / minSize
        let deltaHeight:CGFloat = height / minSize
        let minDelta:CGFloat = min(deltaWidth, deltaHeight)
        let width_delta:CGFloat = width / minDelta
        let height_delta:CGFloat = height / minDelta
        let remainLeft:CGFloat = width_delta - minSize
        let remainTop:CGFloat = height_delta - minSize
        let marginLeft:CGFloat = remainLeft / -2.0
        let marginTop:CGFloat = remainTop / -2.0
        
        let imageSize:CGSize = CGSize(
            width:minSize,
            height:minSize)
        let drawingRect:CGRect = CGRect(
            x:marginLeft,
            y:marginTop,
            width:width_delta,
            height:height_delta)
        UIGraphicsBeginImageContext(imageSize)
        image.draw(in:drawingRect)
        
        guard
            
            let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
            
        else
        {
            UIGraphicsEndImageContext()
            
            return nil
        }
        
        UIGraphicsEndImageContext()
        
        let renderedItem:MCameraRecordItem = MCameraRecordItem(
            image:normalizedImage)
        
        return renderedItem
    }
}
