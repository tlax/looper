import Foundation

class MCreate:Model
{
    private(set) var items:[MCreateItem]
    let source:[MSourceProtocol]
    
    required init()
    {
        items = []
        source = MCreate.factorySource()
    }
    
    //MARK: public
    
    func addItem(item:MCreateItem)
    {
        items.append(item)
        delegate?.modelRefresh()
    }
}
