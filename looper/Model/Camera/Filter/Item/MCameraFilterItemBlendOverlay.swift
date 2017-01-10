import UIKit

class MCameraFilterItemBlendOverlay
{
    weak var record:MCameraRecord!
    let percentPosX:CGFloat
    let percentPosY:CGFloat
    let percentSize:CGFloat
    
    init(
        record:MCameraRecord,
        percentPosX:CGFloat,
        percentPosY:CGFloat,
        percentSize:CGFloat)
    {
        self.record = record
        self.percentPosX = percentPosX
        self.percentPosY = percentPosY
        self.percentSize = percentSize
    }
}
