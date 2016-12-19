import UIKit

class CHome:CController
{
    enum State
    {
        case standBy
        case rendering
        case frame
        case playing
    }
    
    weak var viewHome:VHome!
    let modelImage:MHomeImage
    var state:State
    
    override init()
    {
        modelImage = MHomeImage()
        state = State.standBy
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewHome:VHome = VHome(controller:self)
        self.viewHome = viewHome
        view = viewHome
    }
}
