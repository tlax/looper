import Foundation
import MetalKit

class MHomeImage
{
    var renderedSequence:MHomeImageSequenceGenerated?
    weak var mainSequence:MHomeImageSequenceRaw?
    private var device:MTLDevice?
    private(set) var longestSequence:Int
    private(set) var sequences:[MHomeImageSequenceRaw]
    
    init()
    {
        longestSequence = 0
        sequences = []
    }
    
    //MARK: private
    
    private func asyncGenerateSequence()
    {
        if self.device == nil
        {
            self.device = MTLCreateSystemDefaultDevice()
        }
        
        guard
            
            let device:MTLDevice = self.device
        
        else
        {
            MSession.sharedInstance.state = MSession.State.standBy
            NotificationCenter.default.post(
                name:Notification.imagesUpdated,
                object:nil)
            
            return
        }
        
        renderedSequence = MHomeImageSequenceGenerated(
            device:device,
            main:mainSequence,
            sequences:sequences,
            length:longestSequence)
    }
    
    //MARK: public
    
    func add(sequence:MHomeImageSequenceRaw)
    {
        let sequenceLength:Int = sequence.items.count
        
        if sequenceLength > longestSequence
        {
            longestSequence = sequenceLength
        }
        
        sequences.append(sequence)
        sequence.render()
    }
    
    func generateSequence()
    {
        if MSession.sharedInstance.state != MSession.State.rendering
        {
            MSession.sharedInstance.state = MSession.State.rendering
            renderedSequence = nil
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.asyncGenerateSequence()
            }
        }
    }
}
