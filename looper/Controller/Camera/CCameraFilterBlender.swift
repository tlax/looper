import UIKit

class CCameraFilterBlender:CController
{
    var currentSelected:Int
    weak var model:MCameraFilterItemBlend!
    private weak var viewBlender:VCameraFilterBlender!
    
    init(model:MCameraFilterItemBlend)
    {
        self.model = model
        currentSelected = 0
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
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        viewBlender.selectCurrent()
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
