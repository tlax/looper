import Foundation

extension MEdit
{
    class func factoryActions() -> [MEditActionProtocol]
    {
        let actionDuration:MEditActionDuration = MEditActionDuration()
        let actionRotate:MEditActionRotate = MEditActionRotate()
        let actionScale:MEditActionScale = MEditActionScale()
        let actionCrop:MEditActionCrop = MEditActionCrop()
        
        let items:[MEditActionProtocol] = [
            actionDuration,
            actionRotate,
            actionScale,
            actionCrop]
        
        return items
    }
}
