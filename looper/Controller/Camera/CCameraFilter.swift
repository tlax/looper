import UIKit

class CCameraFilter:CController
{
    weak var model:MCamera!
    let modelFilter:MCameraFilter
    private weak var viewFilter:VCameraFilter!
    
    init(model:MCamera)
    {
        self.model = model
        modelFilter = MCameraFilter()
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
    
    func next()
    {
        guard
            
            let controller:CController = modelFilter.currentFilter?.processController(model:model)
        
        else
        {
            return
        }
        
        parentController.push(
            controller:controller,
            horizontal:
            CParent.TransitionHorizontal.fromRight)
    }
}
