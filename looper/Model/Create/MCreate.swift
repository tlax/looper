import Foundation

class MCreate:Model
{
    let source:[MSourceProtocol]
    
    required init()
    {
        source = MCreate.factorySource()
    }
}
