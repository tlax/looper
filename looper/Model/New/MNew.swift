import Foundation

class MNew:Model
{
    let items:[MSourceProtocol]
    
    required init()
    {
        items = MNew.factorySource()
    }
}
