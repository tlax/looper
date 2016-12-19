import Foundation

class MHomeImage
{
    var generatedSequence:MHomeImageSequence?
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
    
    func add(sequence:MHomeImageSequence)
    {
        generatedSequence = nil
        sequences.append(sequence)
        
        NotificationCenter.default.post(
            name:Notification.imagesUpdated,
            object:nil)
    }
    
    func generateSequence() -> MHomeImageSequence?
    {
        guard
        
            let generatedSequence:MHomeImageSequence = self.generatedSequence
        
        else
        {
            return nil
        }
        
        return generatedSequence
    }
}
