import Foundation

class MHomeControl
{
    let items:[MHomeControlItem]
    
    init()
    {
        let itemCamera:MHomeControlItemCamera = MHomeControlItemCamera()
        let itemSequences:MHomeControlItemSequences = MHomeControlItemSequences()
        let itemBlender:MHomeControlItemBlender = MHomeControlItemBlender()
        
        items = [
            itemCamera,
            itemSequences,
            itemBlender
        ]
    }
}
