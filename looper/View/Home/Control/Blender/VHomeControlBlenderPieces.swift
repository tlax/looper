import UIKit

class VHomeControlBlenderPieces:UIView
{
    private weak var controller:CHome!
    private let items:[VHomeControlBlenderPiecesItem]
    private let kItemSize:CGFloat = 70
    private let itemSize_2:CGFloat
    
    init(controller:CHome)
    {
        itemSize_2 = kItemSize / 2.0
        
        var items:[VHomeControlBlenderPiecesItem] = []
        
        for sequence:MHomeImageSequenceRaw in controller.modelImage.sequences
        {
            guard
            
                let firstSequenceItem:MHomeImageSequenceItem = sequence.items.first
            
            else
            {
                continue
            }
            
            let item:VHomeControlBlenderPiecesItem = VHomeControlBlenderPiecesItem(
                model:firstSequenceItem,
                size:kItemSize)
            items.append(item)
        }
        
        self.items = items
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
