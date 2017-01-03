import UIKit

class CLoops:CController
{
    weak var viewLoops:VLoops!
    let model:mloo

    override func loadView()
    {
        let viewLoops:VLoops = VLoops(controller:self)
        self.viewLoops = viewLoops
        view = viewLoops
    }
}
