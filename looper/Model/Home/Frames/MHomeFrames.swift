import Foundation

class MHomeFrames
{
    let items:[MHomeFramesItem]
    let kInitial:Int = 5
    
    init()
    {
        let item60:MHomeFramesItem60 = MHomeFramesItem60()
        let item45:MHomeFramesItem45 = MHomeFramesItem45()
        let item30:MHomeFramesItem30 = MHomeFramesItem30()
        let item20:MHomeFramesItem20 = MHomeFramesItem20()
        let item15:MHomeFramesItem15 = MHomeFramesItem15()
        let item10:MHomeFramesItem10 = MHomeFramesItem10()
        let item5:MHomeFramesItem5 = MHomeFramesItem5()
        let item2:MHomeFramesItem2 = MHomeFramesItem2()
        let item1:MHomeFramesItem1 = MHomeFramesItem1()
        
        items = [
            item60,
            item45,
            item30,
            item20,
            item15,
            item10,
            item5,
            item2,
            item1
        ]
    }
}
