import UIKit

class MCameraFilterItemNone:MCameraFilterItem
{
    init()
    {
        let title:String = NSLocalizedString("MCameraFilterItemNone_title", comment:"")
        let viewTitle:String = NSLocalizedString("MCameraFilterItemNone_viewTitle", comment:"")
        let image:UIImage = #imageLiteral(resourceName: "assetFilterSimple")
        
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
        let waterMarked:MCameraRecord = waterMark(original:record)
        
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
