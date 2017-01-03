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
    }
}
