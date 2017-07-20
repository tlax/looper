import Foundation
import CoreData

extension NSManagedObject
{
    open class var entityName:String
    {
        get
        {
            let classType:AnyClass = object_getClass(self)
            let stringName:String = NSStringFromClass(classType)
            
            return stringName
        }
    }
}
