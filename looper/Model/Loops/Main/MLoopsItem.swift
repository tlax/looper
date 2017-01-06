import UIKit

class MLoopsItem
{
    let loop:DLoop
    let images:MLoopsItemImages
    
    init(loop:DLoop)
    {
        self.loop = loop
        var urls:[URL] = []
        
        guard
            
            let folderName:String = loop.folder
        
        else
        {
            images = MLoopsItemImages(urls:urls)
            return
        }
        
        let appDirectory:URL = FileManager.appDirectory
        let folderPath:URL = appDirectory.appendingPathComponent(folderName)
        let countImages:Int = Int(loop.items)
        
        for indexImage:Int in 0 ..< countImages
        {
            let pathComponent:String = "\(indexImage)"
            let imageUrl:URL = folderPath.appendingPathComponent(pathComponent)
            urls.append(imageUrl)
        }
        
        images = MLoopsItemImages(urls:urls)
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
