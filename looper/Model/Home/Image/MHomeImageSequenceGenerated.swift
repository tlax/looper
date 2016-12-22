import UIKit

class MHomeImageSequenceGenerated:MHomeImageSequence
{
    //MARK: private
    
    private func blendFinished()
    {
        MSession.sharedInstance.state = MSession.State.standBy
        NotificationCenter.default.post(
            name:Notification.imagesUpdated,
            object:nil)
    }
    
    //MARK: public
    
    func blend(main:MHomeImageSequenceRaw?, items:[MHomeImageSequenceRaw])
    {
        
    }
}
