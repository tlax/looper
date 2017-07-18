import UIKit

class CCameraPreview:CController
{
    weak var viewPreview:VCameraPreview!
    var currentTime:TimeInterval
    let model:MCameraRecord
    let size:Int
    private let kStartTime:TimeInterval = 5
    
    init(model:MCameraRecord, size:Int)
    {
        self.model = model
        self.size = size
        currentTime = kStartTime
        super.init()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        viewPreview.viewPlayer.buttonPlay.addTarget(
            self,
            action:#selector(actionPlay(sender:)),
            for:UIControlEvents.touchUpInside)
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        parentController.changeBar(barHidden:true)
        viewPreview.viewDisplay.load(record:model)
    }
    
    override func viewWillDisappear(_ animated:Bool)
    {
        super.viewWillDisappear(animated)
        parentController.changeBar(barHidden:false)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewPreview:VCameraPreview = VCameraPreview(controller:self)
        self.viewPreview = viewPreview
        view = viewPreview
    }
    
    //MARK: actions
    
    func actionPlay(sender button:UIButton)
    {
        if viewPreview.viewDisplay.imageView.isAnimating
        {
            stopPlaying()
        }
        else
        {
            viewPreview.viewPlayer.viewTimer.blocked()
            viewPreview.viewPlayer.buttonPlay.stop()
            viewPreview.viewDisplay.imageView.animationDuration = currentTime
            viewPreview.viewDisplay.imageView.startAnimating()
        }
    }
    
    //MARK: private
    
    private func stopPlaying()
    {
        viewPreview.viewPlayer.viewTimer.notBlocked()
        viewPreview.viewPlayer.buttonPlay.play()
        viewPreview.viewDisplay.imageView.stopAnimating()
    }
    
    private func asyncSave()
    {
        let projectFolderName:String = UUID().uuidString
        let appDirectory:URL = FileManager.appDirectory
        var projectPath:URL = appDirectory.appendingPathComponent(projectFolderName)
        
        do
        {
            try FileManager.default.createDirectory(
                at:projectPath,
                withIntermediateDirectories:false,
                attributes:nil)
        }
        catch let error
        {
            VAlert.message(message:error.localizedDescription)
            
            DispatchQueue.main.async
            { [weak self] in
                
                self?.savingFailed()
            }
        }
        
        projectPath = URL.excludeFromBackup(original:projectPath)
        
        let countItems:Int = model.items.count
        
        for indexItem:Int in 0 ..<  countItems
        {
            let item:MCameraRecordItem = model.items[indexItem]
            let itemPath:URL = projectPath.appendingPathComponent("\(indexItem)")
            let image:UIImage = item.image
            
            guard
            
                let data:Data = UIImagePNGRepresentation(image)
            
            else
            {
                continue
            }
            
            do
            {
                try data.write(
                    to:itemPath,
                    options:Data.WritingOptions.atomic)
            }
            catch
            {
            }
        }
        
        DManager.sharedInstance.createManagedObject(
            entityName:DLoop.entityName)
        { [weak self] (created) in
            
            guard
            
                let loop:DLoop = created as? DLoop,
                let duration:TimeInterval = self?.currentTime,
                let size:Int = self?.size
            
            else
            {
                return
            }
            
            let timestamp:TimeInterval = Date().timeIntervalSince1970
            
            loop.folder = projectFolderName
            loop.kiloBytes = Int32(size)
            loop.created = timestamp
            loop.duration = duration
            loop.items = Int32(countItems)
            
            DManager.sharedInstance.save()
            
            DispatchQueue.main.async
            { [weak self] in
                
                self?.savingDone()
            }
        }
    }
    
    private func savingFailed()
    {
        viewPreview.savingFailed()
    }
    
    private func savingDone()
    {
        parentController.removeAllButLast()
        parentController.viewParent.viewBar.moveToLoops()
    }
    
    //MARK: public
    
    func back()
    {
        stopPlaying()
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func cancel()
    {
        stopPlaying()
        
        let alert:UIAlertController = UIAlertController(
            title:
            NSLocalizedString("CCameraPreview_alertTitle", comment:""),
            message:
            NSLocalizedString("CCameraPreview_alertMessage", comment:""),
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CCameraPreview_alertCancel", comment:""),
            style:
            UIAlertActionStyle.cancel)
        
        let actionDelete:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CCameraPreview_alertDelete", comment:""),
            style:
            UIAlertActionStyle.destructive)
        { [weak self] (action:UIAlertAction) in
            
            self?.parentController.removeBetweenFirstAndLast()
            self?.parentController.pop(
                horizontal:
                CParent.TransitionHorizontal.fromRight)
        }
        
        alert.addAction(actionDelete)
        alert.addAction(actionCancel)
        
        if let popover:UIPopoverPresentationController = alert.popoverPresentationController
        {
            popover.sourceView = view
            popover.sourceRect = CGRect.zero
            popover.permittedArrowDirections = UIPopoverArrowDirection.up
        }
        
        present(alert, animated:true, completion:nil)
    }
    
    func save()
    {
        stopPlaying()
        viewPreview.saving()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncSave()
        }
    }
}
