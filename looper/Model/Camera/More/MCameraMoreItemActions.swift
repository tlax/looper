import UIKit

class MCameraMoreItemActions:MCameraMoreItem
{
    let options:[MCameraMoreItemActionsOption]
    private let kCellHeight:CGFloat = 65
    
    init()
    {
        let optionAdd:MCameraMoreItemActionsOptionAdd = MCameraMoreItemActionsOptionAdd()
        let optionRotate:MCameraMoreItemActionsOptionRotate = MCameraMoreItemActionsOptionRotate()
        let optionCrop:MCameraMoreItemActionsOptionCrop = MCameraMoreItemActionsOptionCrop()
        let optionScale:MCameraMoreItemActionsOptionScale = MCameraMoreItemActionsOptionScale()
        let optionTrash:MCameraMoreItemActionsOptionTrash = MCameraMoreItemActionsOptionTrash()
        
        options = [
            optionAdd,
            optionRotate,
            optionCrop,
            optionScale,
            optionTrash
        ]
        
        let reusableIdentifier:String = VCameraMoreCellActions.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
