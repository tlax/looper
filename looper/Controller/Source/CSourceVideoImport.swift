import Foundation

class CSourceVideoImport:Controller<VSourceVideoImport, MSourceVideoImport>
{
    init(item:MSourceVideoItem, framesPerSecond:Int)
    {
        super.init()
        model.config(item:item, framesPerSecond:framesPerSecond)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
