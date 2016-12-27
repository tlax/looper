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
    
    private func notifyImagesUpdated()
    {
        MSession.sharedInstance.state = MSession.State.standBy
        NotificationCenter.default.post(
            name:Notification.imagesUpdated,
            object:nil)
    }
    
    private func asyncGenerateSequence()
    {
        var blendingSequences:[MHomeImageSequenceRaw] = []
        
        for sequence:MHomeImageSequenceRaw in sequences
        {
            if sequence.point != nil
            {
                if sequence !== mainSequence
                {
                    blendingSequences.append(sequence)
                }
            }
        }
        
        if mainSequence == nil
        {
            if blendingSequences.isEmpty
            {
                notifyImagesUpdated()
                
                return
            }
        }
        
        if self.device == nil
        {
            self.device = MTLCreateSystemDefaultDevice()
        }
        
        guard
            
            let device:MTLDevice = self.device
        
        else
        {
            notifyImagesUpdated()
            
            return
        }
        
        renderedSequence = MHomeImageSequenceGenerated(
            device:device,
            main:mainSequence,
            sequences:blendingSequences,
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
        
        if sequences.isEmpty
        {
            mainSequence = sequence
        }
        
        sequences.append(sequence)
        sequence.render()
    }
    
    func moveToLast(last:MHomeImageSequenceRaw)
    {
        var sequences:[MHomeImageSequenceRaw] = []
        
        for sequence:MHomeImageSequenceRaw in self.sequences
        {
            if sequence !== last
            {
                sequences.append(sequence)
            }
        }
        
        sequences.append(last)
        
        self.sequences = sequences
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
