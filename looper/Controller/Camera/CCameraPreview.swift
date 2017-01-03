import UIKit

class CCameraPreview:CController
{
    private weak var viewPreview:VCameraPreview!
    let model:MCameraRecord
    
    init(model:MCameraRecord)
    {
        self.model = model
        super.init()
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        parentController.changeBar(barHidden:true)
    }
    
    override func viewWillDisappear(_ animated:Bool)
    {
        super.viewWillDisappear(animated)
        parentController.changeBar(barHidden:false)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewPreview:VCameraPreview = VCameraPreview(controller:self)
        self.viewPreview = viewPreview
        view = viewPreview
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
