import Foundation

class MHomeControl
{
    let items:[MHomeControlItem]
    
    init()
    {
        let itemCamera:MHomeControlItemCamera = MHomeControlItemCamera()
        
        items = [
            itemCamera
        ]
    }
}
