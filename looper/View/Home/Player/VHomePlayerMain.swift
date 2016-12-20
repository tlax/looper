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
        setImage(
            #imageLiteral(resourceName: "assetHomePlayerPlay"),
            for:UIControlState.normal)
        setImage(
            #imageLiteral(resourceName: "assetHomePlayerPlaySelected"),
            for:UIControlState.highlighted)
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
                
                if controller.modelImage.generateSequence()?.items.first != nil
                {
                    buttonStop()
                }
            
                break
            
            case MSession.State.playing:
            
                buttonPlay()
                
                break;
            
            case MSession.State.rendering:
                break;
        }
    }
    
    //MARK: private
    
    private func buttonStop()
    {
        controller.animate()
        
        setImage(
            #imageLiteral(resourceName: "assetHomePlayerPlay"),
            for:UIControlState.normal)
        setImage(
            #imageLiteral(resourceName: "assetHomePlayerPlaySelected"),
            for:UIControlState.highlighted)
    }
    
    private func buttonPlay()
    {
        controller.stopAnimation()
        
        setImage(
            #imageLiteral(resourceName: "assetHomePlayerPlay"),
            for:UIControlState.normal)
        setImage(
            #imageLiteral(resourceName: "assetHomePlayerPlaySelected"),
            for:UIControlState.highlighted)
    }
}
