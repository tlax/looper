import UIKit

class VHomeControlBlenderPieces:UIView
{
    private weak var controller:CHome!
    private let items:[VHomeControlBlenderPiecesItem]
    private let itemSize_2:CGFloat
    private let kItemSize:CGFloat = 70
    private let kItemMargin:CGFloat = 10
    private let kItemsTop:CGFloat = 30
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
                model:firstSequenceItem)
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
            addSubview(item)
            
            item.layoutTop = NSLayoutConstraint.topToTop(
                view:item,
                toView:self,
                constant:-kItemSize)
            item.layoutLeft = NSLayoutConstraint.leftToLeft(
                view:item,
                toView:self,
                constant:-kItemSize)
            
            let layoutItemWidth = NSLayoutConstraint.width(
                view:item,
                constant:kItemSize)
            let layoutItemHeight = NSLayoutConstraint.height(
                view:item,
                constant:kItemSize)
            
            constraints.append(contentsOf:[
                item.layoutTop,
                item.layoutLeft,
                layoutItemWidth,
                layoutItemHeight])
        }
        
        addConstraints(constraints)
    }
    
    //MARK: public
    
    func restartPieces()
    {
        let useY:CGFloat = kItemsTop
        var currentX:CGFloat = kItemMargin
        
        for item:VHomeControlBlenderPiecesItem in items
        {
            item.layoutLeft.constant = currentX
            item.layoutTop.constant = useY
            
            currentX += kItemSize + kItemMargin
        }
        
        UIView.animate(
            withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
    
    func pieceAt(location:CGPoint) -> VHomeControlBlenderPiecesItem?
    {
        var selectedItem:VHomeControlBlenderPiecesItem?
        var currentMinDelta:CGFloat = 0
        let maxX:CGFloat = location.x
        let maxY:CGFloat = location.y
        let minX:CGFloat = maxX - kItemSize
        let minY:CGFloat = maxY - kItemSize
        
        for item:VHomeControlBlenderPiecesItem in items
        {
            let itemX:CGFloat = item.layoutLeft.constant
            let itemY:CGFloat = item.layoutTop.constant
            
            if itemX > minX
            {
                if itemY > minY
                {
                    if itemX < maxX
                    {
                        if itemY < maxY
                        {
                            
                        }
                    }
                }
            }
        }
        
        return selectedItem
    }
}
