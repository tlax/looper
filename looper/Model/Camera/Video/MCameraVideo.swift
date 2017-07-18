import UIKit

class MCameraVideo
{
    let images:[CGImage]
    
    init(images:[CGImage])
    {
        self.images = images
    }
    
    //MARK: private
    
    private func itemsFrom(
        images:[CGImage],
        imageSize:CGSize,
        drawingRect:CGRect) -> [MCameraRecordItem]
    {
        var items:[MCameraRecordItem] = []
        
        for image:CGImage in images
        {
            
            UIGraphicsBeginImageContext(imageSize)
            
            guard
                
                let context:CGContext = UIGraphicsGetCurrentContext()
            
            else
            {
                UIGraphicsEndImageContext()
                
                continue
            }
            
            context.translateBy(x:0, y:imageSize.height)
            context.scaleBy(x:1, y:-1)
            context.draw(image, in:drawingRect)
            
            guard
                
                let newCGImage:CGImage = context.makeImage()
            
            else
            {
                UIGraphicsEndImageContext()
                
                continue
            }
            
            UIGraphicsEndImageContext()
            
            let newImage:UIImage = UIImage(
                cgImage:newCGImage,
                scale:1,
                orientation:UIImageOrientation.up)
            
            let renderedItem:MCameraRecordItem = MCameraRecordItem(
                image:newImage)
            items.append(renderedItem)
        }
        
        return items
    }
    
    //MARK: public
    
    func render() -> [MCameraRecordItem]
    {
        guard
        
            let firstImage:CGImage = images.first
        
        else
        {
            return []
        }
        
        let width:CGFloat = CGFloat(firstImage.width)
        let height:CGFloat = CGFloat(firstImage.height)
        let minRawSize:CGFloat = min(width, height)
        let minSize:CGFloat = min(minRawSize, MCamera.kImageMaxSize)
        let deltaWidth:CGFloat = width / minSize
        let deltaHeight:CGFloat = height / minSize
        let maxDelta:CGFloat = max(deltaWidth, deltaHeight)
        let width_delta:CGFloat = width / maxDelta
        let height_delta:CGFloat = height / maxDelta
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
        
        let items:[MCameraRecordItem] = itemsFrom(
            images:images,
            imageSize:imageSize,
            drawingRect:drawingRect)
        
        return items
    }
}
