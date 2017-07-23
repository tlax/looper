import Foundation

class CSourceImage:Controller<VSourceImage, MSourceImage>
{
    private weak var create:CCreate!
    
    init(create:CCreate)
    {
        self.create = create
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
