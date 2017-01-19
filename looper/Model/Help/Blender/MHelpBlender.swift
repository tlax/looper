import Foundation

class MHelpBlender:MHelp
{
    init()
    {
        let itemAbout:MHelpItemBlenderAbout = MHelpItemBlenderAbout()
        let itemBase:MHelpItemBlenderBase = MHelpItemBlenderBase()
        let itemAdd:MHelpItemBlenderAdd = MHelpItemBlenderAdd()
        let itemDrag:MHelpItemBlenderDrag = MHelpItemBlenderDrag()
        
        let items:[MHelpItem] = [
            itemAbout,
            itemBase,
            itemAdd,
            itemDrag
        ]
        
        super.init(items:items)
    }
}
