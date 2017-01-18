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
        /*
        let baseRecord:MCameraRecord?
        
        if currentSelected == 0
        {
            baseRecord = nil
        }
        else
        {
            baseRecord = MSession.sharedInstance.camera?.activeRecords?[currentSelected - 1]
        }
        
        let controllerOverlay:CCameraFilterBlenderOverlay = CCameraFilterBlenderOverlay(
            model:model,
            baseRecord:baseRecord)
        parentController.push(
            controller:controllerOverlay,
            horizontal:CParent.TransitionHorizontal.fromRight)*/
    }
}
