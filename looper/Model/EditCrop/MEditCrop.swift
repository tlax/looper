import UIKit

class MEditCrop:Model
{
    private(set) weak var edit:MEdit!
    var scaledWidth:CGFloat
    var scaledHeight:CGFloat
    
    required init()
    {
        scaledWidth = 0
        scaledHeight = 0
    
        super.init()
    }
    
    //MARK: public
    
    func config(edit:MEdit)
    {
        self.edit = edit
    }
    
    func layoutModel() -> MEditCropLayout?
    {
        guard
        
            let percent:MEditSequenceCrop = edit.sequence?.crop
        
        else
        {
            return nil
        }
        
        let top:CGFloat = percent.top * scaledHeight
        let bottom:CGFloat = percent.bottom * scaledHeight
        let left:CGFloat = percent.left * scaledWidth
        let right:CGFloat = percent.right * scaledWidth
        
        let model:MEditCropLayout = MEditCropLayout(
            top:top,
            bottom:bottom,
            left:left,
            right:right)
        
        return model
    }
}
