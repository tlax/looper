import UIKit
import MetalKit

class MHomeImageSequenceGenerated:MHomeImageSequence
{
    //MARK: private
    
    private func loadSequenceTextures(
        sequence:MHomeImageSequenceRaw,
        textureLoader:MTKTextureLoader,
        textureOptions:[String:NSObject])
    {
        for item:MHomeImageSequenceItem in sequence.items
        {
            item.createTexture(
                textureLoader:textureLoader,
                textureOptions:textureOptions)
        }
    }
    
    private func blendFinished()
    {
        MSession.sharedInstance.state = MSession.State.standBy
        NotificationCenter.default.post(
            name:Notification.imagesUpdated,
            object:nil)
    }
    
    //MARK: public
    
    func blend(
        textureLoader:MTKTextureLoader,
        textureOptions:[String:NSObject],
        main:MHomeImageSequenceRaw?,
        items:[MHomeImageSequenceRaw])
    {
        if let main:MHomeImageSequenceRaw = main
        {
            loadSequenceTextures(
                sequence:main,
                textureLoader:textureLoader,
                textureOptions:textureOptions)
        }
        else
        {
            
        }
        
        for item:MHomeImageSequenceRaw in items
        {
            loadSequenceTextures(
                sequence:item,
                textureLoader:textureLoader,
                textureOptions:textureOptions)
        }
    }
}
