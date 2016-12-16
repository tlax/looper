import UIKit

class VHomeControlCameraPreview:UIView
{
    private weak var previewLayer:CALayer?
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let frame:CGRect = layer.frame
        previewLayer?.frame = frame
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func addPreviewLayer(previewLayer:CALayer)
    {
        self.previewLayer = previewLayer
        layer.addSublayer(previewLayer)
    }
}
