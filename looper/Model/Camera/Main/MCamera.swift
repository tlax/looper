import UIKit

class MCamera
{
    static let kImageMaxSize:CGFloat = 1000
    static let kImageMinSize:CGFloat = 50
    static let kMaxShots:Int = 300
    let speeds:[MCameraSpeed]
    var records:[MCameraRecord]
    var activeRecords:[MCameraRecord]?
    var raw:MCameraRaw?
    var currentSpeed:Int
    private let kDefaultSpeed:Int = 3
    
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

    private func recordRenderImages(record:MCameraRecord, modelImages:[MCameraPickerItem])
    {
        NotificationCenter.default.post(
            name:Notification.cameraLoading,
            object:nil)
        
        for item:MCameraPickerItem in modelImages
        {
            guard
                
                let recordItem:MCameraRecordItem = item.render()
            
            else
            {
                continue
            }
            
            record.items.append(recordItem)
        }
        
        NotificationCenter.default.post(
            name:Notification.cameraLoadFinished,
            object:nil)
    }
    
    private func recordRenderVideo(record:MCameraRecord, modelVideo:MCameraVideo)
    {
        NotificationCenter.default.post(
            name:Notification.cameraLoading,
            object:nil)
        
        let items:[MCameraRecordItem] = modelVideo.render()
        record.items.append(contentsOf:items)
        
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
    
    private func asyncRederImages(modelImages:[MCameraPickerItem])
    {
        let record:MCameraRecord = MCameraRecord()
        records.insert(record, at:0)
        
        recordRenderImages(record:record, modelImages:modelImages)
    }
    
    private func asyncRenderVideo(modelVideo:MCameraVideo)
    {
        let record:MCameraRecord = MCameraRecord()
        records.insert(record, at:0)
        
        recordRenderVideo(record:record, modelVideo:modelVideo)
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
    
    func renderImages(record:MCameraRecord, modelImages:[MCameraPickerItem])
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.recordRenderImages(record:record, modelImages:modelImages)
        }
    }
    
    func renderImages(modelImages:[MCameraPickerItem])
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncRederImages(modelImages:modelImages)
        }
    }
    
    func renderVideo(modelVideo:MCameraVideo)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncRenderVideo(modelVideo:modelVideo)
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
