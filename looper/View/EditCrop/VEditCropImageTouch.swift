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
        if corner === cornerTopLeft
        {
            cornerMoveTopLeft(
                corner:corner,
                newX:newX,
                newY:newY)
        }
        else if corner === cornerTopRight
        {
            cornerMoveTopRight(
                corner:corner,
                newX:newX,
                newY:newY)
        }
        else if corner === cornerBottomLeft
        {
            cornerMoveBottomLeft(
                corner:corner,
                newX:newX,
                newY:newY)
        }
        else
        {
            cornerMoveBottomRight(
                corner:corner,
                newX:newX,
                newY:newY)
        }
    }
    
    private func cornerMoveTopLeft(
        corner:VEditCropImageCorner,
        newX:CGFloat,
        newY:CGFloat)
    {
        let minX:CGFloat = corner.initialX
        let maxX:CGFloat = cornerTopRight.layoutLeft.constant - kMinCornerSeparation
        let minY:CGFloat = corner.initialY
        let maxY:CGFloat = cornerBottomLeft.layoutTop.constant - kMinCornerSeparation
        let validX:CGFloat = validateValue(
            value:newX,
            minValue:minX,
            maxValue:maxX)
        let validY:CGFloat = validateValue(
            value:newY,
            minValue:minY,
            maxValue:maxY)
        
        corner.layoutLeft.constant = validX
        corner.layoutTop.constant = validY
        cornerBottomLeft.layoutLeft.constant = validX
        cornerTopRight.layoutTop.constant = validY
    }
    
    private func cornerMoveTopRight(
        corner:VEditCropImageCorner,
        newX:CGFloat,
        newY:CGFloat)
    {
        let minX:CGFloat = cornerTopLeft.layoutLeft.constant + kMinCornerSeparation
        let maxX:CGFloat = corner.initialX
        let minY:CGFloat = corner.initialY
        let maxY:CGFloat = cornerBottomRight.layoutTop.constant - kMinCornerSeparation
        let validX:CGFloat = validateValue(
            value:newX,
            minValue:minX,
            maxValue:maxX)
        let validY:CGFloat = validateValue(
            value:newY,
            minValue:minY,
            maxValue:maxY)
        
        corner.layoutLeft.constant = validX
        corner.layoutTop.constant = validY
        cornerBottomRight.layoutLeft.constant = validX
        cornerTopLeft.layoutTop.constant = validY
    }
    
    private func cornerMoveBottomLeft(
        corner:VEditCropImageCorner,
        newX:CGFloat,
        newY:CGFloat)
    {
        let minX:CGFloat = corner.initialX
        let maxX:CGFloat = cornerBottomRight.layoutLeft.constant - kMinCornerSeparation
        let minY:CGFloat = cornerTopLeft.layoutTop.constant + kMinCornerSeparation
        let maxY:CGFloat = corner.initialY
        let validX:CGFloat = validateValue(
            value:newX,
            minValue:minX,
            maxValue:maxX)
        let validY:CGFloat = validateValue(
            value:newY,
            minValue:minY,
            maxValue:maxY)
        
        corner.layoutLeft.constant = validX
        corner.layoutTop.constant = validY
        cornerTopLeft.layoutLeft.constant = validX
        cornerBottomRight.layoutTop.constant = validY
    }
    
    private func cornerMoveBottomRight(
        corner:VEditCropImageCorner,
        newX:CGFloat,
        newY:CGFloat)
    {
        let minX:CGFloat = cornerBottomLeft.layoutLeft.constant + kMinCornerSeparation
        let maxX:CGFloat = corner.initialX
        let minY:CGFloat = cornerTopRight.layoutTop.constant + kMinCornerSeparation
        let maxY:CGFloat = corner.initialY
        let validX:CGFloat = validateValue(
            value:newX,
            minValue:minX,
            maxValue:maxX)
        let validY:CGFloat = validateValue(
            value:newY,
            minValue:minY,
            maxValue:maxY)
        
        corner.layoutLeft.constant = validX
        corner.layoutTop.constant = validY
        cornerTopRight.layoutLeft.constant = validX
        cornerBottomLeft.layoutTop.constant = validY
    }
    
    private func validateValue(
        value:CGFloat,
        minValue:CGFloat,
        maxValue:CGFloat) -> CGFloat
    {
        let newValue:CGFloat
        
        if value >= minValue
        {
            if value <= maxValue
            {
                newValue = value
            }
            else
            {
                newValue = maxValue
            }
        }
        else
        {
            newValue = minValue
        }
        
        return newValue
    }
}
