import Foundation

extension MNew
{
    class func factorySource() -> [MSourceProtocol]
    {
        let sourceVideo:MSourceItemVideo = MSourceItemVideo()
        let sourceImage:MSourceItemImage = MSourceItemImage()
        
        let items:[MSourceProtocol] = [
            sourceVideo,
            sourceImage]
        
        return items
    }
}
