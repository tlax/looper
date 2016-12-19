import Foundation

class MSession
{
    enum State
    {
        case standBy
        case rendering
        case frame
        case playing
    }
    
    static let sharedInstance:MSession = MSession()
    var state:State
    
    private init()
    {
        state = State.standBy
    }
}
