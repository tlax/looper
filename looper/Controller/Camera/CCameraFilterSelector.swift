import UIKit

class CCameraFilterSelector:CController
{
    var currentSelected:Int
    weak var filter:MCameraFilterItem!
    private weak var viewBlender:VCameraFilterBlender!
    
    init(filter:MCameraFilterItem)
    {
        self.filter = filter
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
