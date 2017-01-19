import UIKit

class CCameraMore:CController
{
    let model:MCameraMore
    weak var controller:CCamera!
    weak var viewMore:VCameraMore!
    weak var record:MCameraRecordEditable?
    
    init(controller:CCamera, record:MCameraRecordEditable)
    {
        model = MCameraMore(record:record)
        self.controller = controller
        self.record = record
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        viewMore.open()
    }
    
    override func loadView()
    {
        let viewMore:VCameraMore = VCameraMore(controller:self)
        self.viewMore = viewMore
        view = viewMore
    }
    
    //MARK: public
    
    func close(completion:(() -> ())?)
    {
        parentController.dismissAnimateOver(completion:completion)
    }
}
