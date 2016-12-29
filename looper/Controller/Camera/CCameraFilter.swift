import UIKit

class CCameraFilter:CController
{
    weak var model:MCamera!
    private weak var viewFilter:VCameraFilter!
    
    init(model:MCamera)
    {
        self.model = model
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewFilter:VCameraFilter = VCameraFilter(controller:self)
        self.viewFilter = viewFilter
        view = viewFilter
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
