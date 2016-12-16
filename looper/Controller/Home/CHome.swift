import UIKit

class CHome:CController
{
    private weak var viewHome:VHome!
    
    override func loadView()
    {
        let viewHome:VHome = VHome(controller:self)
        self.viewHome = viewHome
        view = viewHome
    }
    
    //MARK: public
    
    func showCamera()
    {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:
            ^(BOOL granted)
            {
            if(granted)
            {
            dispatch_async(queue,
            ^
            {
            [self startsession];
            });
            }
            else
            {
            [[NSNotificationCenter defaultCenter] postNotificationName:notwritingfree object:nil];
            [[analytics singleton] trackevent:ga_event_shoot action:ga_action_error label:NSLocalizedString(@"error_notauthorized", nil)];
            [valert alert:NSLocalizedString(@"error_notauthorized", nil) inview:self.view];
            }
            }];
    }
}
