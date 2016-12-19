import Foundation

class MHomeImage
{
    var generatedSequence:MHomeImageSequenceGenerated?
    private(set) var sequences:[MHomeImageSequence]
    
    init()
    {
        sequences = []
    }
    
    //MARK: private
    
    private func asyncGenerateSequence()
    {
        NotificationCenter.default.post(
            name:Notification.imagesUpdated,
            object:nil)
    }
    
    //MARK: public
    
    func add(sequence:MHomeImageSequenceRaw)
    {
        generatedSequence = nil
        sequences.append(sequence)
        
        NotificationCenter.default.post(
            name:Notification.imagesUpdated,
            object:nil)
    }
    
    func generateSequence() -> MHomeImageSequenceGenerated?
    {
        guard
        
            let generatedSequence:MHomeImageSequenceGenerated = self.generatedSequence
        
        else
        {
            return nil
        }
        
        return generatedSequence
    }
}
