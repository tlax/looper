import Foundation

class MHomeImage
{
    var generatedSequence:MHomeImageSequenceGenerated?
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
            asyncGenerateSequence()
            
            return nil
        }
        
        return generatedSequence
    }
}
