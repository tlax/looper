import Foundation

class MHelp
{
    let items:[MHelpItem]
    
    init()
    {
        let itemRecord:MHelpItemRecord = MHelpItemRecord()
        let itemFilter:MHelpItemFilter = MHelpItemFilter()
        let itemCompress:MHelpItemCompress = MHelpItemCompress()
        let itemSave:MHelpItemSave = MHelpItemSave()
        
        items = [
            itemRecord,
            itemFilter,
            itemCompress,
            itemSave
        ]
    }
}
