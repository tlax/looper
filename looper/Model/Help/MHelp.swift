import Foundation

class MHelp
{
    let items:[MHelpItem]
    
    init()
    {
        let itemRecord:MHelpItemRecord = MHelpItemRecord()
        let itemFilter:MHelpItemFilter = MHelpItemFilter()
        
        items = [
            itemRecord,
            itemFilter
        ]
    }
}
