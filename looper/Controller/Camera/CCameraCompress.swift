import UIKit

class CCameraCompress:CController
{
    let model:MCameraRecord
    let modelCompress:MCameraCompress
    private weak var viewCompress:VCameraCompress!
    
    init(model:MCameraRecord)
    {
        self.model = model
        self.modelCompress = MCameraCompress(model:model)
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
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.loadSizes()
        }
    }
    
    //MARK: private
    
    private func compress()
    {
        guard
        
            let compressItem:MCameraCompressItem = modelCompress.currentCompress
        
        else
        {
            return
        }
        
        guard
        
            let compressedRecord:MCameraRecord = compressItem.compress(record:model)
        
        else
        {
            return
        }
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.finishedCompressing(compressed:compressedRecord)
        }
    }
    
    private func finishedCompressing(compressed:MCameraRecord)
    {
        let controller:CCameraPreview = CCameraPreview(model:compressed)
        parentController.push(
            controller:controller,
            horizontal:
            CParent.TransitionHorizontal.fromRight)
    }
    
    private func loadSizes()
    {
        modelCompress.loadSizes()
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.loadSizesFinished()
        }
    }
    
    private func loadSizesFinished()
    {
        viewCompress.stopLoading()
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func next()
    {
        viewCompress.startLoading()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.compress()
        }
    }
}
