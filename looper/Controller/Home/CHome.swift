import UIKit

class CHome:Controller<VHome>
{
    let model:MHome
    
    override init()
    {
        model = MHome()
        super.init()
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedSessionLoaded(sender:)),
            name:Notification.sessionLoaded,
            object:nil)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        guard
        
            let view:VHome = self.view as? VHome
        
        else
        {
            return
        }
        
        view.viewOptions.refresh()
    }
    
    //MARK: notified
    
    func notifiedSessionLoaded(sender notification:Notification)
    {
        refreshOptions()
    }
    
    //MARK: private
    
    private func refreshOptions()
    {
        model.refreshOptions()
        
        DispatchQueue.main.async
        { [weak self] in
            
            guard
                
                let view:VHome = self?.view as? VHome
                
            else
            {
                return
            }
            
            view.sessionLoaded()
        }
    }
    
    private func showSplash(option:MHomeOptions)
    {
        guard
            
            let parent:ControllerParent = self.parent as? ControllerParent
            
        else
        {
            return
        }
        
        let controller:CHomeSplash = CHomeSplash(modelOption:option)
        parent.push(
            controller:controller,
            horizontal:ControllerParent.Horizontal.right)
    }
    
    private func showFroob(option:MHomeOptions)
    {
        guard
            
            let parent:ControllerParent = self.parent as? ControllerParent
            
        else
        {
            return
        }
        
        let controller:CHomeFroob = CHomeFroob(
            controllerHome:self,
            option:option)
        parent.animateOver(controller:controller)
    }
    
    //MARK: public
    
    func optionSelected(option:MHomeOptions)
    {
        let available:Bool = option.available()
        
        if available
        {
            showSplash(option:option)
        }
        else
        {
            showFroob(option:option)
        }
    }
    
    func footerSettings()
    {
        guard
            
            let parent:ControllerParent = self.parent as? ControllerParent
            
        else
        {
            return
        }
        
        
        let controller:CSettings = CSettings()
        parent.push(
            controller:controller,
            horizontal:ControllerParent.Horizontal.right)
    }
    
    func footerBoards()
    {
        guard
        
            let parent:ControllerParent = self.parent as? ControllerParent
        
        else
        {
            return
        }
        
        let showBoards:Bool = parent.gameLeaderBoards()
        
        if !showBoards
        {
            let error:String = String.localized(key:"CHome_errorGameBoards")
            VAlert.messageFail(message:error)
        }
    }
    
    func footerStore()
    {
        guard
            
            let parent:ControllerParent = self.parent as? ControllerParent
            
        else
        {
            return
        }
        
        let options:[MHomeOptions] = model.purchaseOptions()
        
        let controller:CStore = CStore(options:options)
        parent.push(
            controller:controller,
            horizontal:ControllerParent.Horizontal.right)
    }
}
