import Foundation

class MHomeControl
{
    let items:[MHomeControlItem]
    
    init()
    {
        let itemCamera:MHomeControlItemCamera = MHomeControlItemCamera()
        let itemBlender:MHomeControlItemBlender = MHomeControlItemBlender()
        
        items = [
            itemCamera,
            itemBlender
        ]
    }
}
