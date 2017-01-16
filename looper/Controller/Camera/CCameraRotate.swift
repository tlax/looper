import UIKit

class CCameraRotate:CController
{
    weak var viewRotate:VCameraRotate!
    weak var record:MCameraRecordEditable!
    
    init(record:MCameraRecordEditable)
    {
        self.record = record
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewRotate:VCameraRotate = VCameraRotate(controller:self)
        self.viewRotate = viewRotate
        view = viewRotate
    }
    
    //MARK: private
    
    private func asyncSave(orientation:UIImageOrientation)
    {
        var rotatedRecords:[MCameraRecordItem] = []
        
        guard
            
            let firstImage:UIImage = record.items.first?.image
        
        else
        {
            return
        }
        
        let size:CGFloat = firstImage.size.width
        let imageSize:CGSize = CGSize(
            width:size,
            height:size)
        let drawingRect:CGRect = CGRect(
            x:0,
            y:0,
            width:size,
            height:size)
        
        for rawItem:MCameraRecordItem in record.items
        {
            let originalImage:UIImage = rawItem.image
            
            guard
                
                let cgImage:CGImage = originalImage.cgImage
                
            else
            {
                continue
            }
            
            let expectedImage:UIImage = UIImage(
                cgImage:cgImage,
                scale:originalImage.scale,
                orientation:orientation)
            
            UIGraphicsBeginImageContext(imageSize)
            expectedImage.draw(in:drawingRect)
            
            guard
                
                let rotatedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
                
            else
            {
                UIGraphicsEndImageContext()
                continue
            }
            
            UIGraphicsEndImageContext()
            
            let rotatedItem:MCameraRecordItem = MCameraRecordItem(
                image:rotatedImage)
            rotatedRecords.append(rotatedItem)
        }
        
        record.items = rotatedRecords
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.saveFinished()
        }
    }
    
    private func saveFinished()
    {
        parentController.pop(vertical:CParent.TransitionVertical.fromTop)
    }
    
    //MARK: public
    
    func save()
    {
        viewRotate.startLoading()
        
        let orientation:UIImageOrientation = viewRotate.orientation
        
        if orientation == UIImageOrientation.up
        {
            saveFinished()
        }
        else
        {
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.asyncSave(orientation:orientation)
            }
        }
    }
}
