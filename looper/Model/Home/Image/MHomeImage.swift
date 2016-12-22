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
            
            let first:MHomeImageSequenceRaw = sequences.first
        
        else
        {
            return
        }
        
        generatedSequence = MHomeImageSequenceGenerated(sequence:first)
        
        MSession.sharedInstance.state = MSession.State.standBy
        NotificationCenter.default.post(
            name:Notification.imagesUpdated,
            object:nil)
    }
    
    //MARK: public
    
    func add(sequence:MHomeImageSequenceRaw)
    {
        generatedSequence = nil
        sequences.append(sequence)
    }
    
    func generateSequence() -> MHomeImageSequenceGenerated?
    {
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
