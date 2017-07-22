import Foundation

class MSourceVideoTime:Model
{
    private(set) weak var item:MSourceVideoItem!
    private(set) var items:[MSourceVideoTimeItemProtocol]
    
    required init()
    {
        items = []
        
        super.init()
    }
    
    //MARK: public
    
    func config(item:MSourceVideoItem)
    {
        let itemDuration:MSourceVideoTimeItemDuration = MSourceVideoTimeItemDuration(
            item:item)
        
        items = [
            itemDuration]
    }
}
