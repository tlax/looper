import UIKit

class CCameraRotate:CController
{
    private weak var viewRotate:VCameraRotate!
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
    
    //MARK: public
    
    func save()
    {
        parentController.pop(vertical:CParent.TransitionVertical.fromTop)
    }
}
