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
        self.item = item
        
        let itemDuration:MSourceVideoTimeItemDuration = MSourceVideoTimeItemDuration(
            item:item)
        let itemWidth:MSourceVideoTimeItemWidth = MSourceVideoTimeItemWidth(
            item:item)
        let itemHeight:MSourceVideoTimeItemHeight = MSourceVideoTimeItemHeight(
            item:item)
        
        items = [
            itemDuration,
            itemWidth,
            itemHeight]
    }
}
