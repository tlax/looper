import UIKit

class MCamera
{
    static let kImageMaxSize:CGFloat = 480
    static let kMaxShots:Int = 300
    let speeds:[MCameraSpeed]
    var records:[MCameraRecord]
    var raw:MCameraRaw?
    var currentSpeed:Int
    private let kDefaultSpeed:Int = 4
    
    init()
    {
        speeds = MCameraSpeed.all()
        records = []
        currentSpeed = kDefaultSpeed
    }
    
    //MARK: private
    
    private func asyncRenderRecording(modelRaw:MCameraRaw)
    {
        NotificationCenter.default.post(
            name:Notification.cameraLoading,
            object:nil)
        
        let record:MCameraRecord = modelRaw.render()
        records.insert(record, at:0)
        
        NotificationCenter.default.post(
            name:Notification.cameraLoadFinished,
            object:nil)
    }
    
    //MARK: public
    
    func currentSpeedModel() -> MCameraSpeed
    {
        let item:MCameraSpeed = speeds[currentSpeed]
        
        return item
    }
    
    func renderRecording(modelRaw:MCameraRaw)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncRenderRecording(modelRaw:modelRaw)
        }
    }
}
