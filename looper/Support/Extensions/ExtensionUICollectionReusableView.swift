import UIKit

extension UICollectionReusableView
{
    class var reusableIdentifier:String
    {
        get
        {
            let classType:AnyClass = object_getClass(self)
            let stringName:String = NSStringFromClass(classType)
            
            return stringName
        }
    }
}
