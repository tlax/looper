import Foundation

class MHomeImageSequenceGenerated:MHomeImageSequence
{
    init(sequence:MHomeImageSequenceRaw)
    {
        super.init(items:sequence.items)
    }
    
    override init()
    {
        fatalError()
    }
    
    override init(items:[MHomeImageSequenceItem])
    {
        fatalError()
    }
}
