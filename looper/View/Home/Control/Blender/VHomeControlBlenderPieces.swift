import UIKit

class VHomeControlBlenderPieces:UIView
{
    private weak var controller:CHome!
    private let items:[VHomeControlBlenderPiecesItem]
    private let kItemSize:CGFloat = 70
    private let itemSize_2:CGFloat
    private let kAnimationDuration:TimeInterval = 0.4
    
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
        
        layoutItems()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: private
    
    private func layoutItems()
    {
        var constraints:[NSLayoutConstraint] = []
        
        for item:VHomeControlBlenderPiecesItem in items
        {
            item.layoutTop = NSLayoutConstraint.topToTop(
                view:item,
                toView:self)
            item.layoutLeft = NSLayoutConstraint.leftToLeft(
                view:item,
                toView:self)
            
            constraints.append(item.layoutTop)
            constraints.append(item.layoutLeft)
        }
        
        addConstraints(constraints)
    }
    
    //MARK: public
    
    func restartPieces()
    {
        for item:VHomeControlBlenderPiecesItem in items
        {
            
        }
    }
}
