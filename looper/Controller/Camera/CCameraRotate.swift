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
    
    //MARK: public
    
    func save()
    {
        viewRotate.startLoading()
        //parentController.pop(vertical:CParent.TransitionVertical.fromTop)
    }
}
