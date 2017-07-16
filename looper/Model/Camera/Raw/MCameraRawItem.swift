import UIKit
import AVFoundation

class MCameraRawItem
{
    private let image:UIImage
    private let devicePosition:AVCaptureDevicePosition
    
    init(image:UIImage)
    {
        self.image = image
        devicePosition = AVCaptureDevicePosition.back
    }
    
    init(image:UIImage, devicePosition:AVCaptureDevicePosition)
    {
        self.image = image
        self.devicePosition = devicePosition
    }
    
    //MARK: public
    
    func normalizedImage() -> UIImage
    {
        let image:UIImage
        
        if devicePosition == AVCaptureDevicePosition.front
        {
            guard
                
                let cgImage:CGImage = self.image.cgImage
                
            else
            {
                return self.image
            }
            
            image = UIImage(
                cgImage:cgImage,
                scale:self.image.scale,
                orientation:UIImageOrientation.leftMirrored)
        }
        else
        {
            image = self.image
        }
        
        return image
    }
}
