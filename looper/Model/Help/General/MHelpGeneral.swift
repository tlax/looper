import Foundation

class MHelpGeneral:MHelp
{
    init()
    {
        let itemRecord:MHelpItemRecord = MHelpItemRecord()
        let itemFilter:MHelpItemFilter = MHelpItemFilter()
        let itemCompress:MHelpItemCompress = MHelpItemCompress()
        let itemSave:MHelpItemSave = MHelpItemSave()
        
        let items:[MHelpItem] = [
            itemRecord,
            itemFilter,
            itemCompress,
            itemSave
        ]
        
        super.init(items:items)
    }
}
