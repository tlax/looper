import UIKit

class VHomeControlBlenderGesturer:UIView
{
    private weak var controller:CHome!
    private weak var pieces:VHomeControlBlenderPieces!
    private weak var gesturingItem:VHomeControlBlenderPiecesItem?
    
    convenience init(
        controller:CHome,
        pieces:VHomeControlBlenderPieces)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        self.pieces = pieces
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
        
        
    }
    
    override func touchesMoved(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        guard
            
            let gesturingItem:VHomeControlBlenderPiecesItem = self.gesturingItem,
            let touch:UITouch = touches.first
            
        else
        {
            return
        }
        
        
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
        guard
            
            let gesturingItem:VHomeControlBlenderPiecesItem = self.gesturingItem
            
        else
        {
            return
        }
    }
}
