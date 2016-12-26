import UIKit

class VHomeControlBlenderPieces:UIView
{
    private weak var controller:CHome!
    private var items:[VHomeControlBlenderPiecesItem]
    private let kItemSize:CGFloat = 70
    private let kItemMargin:CGFloat = 10
    private let kItemsTop:CGFloat = 30
    private let kAnimationDuration:TimeInterval = 0.4
    private let kDeadlineMain:TimeInterval = 0.3
    
    init(controller:CHome)
    {
        items = []
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        self.controller = controller
        
        var constraints:[NSLayoutConstraint] = []
        let useY:CGFloat = kItemsTop
        var currentX:CGFloat = kItemMargin
        let main:MHomeImageSequenceRaw? = controller.modelImage.mainSequence
        
        for sequence:MHomeImageSequenceRaw in controller.modelImage.sequences
        {
            sequence.point = nil
            let item:VHomeControlBlenderPiecesItem = VHomeControlBlenderPiecesItem(
                model:sequence)
            let useX:CGFloat
            items.append(item)
            
            if sequence === main
            {
                useX = kItemMargin
                
                DispatchQueue.main.asyncAfter(
                    deadline:DispatchTime.now() + kDeadlineMain)
                {
                    guard
                    
                        let viewBoardMain:VHomeControlBlenderBoardMain = controller.viewHome.viewControl.viewBlender?.viewBoard.viewMain
                    
                    else
                    {
                        return
                    }
                    
                    viewBoardMain.dropping(piece:item)
                }
            }
            else
            {
                useX = currentX
                currentX = useX + kItemSize + kItemMargin
            }
            
            addSubview(item)
            
            item.layoutTop = NSLayoutConstraint.topToTop(
                view:item,
                toView:self,
                constant:useY)
            item.layoutLeft = NSLayoutConstraint.leftToLeft(
                view:item,
                toView:self,
                constant:useX)
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
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func relocate(piece:VHomeControlBlenderPiecesItem)
    {
        var found:Bool = false
        let useY:CGFloat = kItemsTop
        var useX:CGFloat = kItemMargin
        
        while !found
        {
            found = true
            let frame:CGRect = CGRect(
                x:useX,
                y:useY,
                width:kItemSize,
                height:kItemSize)
            
            for item:VHomeControlBlenderPiecesItem in items
            {
                if item.frame.intersects(frame)
                {
                    useX += 1
                    found = false
                    
                    break
                }
            }
        }
        
        piece.layoutTop.constant = useY
        piece.layoutLeft.constant = useX
        
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
