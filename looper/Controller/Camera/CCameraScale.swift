import UIKit

class CCameraScale:CController
{
    var currentPercent:CGFloat
    weak var record:MCameraRecordEditable!
    private weak var viewScale:VCameraScale!
    private let kMaxPercent:CGFloat = 1
    private let kAnimationDuration:TimeInterval = 0.4
    
    init(record:MCameraRecordEditable)
    {
        self.record = record
        currentPercent = kMaxPercent
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewScale:VCameraScale = VCameraScale(controller:self)
        self.viewScale = viewScale
        view = viewScale
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        viewScale.updateSlider()
    }
    
    //MARK: private
    
    private func savingFinished()
    {
        parentController.pop(
            vertical:CParent.TransitionVertical.fromTop)
    }
    
    private func asyncSave()
    {
        var scaledRecords:[MCameraRecordItem] = []
        
        guard
            
            let firstImage:UIImage = record.items.first?.image
            
        else
        {
            return
        }
        
        let originalSize:CGFloat = firstImage.size.width
        let scaledSize:CGFloat = floor(originalSize * currentPercent)
        let imageSize:CGSize = CGSize(
            width:scaledSize,
            height:scaledSize)
        let drawingRect:CGRect = CGRect(
            x:0,
            y:0,
            width:scaledSize,
            height:scaledSize)
        
        for rawItem:MCameraRecordItem in record.items
        {
            let originalImage:UIImage = rawItem.image
            
            UIGraphicsBeginImageContext(imageSize)
            originalImage.draw(in:drawingRect)
            
            guard
                
                let scaledImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
                
            else
            {
                UIGraphicsEndImageContext()
                continue
            }
            
            UIGraphicsEndImageContext()
            
            let scaledItem:MCameraRecordItem = MCameraRecordItem(
                image:scaledImage)
            scaledRecords.append(scaledItem)
        }
        
        record.items = scaledRecords
        
        DispatchQueue.main.async
        { [weak self] in
                
            self?.savingFinished()
        }
    }
    
    //MARK: public
    
    func save()
    {
        viewScale.startLoading()
        
        if currentPercent < kMaxPercent
        {
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.asyncSave()
            }
        }
        else
        {
            savingFinished()
        }
    }
    
    func reset()
    {
        currentPercent = kMaxPercent
        viewScale.updateSlider()
        
        UIView.animate(
            withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.viewScale.layoutIfNeeded()
        }
        
    }
}
