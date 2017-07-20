import Foundation

extension MCreate
{
    class func factorySource() -> [MSourceProtocol]
    {
        let sourceVideo:MSourceVideo = MSourceVideo()
        
        let items:[MSourceProtocol] = [
            sourceVideo]
        
        return items
    }
}
