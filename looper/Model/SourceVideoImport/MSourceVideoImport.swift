import UIKit

class MSourceVideoImport:Model, MSourceVideoImportFactoryDelegate
{
    private(set) weak var item:MSourceVideoItem!
    private weak var controller:CSourceVideoImport?
    private var factory:MSourceVideoImportFactory?
    private var framesPerSecond:Int
    
    required init()
    {
        framesPerSecond = 0
        super.init()
    }
    
    //MARK: private
    
    private func asyncImportVideo()
    {
        factory = MSourceVideoImportFactory(
            item:item,
            framesPerSecond:framesPerSecond,
            delegate:self)
    }
    
    //MARK: public
    
    func config(item:MSourceVideoItem, framesPerSecond:Int)
    {
        self.item = item
        self.framesPerSecond = framesPerSecond
    }
    
    func importVideo(controller:CSourceVideoImport)
    {
        self.controller = controller
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncImportVideo()
        }
    }
    
    func cancelImport()
    {
        factory?.cancelAll()
    }
    
    //MARK: factory delegate
    
    func importSequenceReady(sequence:MEditSequence)
    {
        controller?.videoImported(sequence:sequence)
    }
    
    func importError()
    {
        let error:String = String.localizedModel(key:"MSourceVideoImport_error")
        VAlert.messageFail(message:error)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.controller?.cancel()
        }
    }
    
    func importProgress(percent:CGFloat)
    {
        controller?.updateProgress(percent:percent)
    }
}
