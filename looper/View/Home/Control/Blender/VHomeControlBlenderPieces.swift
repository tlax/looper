import UIKit

class VHomeControlBlenderPieces:UIView
{
    private weak var controller:CHome!
    private let items:[VHomeControlBlenderPiecesItem]
    private let kItemSize:CGFloat = 70
    private let kItemMargin:CGFloat = 10
    private let kItemsTop:CGFloat = 30
    private let kAnimationDuration:TimeInterval = 0.4
    
    init(controller:CHome)
    {
        let useY:CGFloat = kItemsTop
        var currentX:CGFloat = kItemMargin
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
                originalX:currentX,
                originalY:useY)
            items.append(item)
            
            currentX += kItemSize + kItemMargin
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
                constant:item.originalY)
            item.layoutLeft = NSLayoutConstraint.leftToLeft(
                view:item,
                toView:self,
                constant:item.originalX)
            
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
        for item:VHomeControlBlenderPiecesItem in items
        {
            item.layoutLeft.constant = item.originalX
            item.layoutTop.constant = item.originalY
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
        var currentMinDeltaX:CGFloat = 0
        var currentMinDeltaY:CGFloat = 0
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
                            let deltaMinX:CGFloat = itemX - minX
                            let deltaMinY:CGFloat = itemY - minY
                            let deltaMaxX:CGFloat = maxX - itemX
                            let deltaMaxY:CGFloat = maxY - itemY
                            let minDeltaX:CGFloat = min(deltaMinX, deltaMaxX)
                            let minDeltaY:CGFloat = min(deltaMinY, deltaMaxY)
                            
                            if selectedItem == nil
                            {
                                selectedItem = item
                                currentMinDeltaX = minDeltaX
                                currentMinDeltaY = minDeltaY
                            }
                            else
                            {
                                if minDeltaX <= currentMinDeltaX
                                {
                                    if minDeltaY <= currentMinDeltaY
                                    {
                                        selectedItem = item
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return selectedItem
    }
}
