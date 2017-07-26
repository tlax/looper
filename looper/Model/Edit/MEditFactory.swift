import Foundation

extension MEdit
{
    class func factoryActions() -> [MEditActionProtocol]
    {
        let actionRotate:MEditActionRotate = MEditActionRotate()
        
        let items:[MEditActionProtocol] = [
            actionRotate]
        
        return items
    }
}
