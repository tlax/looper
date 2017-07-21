import Foundation

class CSourceVideoTime:Controller<VSourceVideoTime, MSourceVideoTime>
{
    init(item:MSourceVideoItem)
    {
        super.init()
        model.item = item
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
