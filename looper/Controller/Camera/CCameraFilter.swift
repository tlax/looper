import UIKit

class CCameraFilter:CController
{
    let modelFilter:MCameraFilter
    private weak var viewFilter:VCameraFilter!
    
    override init()
    {
        modelFilter = MCameraFilter()
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewFilter:VCameraFilter = VCameraFilter(controller:self)
        self.viewFilter = viewFilter
        view = viewFilter
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        viewFilter.viewBar.nextButton.isUserInteractionEnabled = true
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func next()
    {
        guard
            
            let filter:MCameraFilterItem = modelFilter.currentFilter
        
        else
        {
            return
        }
        
        let controller:CCameraFilterSelector = CCameraFilterSelector(filter:filter)
        
        parentController.push(
            controller:controller,
            horizontal:
            CParent.TransitionHorizontal.fromRight)
    }
}
