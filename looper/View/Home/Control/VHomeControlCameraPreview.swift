import UIKit

class VHomeControlCameraPreview:UIView
{
    private weak var previewLayer:CALayer?
    private let kDeltaHeight:CGFloat = 0.75
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = UIViewContentMode.scaleAspectFill
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxY
        let expectedHeight:CGFloat = width * kDeltaHeight
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
