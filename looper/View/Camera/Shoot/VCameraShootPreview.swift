import UIKit

class VCameraShootPreview:UIView
{
    private weak var previewLayer:CALayer?
    private let kDeltaHeight:CGFloat = 0.5625
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = UIViewContentMode.scaleAspectFill
    }
    
    deinit
    {
        previewLayer?.removeFromSuperlayer()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxY
        let expectedHeight:CGFloat = width / kDeltaHeight
        let overflowHeight:CGFloat = expectedHeight - width
        let marginTop:CGFloat = overflowHeight / -2.0
        let previewFrame:CGRect = CGRect(
            x:0,
            y:marginTop,
            width:width,
            height:expectedHeight)
        previewLayer?.frame = previewFrame
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func addPreviewLayer(previewLayer:CALayer)
    {
        self.previewLayer = previewLayer
        layer.addSublayer(previewLayer)
    }
}
