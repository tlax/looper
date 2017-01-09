import UIKit

class CCameraFilterBlender:CController
{
    weak var model:MCameraFilterItemBlend!
    private weak var viewBlender:VCameraFilterBlender!
    
    init(model:MCameraFilterItemBlend)
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
        let viewBlender:VCameraFilterBlender = VCameraFilterBlender(controller:self)
        self.viewBlender = viewBlender
        view = viewBlender
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
