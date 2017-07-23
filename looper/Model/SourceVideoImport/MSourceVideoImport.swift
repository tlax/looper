import Foundation
import AVFoundation

class MSourceVideoImport:Model, MSourceVideoImportFactoryDelegate
{
    private weak var controller:CSourceVideoImport?
    private weak var item:MSourceVideoItem!
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
    
    //MARK: factory delegate
    
    func importImagesReady(images:[CGImage])
    {
        let duration:TimeInterval = item.asset.duration
        let createItem:MCreateItem = MCreateItem(images:images)
        createItem.changeDuration(duration:duration)
        
        controller?.videoImported(createItem:createItem)
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
}
