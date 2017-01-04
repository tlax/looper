import Foundation

class MLoopsOptions
{
    let items:[MLoopsOptionsItem]
    
    init()
    {
        let itemTrash:MLoopsOptionsItemTrash = MLoopsOptionsItemTrash()
        let itemShare:MLoopsOptionsItemShare = MLoopsOptionsItemShare()
        
        items = [
            itemTrash,
            itemShare
        ]
    }
}
