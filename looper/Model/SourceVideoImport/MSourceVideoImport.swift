import Foundation

class MSourceVideoImport:Model
{
    private(set) weak var item:MSourceVideoItem!
    private(set) var framesPerSecond:Int
    
    required init()
    {
        framesPerSecond = 0
        super.init()
    }
    
    //MARK: public
    
    func config(item:MSourceVideoItem, framesPerSecond:Int)
    {
        self.item = item
        self.framesPerSecond = framesPerSecond
    }
}
