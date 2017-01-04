import UIKit

class MLoopsItem
{
    private(set) var images:[UIImage]
    
    init(loop:DLoop)
    {
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
            catch let error
            {
                data = nil
                print("error: \(error.localizedDescription)")
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
