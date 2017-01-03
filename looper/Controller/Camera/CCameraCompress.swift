import UIKit

class CCameraCompress:CController
{
    let model:MCameraRecord
    let modelCompress:MCameraCompress
    private weak var viewCompress:VCameraCompress!
    
    init(model:MCameraRecord)
    {
        self.model = model
        self.modelCompress = MCameraCompress()
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewCompress:VCameraCompress = VCameraCompress(controller:self)
        self.viewCompress = viewCompress
        view = viewCompress
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func next()
    {
        
    }
}
