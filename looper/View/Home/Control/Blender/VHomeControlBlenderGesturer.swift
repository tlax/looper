import UIKit

class VHomeControlBlenderGesturer:UIView
{
    private var deltaPoint:CGPoint?
    private weak var controller:CHome!
    private weak var viewPieces:VHomeControlBlenderPieces!
    private weak var viewBoard:VHomeControlBlenderBoard!
    private weak var gesturingItem:VHomeControlBlenderPiecesItem?
    
    convenience init(
        controller:CHome,
        viewPieces:VHomeControlBlenderPieces,
        viewBoard:VHomeControlBlenderBoard)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        self.viewPieces = viewPieces
        self.viewBoard = viewBoard
    }
    
    override func touchesBegan(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        guard
        
            let touch:UITouch = touches.first
        
        else
        {
            return
        }
        
        let location:CGPoint = touch.location(in:self)
        
        guard
        
            let gesturingItem:VHomeControlBlenderPiecesItem = viewPieces.pieceAt(location:location)
        
        else
        {
            return
        }
        
        let locationX:CGFloat = location.x
        let locationY:CGFloat = location.y
        let deltaX:CGFloat = locationX - gesturingItem.layoutLeft.constant
        let deltaY:CGFloat = locationY - gesturingItem.layoutTop.constant
        deltaPoint = CGPoint(
            x:deltaX,
            y:deltaY)
        
        gesturingItem.selected()
        self.gesturingItem = gesturingItem
    }
    
    override func touchesMoved(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        guard
            
            let gesturingItem:VHomeControlBlenderPiecesItem = self.gesturingItem,
            let deltaPoint:CGPoint = self.deltaPoint,
            let touch:UITouch = touches.first
            
        else
        {
            return
        }
        
        let location:CGPoint = touch.location(in:self)
        let locationX:CGFloat = location.x
        let locationY:CGFloat = location.y
        let newX:CGFloat = locationX - deltaPoint.x
        let newY:CGFloat = locationY - deltaPoint.y
        
        gesturingItem.layoutLeft.constant = newX
        gesturingItem.layoutTop.constant = newY
    }
    
    override func touchesEnded(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        gestureEnds()
    }
    
    override func touchesCancelled(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        gestureEnds()
    }
    
    //MARK: private
    
    private func gestureEnds()
    {
        deltaPoint = nil
        
        guard
            
            let gesturingItem:VHomeControlBlenderPiecesItem = self.gesturingItem
            
        else
        {
            return
        }
        
        gesturingItem.clear()
        viewBoard.viewMain.dropping(piece:gesturingItem)
        viewBoard.viewOver.dropping(piece:gesturingItem)
        viewBoard.viewOver.imageView.image = viewBoard.viewMain.piece?.model.items.first?.image
    }
}
