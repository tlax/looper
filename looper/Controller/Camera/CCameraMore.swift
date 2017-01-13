import UIKit

class CCameraMore:CController
{
    let model:MCameraMore
    weak var record:MCameraRecordEditable!
    weak var viewMore:VCameraMore!
    
    init(record:MCameraRecordEditable)
    {
        model = MCameraMore(record:record)
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
    
    func close()
    {
        parentController.dismissAnimateOver(completion:nil)
    }
}
