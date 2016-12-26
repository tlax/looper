import Foundation

class MHomeControl
{
    let items:[MHomeControlItem]
    
    init(controller:CHome)
    {
        let itemCamera:MHomeControlItemCamera = MHomeControlItemCamera(
            controller:controller)
        let itemSequences:MHomeControlItemSequences = MHomeControlItemSequences(
            controller:controller)
        let itemBlender:MHomeControlItemBlender = MHomeControlItemBlender(
            controller:controller)
        
        items = [
            itemCamera,
            itemSequences,
            itemBlender
        ]
    }
}
