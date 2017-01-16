import UIKit

class CCameraScale:CController
{
    private weak var viewScale:VCameraScale!
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
        let viewScale:VCameraScale = VCameraScale(controller:self)
        self.viewScale = viewScale
        view = viewScale
    }
    
    //MARK: public
    
    func save()
    {
        parentController.pop(
            vertical:CParent.TransitionVertical.fromTop)
    }
}
