import UIKit

class CCameraFilterBlenderOverlay:CController
{
    weak var viewOverlay:VCameraFilterBlenderOverlay!
    weak var baseRecord:MCameraRecord?
    private weak var model:MCameraFilterItemBlend!
    
    init(model:MCameraFilterItemBlend, baseRecord:MCameraRecord?)
    {
        self.model = model
        self.baseRecord = baseRecord
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        viewOverlay.stopLoading()
    }
    
    override func loadView()
    {
        let viewOverlay:VCameraFilterBlenderOverlay = VCameraFilterBlenderOverlay(
            controller:self)
        self.viewOverlay = viewOverlay
        view = viewOverlay
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func next()
    {
        viewOverlay.startLoading()
    }
}
