import UIKit

class CCameraCrop:CController
{
    weak var record:MCameraRecordEditable!
    private weak var viewCrop:VCameraCrop!
    private let kMinThreshold:CGFloat = 2
    
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
        let viewCrop:VCameraCrop = VCameraCrop(controller:self)
        self.viewCrop = viewCrop
        view = viewCrop
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        viewCrop.viewImage.createShades()
    }
    
    //MARK: private
    
    private func asyncSave()
    {
        let originalLeft:CGFloat = viewCrop.viewImage.thumbTopLeft.originalX
        let originalRight:CGFloat = viewCrop.viewImage.thumbTopRight.originalX
        let originalTop:CGFloat = viewCrop.viewImage.thumbTopLeft.originalY
        let originalBottom:CGFloat = viewCrop.viewImage.thumbBottomLeft.originalY
        let posLeft:CGFloat = viewCrop.viewImage.thumbTopLeft.positionX
        let posRight:CGFloat = viewCrop.viewImage.thumbTopRight.positionX
        let posTop:CGFloat = viewCrop.viewImage.thumbTopLeft.positionY
        let posBottom:CGFloat = viewCrop.viewImage.thumbBottomLeft.positionY
        let deltaLeft:CGFloat = posLeft - originalLeft
        let deltaRight:CGFloat = originalRight - posRight
        let deltaTop:CGFloat = posTop - originalTop
        let deltaBottom:CGFloat = originalBottom - posBottom
        
        if deltaLeft > kMinThreshold || deltaRight > kMinThreshold || deltaTop > kMinThreshold || deltaBottom > kMinThreshold
        {
            let originalSize:CGFloat = viewCrop.viewImage.imageSize
            let imageRatio:CGFloat = viewCrop.viewImage.imageRatio
            let distanceLeft:CGFloat = deltaLeft * imageRatio
            let distanceRight:CGFloat = deltaRight * imageRatio
            let distanceTop:CGFloat = deltaTop * imageRatio
            let newSize:CGFloat = originalSize - (distanceLeft + distanceRight)
            
            var croppedRecords:[MCameraRecordItem] = []
            let imageSize:CGSize = CGSize(
                width:newSize,
                height:newSize)
            let drawingRect:CGRect = CGRect(
                x:-distanceLeft,
                y:-distanceTop,
                width:originalSize,
                height:originalSize)
            
            for rawItem:MCameraRecordItem in record.items
            {
                let originalImage:UIImage = rawItem.image
                
                UIGraphicsBeginImageContext(imageSize)
                originalImage.draw(in:drawingRect)
                
                guard
                    
                    let croppedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
                    
                else
                {
                    UIGraphicsEndImageContext()
                    continue
                }
                
                UIGraphicsEndImageContext()
                
                let croppedItem:MCameraRecordItem = MCameraRecordItem(
                    image:croppedImage)
                croppedRecords.append(croppedItem)
            }
            
            record.items = croppedRecords
        }
        
        DispatchQueue.main.async
        { [weak self] in

            self?.savingFinished()
        }
    }
    
    private func savingFinished()
    {
        parentController.pop(vertical:CParent.TransitionVertical.fromTop)
    }
    
    //MARK: public
    
    func save()
    {
        viewCrop.startLoading()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in

            self?.asyncSave()
        }
    }
}
