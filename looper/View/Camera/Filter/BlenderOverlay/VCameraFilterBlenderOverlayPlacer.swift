import UIKit

class VCameraFilterBlenderOverlayPlacer:UIView
{
    private weak var controller:CCameraFilterBlenderOverlay!
    private var pieces:[VCameraFilterBlenderOverlayPiece]
    
    init(controller:CCameraFilterBlenderOverlay)
    {
        pieces = []
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func addPiece(viewPiece:VCameraFilterBlenderOverlayPiece)
    {
        pieces.append(viewPiece)
        addSubview(viewPiece)
        
        addConstraints([
            viewPiece.layoutTop,
            viewPiece.layoutHeight,
            viewPiece.layoutLeft,
            viewPiece.layoutWidth])
        
        viewPiece.animateShow()
    }
}
