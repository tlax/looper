import UIKit

class CLoops:CController
{
    weak var viewLoops:VLoops!
    let model:MLoops

    override init()
    {
        model = MLoops()
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewLoops:VLoops = VLoops(controller:self)
        self.viewLoops = viewLoops
        view = viewLoops
    }
}
