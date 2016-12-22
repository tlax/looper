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
        generatedSequence = MHomeImageSequenceGenerated()
        generatedSequence?.blend(
            main:mainSequence,
            items:sequences)
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
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.asyncGenerateSequence()
            }
            
            return nil
        }
        
        return generatedSequence
    }
}
