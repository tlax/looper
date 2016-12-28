import UIKit

class MCamera
{
    static let kImageMaxSize:CGFloat = 480
    let speeds:[MCameraSpeed]
    var records:[MCameraRecord]
    var raw:MCameraRaw?
    var currentSpeed:Int
    let kMaxShoots:Int = 300
    private let kDefaultSpeed:Int = 4
    
    init()
    {
        speeds = MCameraSpeed.all()
        records = []
        currentSpeed = kDefaultSpeed
    }
}
