import UIKit

class VEditCropImage:View<VEditCrop, MEditCrop, CEditCrop>
{
    required init(controller:CEditCrop)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.black
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
