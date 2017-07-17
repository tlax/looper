import UIKit

class MCamera
{
    static let kImageMaxSize:CGFloat = 480
    static let kImageMinSize:CGFloat = 50
    static let kMaxShots:Int = 300
    let speeds:[MCameraSpeed]
    var records:[MCameraRecord]
    var activeRecords:[MCameraRecord]?
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
    
    private func recordRenderRecording(record:MCameraRecord, modelRaw:MCameraRaw)
    {
        NotificationCenter.default.post(
            name:Notification.cameraLoading,
            object:nil)
        
        let items:[MCameraRecordItem] = modelRaw.render()
        record.items.append(contentsOf:items)
        
        NotificationCenter.default.post(
            name:Notification.cameraLoadFinished,
            object:nil)
    }

    private func recordRenderImage(record:MCameraRecord, modelImage:MCameraImage)
    {
        NotificationCenter.default.post(
            name:Notification.cameraLoading,
            object:nil)
        
        if let items:MCameraRecordItem = modelImage.render()
        {
            record.items.append(items)
        }
        
        NotificationCenter.default.post(
            name:Notification.cameraLoadFinished,
            object:nil)
    }
    
    private func asyncRederRecording(modelRaw:MCameraRaw)
    {
        let record:MCameraRecord = MCameraRecord()
        records.insert(record, at:0)
        
        recordRenderRecording(record:record, modelRaw:modelRaw)
    }
    
    private func asyncRederImage(modelImage:MCameraImage)
    {
        let record:MCameraRecord = MCameraRecord()
        records.insert(record, at:0)
        
        recordRenderImage(record:record, modelImage:modelImage)
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
            
            self?.asyncRederRecording(modelRaw:modelRaw)
        }
    }
    
    func renderImage(record:MCameraRecord, modelImage:MCameraImage)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.recordRenderImage(record:record, modelImage:modelImage)
        }
    }
    
    func renderImage(modelImage:MCameraImage)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncRederImage(modelImage:modelImage)
        }
    }
    
    func trashRecord(record:MCameraRecord)
    {
        let countRecords:Int = records.count
        var recordToDelete:Int = 0
        
        for indexRecord:Int in 0 ..< countRecords
        {
            let recordItem:MCameraRecord = records[indexRecord]
            
            if recordItem === record
            {
                recordToDelete = indexRecord
                
                break
            }
        }
        
        records.remove(at:recordToDelete)
    }
    
    func hasActive() -> Bool
    {
        for record:MCameraRecord in records
        {
            for item:MCameraRecordItem in record.items
            {
                if item.active
                {
                    return true
                }
            }
        }
        
        return false
    }
    
    func buildActiveRecords()
    {
        var activeRecords:[MCameraRecord] = []
        
        for record:MCameraRecord in records
        {
            guard
            
                let activeRecord:MCameraRecord = record.activeVersion()
            
            else
            {
                continue
            }
            
            activeRecords.append(activeRecord)
        }
        
        self.activeRecords = activeRecords
    }
}
