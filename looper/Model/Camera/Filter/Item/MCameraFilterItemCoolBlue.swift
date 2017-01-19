import UIKit

class MCameraFilterItemCoolBlue:MCameraFilterItem
{
    init()
    {
        let title:String = NSLocalizedString("MCameraFilterItemCoolBlue_title", comment:"")
        let viewTitle:String = NSLocalizedString("MCameraFilterItemCoolBlue_viewTitle", comment:"")
        let image:UIImage = #imageLiteral(resourceName: "assetFilterCoolBlue")
        
        super.init(title:title, viewTitle:viewTitle, image:image)
    }
    
    override func selected(filterSelectedItem:MCameraFilterSelectorItem, controller:CCameraFilterSelector)
    {
        guard
            
            let itemRecord:MCameraFilterSelectorItemRecord = filterSelectedItem as? MCameraFilterSelectorItemRecord
            
        else
        {
            return
        }
        
        let record:MCameraRecord = itemRecord.record
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.filter(record:record, controller:controller)
        }
    }
    
    //MARK: private
    
    private func filter(record:MCameraRecord, controller:CCameraFilterSelector)
    {
        let filteredRecord:MCameraRecord
        
        if let coolBlue:MCameraFilterProcessorCoolBlue = MCameraFilterProcessorCoolBlue()
        {
            filteredRecord = coolBlue.cool(record:record)
        }
        else
        {
            filteredRecord = record
        }
        
        let waterMarked:MCameraRecord = waterMark(original:filteredRecord)
        
        DispatchQueue.main.async
        { [weak controller] in
            
            let controllerCompress:CCameraCompress = CCameraCompress(
                model:waterMarked)
            controller?.parentController.push(
                controller:controllerCompress,
                horizontal:
                CParent.TransitionHorizontal.fromRight)
        }
    }
}
