import UIKit
import MetalKit

class MHomeImageSequenceRawPoint
{
    let percentRadius:CGFloat
    let percentPosX:CGFloat
    let percentPosY:CGFloat
    var mapTexture:MTLTexture?
    
    init(
        percentRadius:CGFloat,
        percentPosX:CGFloat,
        percentPosY:CGFloat)
    {
        self.percentRadius = percentRadius
        self.percentPosX = percentPosX
        self.percentPosY = percentPosY
    }
}
