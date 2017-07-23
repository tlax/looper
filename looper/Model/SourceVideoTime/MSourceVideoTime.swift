import Foundation

class MSourceVideoTime:Model
{
    var framesPerSecond:Int
    private(set) weak var item:MSourceVideoItem!
    private(set) var items:[MSourceVideoTimeItemProtocol]
    private let kFramesPerSecondDefault:Int = 15
    
    required init()
    {
        items = []
        framesPerSecond = kFramesPerSecondDefault
        
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
