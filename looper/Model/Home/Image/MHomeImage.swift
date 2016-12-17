import Foundation

class MHomeImage
{
    private(set) var sequences:[MHomeImageSequence]
    
    init()
    {
        sequences = []
    }
    
    //MARK: public
    
    func add(sequence:MHomeImageSequence)
    {
        sequences.append(sequence)
    }
}
