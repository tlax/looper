import UIKit

extension VEditCropImage
{
    func touchesBegan(touches:Set<UITouch>)
    {
        guard
        
            let touch:UITouch = touches.first,
            let corner:VEditCropImageCorner = touch.view as? VEditCropImageCorner
        
        else
        {
            return
        }
        
        let point:CGPoint = touch.location(in:self)
        corner.previousTouch = point
        movingCorner = corner
    }
    
    func touchesMoved(touches:Set<UITouch>)
    {
        guard
        
            let touch:UITouch = touches.first,
            let corner:VEditCropImageCorner = movingCorner,
            let previousTouch:CGPoint = corner.previousTouch
        
        else
        {
            return
        }
        
        let point:CGPoint = touch.location(in:self)
        let deltaX:CGFloat = point.x - previousTouch.x
        let deltaY:CGFloat = point.y - previousTouch.y
        let newX:CGFloat = corner.layoutLeft.constant + deltaX
        let newY:CGFloat = corner.layoutTop.constant + deltaY
        corner.previousTouch = point
        cornerMove(corner:corner, newX:newX, newY:newY)
    }
    
    func touchesCancelled(touches:Set<UITouch>)
    {
        movingCorner = nil
    }
    
    func touchesEnded(touches:Set<UITouch>)
    {
        movingCorner = nil
    }
    
    //MARK: private
    
    private func cornerMove(
        corner:VEditCropImageCorner,
        newX:CGFloat,
        newY:CGFloat)
    {
        if let corner:VEditCropImageCornerTopLeft = corner as? VEditCropImageCornerTopLeft
        {
            cornerMoveTopLeft(corner:corner, newX:newX, newY:newY)
        }
    }
    
    private func cornerMoveTopLeft(
        corner:VEditCropImageCornerTopLeft,
        newX:CGFloat,
        newY:CGFloat)
    {
        
    }
}
