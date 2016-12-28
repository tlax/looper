import UIKit
import AVFoundation

class MCameraRawItem
{
    let image:UIImage
    let devicePosition:AVCaptureDevicePosition
    
    init(image:UIImage, devicePosition:AVCaptureDevicePosition)
    {
        self.image = image
        self.devicePosition = devicePosition
    }
}
