import UIKit

class MCamera
{
    static let kImageMaxSize:CGFloat = 480
    static let kMaxShots:Int = 300
    let speeds:[MCameraSpeed]
    var records:[MCameraRecord]
    var raw:MCameraRaw?
    var currentSpeed:Int
    private let kDefaultSpeed:Int = 4
    
    init()
    {
        speeds = MCameraSpeed.all()
        records = []
        currentSpeed = kDefaultSpeed
    }
    
    //MARK: public
    
    func currentSpeedModel() -> MCameraSpeed
    {
        let item:MCameraSpeed = speeds[currentSpeed]
        
        return item
    }
}
