import UIKit

class CCameraFilterSelector:CController
{
    let model:MCameraFilterSelector
    weak var filter:MCameraFilterItem!
    private weak var viewSelector:VCameraFilterSelector!
    private var firstView:Bool
    
    init(filter:MCameraFilterItem)
    {
        self.filter = filter
        firstView = true
        model = filter.selectorModel()
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewSelector:VCameraFilterSelector = VCameraFilterSelector(controller:self)
        self.viewSelector = viewSelector
        view = viewSelector
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        viewSelector.selectCurrent()
        
        if firstView
        {
            firstView = false
            
            if model.items.count == 1
            {
                next()
            }
        }
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func next()
    {
        viewSelector.startLoading()
        
        let selectedModel:MCameraFilterSelectorItem = model.selectedModel()
        
        filter.selected(
            item:selectedModel,
            controller:self)
    }
}
