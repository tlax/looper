import UIKit

class MLoopsItemImages
{
    let urls:[URL]
    var cover:UIImage?
    
    init(urls:[URL])
    {
        self.urls = urls
        
        guard
            
            let firstUrl:URL = urls.first
        
        else
        {
            cover = nil
            
            return
        }
        
        cover = load(url:firstUrl)
    }
    
    //MARK: private
    
    private func load(url:URL) -> UIImage?
    {
        let data:Data?
        
        do
        {
            try data = Data(
                contentsOf:url,
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
            return nil
        }
        
        return image
    }
    
    //MARK: public
    
    func imageLists() -> [UIImage]
    {
        var images:[UIImage] = []
        
        for url:URL in urls
        {
            guard
            
                let image:UIImage = load(url:url)
            
            else
            {
                continue
            }
            
            images.append(image)
        }
        
        return images
    }
}
