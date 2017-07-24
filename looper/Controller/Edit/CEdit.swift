import Foundation

class CEdit:Controller<VEdit, MEdit>
{
    init(sequence:MEditSequence)
    {
        super.init()
        model.config(sequence:sequence)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
