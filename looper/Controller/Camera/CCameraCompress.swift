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
        viewCompress.stopLoading()
        
        let controller:CCameraPreview = CCameraPreview(model:compressed)
        parentController.push(
            controller:controller,
            horizontal:
            CParent.TransitionHorizontal.fromRight)
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
