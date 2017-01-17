import UIKit

class CCameraCrop:CController
{
    weak var record:MCameraRecordEditable!
    private weak var viewCrop:VCameraCrop!
    
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
