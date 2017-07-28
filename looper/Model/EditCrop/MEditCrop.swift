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
}
