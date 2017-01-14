import UIKit

class VCameraFilterBlenderOverlayPlacer:UIView
{
    private weak var controller:CCameraFilterBlenderOverlay!
    private weak var draggingPiece:VCameraFilterBlenderOverlayPiece?
    private var startingPoint:CGPoint?
    
    init(controller:CCameraFilterBlenderOverlay)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func touchesBegan(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        if draggingPiece == nil
        {
            guard
                
                let point:CGPoint = touches.first?.location(in:self)
                
            else
            {
                return
            }
            
            var draggingPiece:VCameraFilterBlenderOverlayPiece?
            
            for subview:UIView in subviews
            {
                guard
                    
                    let viewPiece:VCameraFilterBlenderOverlayPiece = subview as? VCameraFilterBlenderOverlayPiece
                
                else
                {
                    continue
                }
                
                let pieceFrame:CGRect = viewPiece.frame
                
                if pieceFrame.contains(point)
                {
                    draggingPiece = viewPiece
                }
            }
            
            guard
            
                let viewPiece:VCameraFilterBlenderOverlayPiece = draggingPiece
            
            else
            {
                return
            }
            
            startDragging(
                viewPiece:viewPiece,
                touchLocation:point)
        }
    }
    
    override func touchesMoved(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        guard
        
            let draggingPiece:VCameraFilterBlenderOverlayPiece = self.draggingPiece,
            let point:CGPoint = touches.first?.location(in:self),
            let startingPoint:CGPoint = self.startingPoint
        
        else
        {
            return
        }
        
        let deltaX:CGFloat = point.x - startingPoint.x
        let deltaY:CGFloat = point.y - startingPoint.y
        draggingPiece.layoutTop.constant = deltaY
        draggingPiece.layoutLeft.constant = deltaX
    }
    
    override func touchesEnded(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        endDragging()
    }
    
    override func touchesCancelled(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        endDragging()
    }
    
    //MARK: private
    
    private func startDragging(
        viewPiece:VCameraFilterBlenderOverlayPiece,
        touchLocation:CGPoint)
    {
        bringSubview(toFront:viewPiece)
        
        self.draggingPiece = viewPiece
        viewPiece.startDragging()
        
        let currentX:CGFloat = viewPiece.layoutLeft.constant
        let currentY:CGFloat = viewPiece.layoutTop.constant
        let startingX:CGFloat = touchLocation.x - currentX
        let startingY:CGFloat = touchLocation.y - currentY
        startingPoint = CGPoint(
            x:startingX,
            y:startingY)
    }
    
    private func endDragging()
    {
        guard
        
            let draggingPiece:VCameraFilterBlenderOverlayPiece = self.draggingPiece
        
        else
        {
            return
        }
        
        self.draggingPiece = nil
        startingPoint = nil
        draggingPiece.stopDragging()
        controller.viewOverlay.viewBase.validatePiece(viewPiece:draggingPiece)
    }
    
    //MARK: public
    
    func addPiece(viewPiece:VCameraFilterBlenderOverlayPiece)
    {
        addSubview(viewPiece)
        viewPiece.animateShow()
    }
    
    func killDrag()
    {
        endDragging()
    }
}
