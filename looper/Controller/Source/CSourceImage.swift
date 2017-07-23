import Foundation

class CSourceImage:Controller<VSourceImage, MSourceImage>
{
    private(set) weak var controllerCreate:CCreate!
    
    init(controllerCreate:CCreate)
    {
        self.controllerCreate = controllerCreate
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
