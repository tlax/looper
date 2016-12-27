import UIKit

class CLoops:CController
{
    weak var viewLoops:VLoops!

    override func loadView()
    {
        let viewLoops:VLoops = VLoops(controller:self)
        self.viewLoops = viewLoops
        view = viewLoops
    }
}
