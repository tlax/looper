import UIKit

class CCameraFilterNone:CController
{
    private weak var viewNone:VCameraFilterNone!
    
    override func loadView()
    {
        let viewNone:VCameraFilterNone = VCameraFilterNone(controller:self)
        self.viewNone = viewNone
        view = viewNone
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        viewNone.collectionView.reloadData()
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(
            horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func selected(record:MCameraRecord)
    {
        let filteredRecord:MCameraRecord = MCameraRecord()
        
        for item:MCameraRecordItem in record.items
        {
            if item.active
            {
                filteredRecord.items.append(item)
            }
        }
        
        let controllerCompress:CCameraCompress = CCameraCompress(
            model:filteredRecord)
        parentController.push(
            controller:controllerCompress,
            horizontal:
            CParent.TransitionHorizontal.fromRight)
    }
}
