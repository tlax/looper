import UIKit

class CCameraPreview:CController
{
    weak var viewPreview:VCameraPreview!
    let model:MCameraRecord
    
    init(model:MCameraRecord)
    {
        self.model = model
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
        fatalError()
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
            viewPreview.viewPlayer.buttonPlay.play()
            viewPreview.viewDisplay.imageView.stopAnimating()
        }
        else
        {
            viewPreview.viewPlayer.buttonPlay.stop()
            viewPreview.viewDisplay.imageView.startAnimating()
        }
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func cancel()
    {
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
        present(alert, animated:true, completion:nil)
    }
    
    func save()
    {
        viewPreview.saving()
    }
}
