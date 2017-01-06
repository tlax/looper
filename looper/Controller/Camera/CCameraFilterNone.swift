import UIKit

class CCameraFilterNone:CController
{
    private weak var model:MCameraFilterItemNone!
    private weak var viewNone:VCameraFilterNone!
    
    init(model:MCameraFilterItemNone)
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
        let viewNone:VCameraFilterNone = VCameraFilterNone(controller:self)
        self.viewNone = viewNone
        view = viewNone
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        viewNone.refresh()
    }
    
    //MARK: private
    
    private func filterFinished(record:MCameraRecord)
    {
        let controllerCompress:CCameraCompress = CCameraCompress(
            model:record)
        parentController.push(
            controller:controllerCompress,
            horizontal:
            CParent.TransitionHorizontal.fromRight)
    }
    
    private func filter(record:MCameraRecord)
    {
        let filteredRecord:MCameraRecord = MCameraRecord()
        
        for item:MCameraRecordItem in record.items
        {
            if item.active
            {
                filteredRecord.items.append(item)
            }
        }
        
        let waterMarked:MCameraRecord = model.waterMark(original:filteredRecord)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.filterFinished(record:waterMarked)
        }
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(
            horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func selected(record:MCameraRecord)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.filter(record:record)
        }
    }
}
