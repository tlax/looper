import Foundation

class MEdit:Model
{
    private(set) var sequence:MEditSequence?
    
    //MARK: public
    
    func config(sequence:MEditSequence)
    {
        self.sequence = sequence
    }
}
