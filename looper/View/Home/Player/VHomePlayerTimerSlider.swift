import UIKit

class VHomePlayerTimerSlider:UIView
{
    private weak var controller:CHome!
    var currentTime:TimeInterval
    private let kMinTime:TimeInterval = 0.5
    private let kMaxTime:TimeInterval = 10
    private let kStartTime:TimeInterval = 2
    
    init(controller:CHome)
    {
        currentTime = kStartTime
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
