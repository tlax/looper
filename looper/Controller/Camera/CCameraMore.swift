import UIKit

class CCameraMore:CController
{
    weak var viewMore:VCameraMore!
    private weak var model:MCameraRecord?
    
    init(model:MCameraRecord)
    {
        self.model = model
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
    
    func close()
    {
        parentController.dismissAnimateOver(completion:nil)
    }
}
