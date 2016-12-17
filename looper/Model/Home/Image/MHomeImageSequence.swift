import UIKit

class MHomeImageSequence
{
    private(set) var items:[MHomeImageSequenceItem]
    
    init()
    {
        items = []
    }
    
    //MARK: public
    
    func add(image:UIImage)
    {
        let item:MHomeImageSequenceItem = MHomeImageSequenceItem(
            image:image)
        items.append(item)
    }
}
