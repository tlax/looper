import Foundation

class MHomeImage
{
    weak var mainSequence:MHomeImageSequenceRaw?
    private var generatedSequence:MHomeImageSequenceGenerated?
    private(set) var sequences:[MHomeImageSequenceRaw]
    
    init()
    {
        sequences = []
    }
    
    //MARK: private
    
    private func asyncGenerateSequence()
    {
        guard
            
            let main:MHomeImageSequenceRaw = mainSequence
        
        else
        {
            return
        }
        
        generatedSequence = MHomeImageSequenceGenerated(sequence:main)
        
        MSession.sharedInstance.state = MSession.State.standBy
        NotificationCenter.default.post(
            name:Notification.imagesUpdated,
            object:nil)
    }
    
    //MARK: public
    
    func clear()
    {
        generatedSequence = nil
    }
    
    func add(sequence:MHomeImageSequenceRaw)
    {
        sequences.append(sequence)
        sequence.render()
    }
    
    func generateSequence() -> MHomeImageSequenceGenerated?
    {
        if MSession.sharedInstance.state == MSession.State.rendering
        {
            return nil
        }
        
        guard
        
            let generatedSequence:MHomeImageSequenceGenerated = self.generatedSequence
        
        else
        {
            MSession.sharedInstance.state = MSession.State.rendering
            asyncGenerateSequence()
            
            return nil
        }
        
        return generatedSequence
    }
}
