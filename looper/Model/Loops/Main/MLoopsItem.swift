import UIKit

class MLoopsItem
{
    let loop:DLoop
    private(set) var images:[UIImage]
    
    init(loop:DLoop)
    {
        self.loop = loop
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
    
    //MARK: public
    
    func delete()
    {
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
            
            do
            {
                try FileManager.default.removeItem(at:imageUrl)
            }
            catch
            {
            }
        }
        
        DManager.sharedInstance.delete(object:loop)
        {
            DManager.sharedInstance.save()
        }
    }
}
