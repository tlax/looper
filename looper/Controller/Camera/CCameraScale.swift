import UIKit

class CCameraScale:CController
{
    var currentPercent:CGFloat
    weak var record:MCameraRecordEditable!
    private weak var viewScale:VCameraScale!
    private let kMaxPercent:CGFloat = 1
    
    init(record:MCameraRecordEditable)
    {
        self.record = record
        currentPercent = kMaxPercent
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
    
    //MARK: private
    
    private func savingFinished()
    {
        parentController.pop(
            vertical:CParent.TransitionVertical.fromTop)
    }
    
    private func asyncSave()
    {
        
    }
    
    //MARK: public
    
    func save()
    {
        viewScale.startLoading()
        
        if currentPercent < kMaxPercent
        {
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.asyncSave()
            }
        }
        else
        {
            savingFinished()
        }
    }
}
