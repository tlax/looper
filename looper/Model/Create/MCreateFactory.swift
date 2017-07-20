import Foundation

extension MCreate
{
    class func factorySource() -> [MSourceProtocol]
    {
        let sourceVideo:MSourceVideo = MSourceVideo()
        let sourceImage:MSourceImage = MSourceImage()
        
        let items:[MSourceProtocol] = [
            sourceVideo,
            sourceImage]
        
        return items
    }
}
