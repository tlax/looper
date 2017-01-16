import UIKit

class CCameraScale:CController
{
    var currentPercent:CGFloat
    private weak var viewScale:VCameraScale!
    weak var record:MCameraRecordEditable!
    
    init(record:MCameraRecordEditable)
    {
        self.record = record
        currentPercent = 1
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewScale:VCameraScale = VCameraScale(controller:self)
        self.viewScale = viewScale
        view = viewScale
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        viewScale.updateSlider()
    }
    
    //MARK: public
    
    func save()
    {
        parentController.pop(
            vertical:CParent.TransitionVertical.fromTop)
    }
}
