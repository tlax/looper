import Foundation

extension MPerkThumbnailProtocol
{
    func identifier() -> String
    {
        let classType:AnyClass = object_getClass(self)
        let nameString:String = NSStringFromClass(classType)
        
        return nameString
    }
    
    func domainIdentifier() -> String
    {
        let classType:AnyClass = object_getClass(domainType)
        let nameString:String = NSStringFromClass(classType)
        
        return nameString
    }
}
