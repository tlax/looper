import Foundation

extension URL
{
    static func excludeFromBackup(original:URL) -> URL
    {
        var url:URL = original
        var resourceValues:URLResourceValues = URLResourceValues()
        resourceValues.isExcludedFromBackup = true
        
        do
        {
            try url.setResourceValues(resourceValues)
        }
        catch
        {
        }
        
        return url
    }
}
