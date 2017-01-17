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
    
    //MARK: public
    
    func save()
    {
        parentController.pop(vertical:CParent.TransitionVertical.fromTop)
    }
}
