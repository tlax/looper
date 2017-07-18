import UIKit

class MCameraVideo
{
    let images:[UIImage]
    
    init(images:[UIImage])
    {
        self.images = images
    }
    
    //MARK: private
    
    private func itemsFrom(
        images:[UIImage],
        imageSize:CGSize,
        drawingRect:CGRect) -> [MCameraRecordItem]
    {
        var items:[MCameraRecordItem] = []
        
        
        
        for image:UIImage in images
        {
            
            
            let renderedItem:MCameraRecordItem = MCameraRecordItem(
                image:image)
            items.append(renderedItem)
        }
        
        return items
    }
    
    //MARK: public
    
    func render() -> [MCameraRecordItem]
    {
        guard
        
            let firstImage:UIImage = images.first
        
        else
        {
            return []
        }
        
        let width:CGFloat = firstImage.size.width
        let height:CGFloat = firstImage.size.height
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
