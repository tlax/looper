import Foundation

class MHelpBlender:MHelp
{
    init()
    {
        let itemAbout:MHelpItemBlenderAbout = MHelpItemBlenderAbout()
        let itemBase:MHelpItemBlenderBase = MHelpItemBlenderBase()
        let itemAdd:MHelpItemBlenderAdd = MHelpItemBlenderAdd()
        let itemSelect:MHelpItemBlenderSelect = MHelpItemBlenderSelect()
        let itemDrag:MHelpItemBlenderDrag = MHelpItemBlenderDrag()
        
        let items:[MHelpItem] = [
            itemAbout,
            itemBase,
            itemAdd,
            itemSelect,
            itemDrag
        ]
        
        super.init(items:items)
    }
}
