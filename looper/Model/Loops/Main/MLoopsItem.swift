import UIKit

class MLoopsItem
{
    let duration:TimeInterval
    private(set) var images:[UIImage]
    
    init(loop:DLoop)
    {
        duration = loop.duration
        images = []
        
        guard
            
            let folderName:String = loop.folder
        
        else
        {
            return
        }
        
        let appDirectory:URL = FileManager.appDirectory
        let folderPath:URL = appDirectory.appendingPathComponent(folderName)
        let countImages:Int = Int(loop.items)
        
        for indexImage:Int in 0 ..< countImages
        {
            let pathComponent:String = "\(indexImage)"
            let imageUrl:URL = folderPath.appendingPathComponent(pathComponent)
            let data:Data?
            
            do
            {
                try data = Data(
                    contentsOf:imageUrl,
                    options:Data.ReadingOptions.mappedIfSafe)
            }
            catch
            {
                data = nil
            }
            
            guard
            
                let imageData:Data = data,
                let image:UIImage = UIImage(data:imageData)
            
            else
            {
                continue
            }
            
            images.append(image)
        }
    }
}
