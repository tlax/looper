import UIKit

class VHomePlayerMain:UIButton
{
    private weak var controller:CHome!
    
    convenience init(controller:CHome)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        imageView!.contentMode = UIViewContentMode.center
        imageView!.clipsToBounds = true
        addTarget(
            self,
            action:#selector(self.actionMain(sender:)),
            for:UIControlEvents.touchUpInside)
        self.controller = controller
    }
    
    //MARK: actions
    
    func actionMain(sender button:UIButton)
    {
        switch MSession.sharedInstance.state
        {
            case MSession.State.standBy,
                 MSession.State.frame:
                
                if controller.modelImage.generatedSequence?.items.first != nil
                {
                    controller.animate()
                    buttonStop()
                }
            
                break
            
            case MSession.State.playing:
            
                controller.stopAnimation()
                buttonPlay()
                
                break;
            
            case MSession.State.rendering:
                break;
        }
    }
    
    //MARK: private
    
    private func buttonStop()
    {
        
    }
    
    private func buttonPlay()
    {
        
    }
}
