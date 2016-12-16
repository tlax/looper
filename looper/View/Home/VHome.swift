import UIKit

class VHome:VView
{
    weak var viewControl:VHomeControl!
    weak var viewTimeline:VHomeTimeline!
    weak var viewDisplay:VHomeDisplay!
    private weak var controller:CHome!
    private weak var layoutControlHeight:NSLayoutConstraint!
    private let kControlMinHeight:CGFloat = 64
    private let kTimelineHeight:CGFloat = 80
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CHome
        
        let viewControl:VHomeControl = VHomeControl(controller:self.controller)
        self.viewControl = viewControl
        
        let viewTimeline:VHomeTimeline = VHomeTimeline(controller:self.controller)
        self.viewTimeline = viewTimeline
        
        let viewDisplay:VHomeDisplay = VHomeDisplay(controller:self.controller)
        self.viewDisplay = viewDisplay
        
        addSubview(viewDisplay)
        addSubview(viewTimeline)
        addSubview(viewControl)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
