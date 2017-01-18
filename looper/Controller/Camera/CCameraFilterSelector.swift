import UIKit

class CCameraFilterSelector:CController
{
    weak var filter:MCameraFilterItem!
    let model:MCameraFilterSelector
    private weak var viewSelector:VCameraFilterSelector!
    
    init(filter:MCameraFilterItem)
    {
        self.filter = filter
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
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func next()
    {/*
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
