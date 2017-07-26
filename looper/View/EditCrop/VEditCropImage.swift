import UIKit

class VEditCropImage:View<VEditCrop, MEditCrop, CEditCrop>
{
    required init(controller:CEditCrop)
    {
        super.init(controller:controller)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
