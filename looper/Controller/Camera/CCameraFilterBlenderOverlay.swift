import UIKit

class CCameraFilterBlenderOverlay:CController
{
    weak var viewOverlay:VCameraFilterBlenderOverlay!
    weak var baseRecord:MCameraRecord?
    private weak var model:MCameraFilterItemBlend!
    
    init(model:MCameraFilterItemBlend, baseRecord:MCameraRecord?)
    {
        self.model = model
        self.baseRecord = baseRecord
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        viewOverlay.stopLoading()
    }
    
    override func loadView()
    {
        let viewOverlay:VCameraFilterBlenderOverlay = VCameraFilterBlenderOverlay(
            controller:self)
        self.viewOverlay = viewOverlay
        view = viewOverlay
    }
    
    //MARK: private
    
    private func filterFinished(record:MCameraRecord)
    {
        let controllerCompress:CCameraCompress = CCameraCompress(
            model:record)
        parentController.push(
            controller:controllerCompress,
            horizontal:
            CParent.TransitionHorizontal.fromRight)
    }
    
    private func filter()
    {
        let frameBase:CGRect = viewOverlay.viewBase.frame
        let basePosX:CGFloat = frameBase.origin.x
        let basePosY:CGFloat = frameBase.origin.y
        let baseWidth:CGFloat = frameBase.size.width
        var overlays:[MCameraFilterItemBlendOverlay] = []
        
        for placerSubview:UIView in viewOverlay.viewPlacer.subviews
        {
            guard
            
                let viewPiece:VCameraFilterBlenderOverlayPiece = placerSubview as? VCameraFilterBlenderOverlayPiece
            else
            {
                continue
            }
            
            if viewPiece.intersecting
            {
                let record:MCameraRecord = viewPiece.model
                let framePiece:CGRect = viewPiece.frame
                let piecePosX:CGFloat = framePiece.origin.x
                let piecePosY:CGFloat = framePiece.origin.y
                let pieceWidth:CGFloat = framePiece.size.width
                let respectivePosX:CGFloat = piecePosX - basePosX
                let respectivePosY:CGFloat = piecePosY - basePosY
                let percentPosX:CGFloat = respectivePosX / baseWidth
                let percentPosY:CGFloat = respectivePosY / baseWidth
                let percentSize:CGFloat = pieceWidth / baseWidth
                
                let modelOverlay:MCameraFilterItemBlendOverlay = MCameraFilterItemBlendOverlay(
                    record:record,
                    percentPosX:percentPosX,
                    percentPosY:percentPosY,
                    percentSize:percentSize)
                
                overlays.append(modelOverlay)
            }
        }
        
        let filteredRecord:MCameraRecord = model.filter(
            baseRecord:baseRecord,
            overlays:overlays)
        let waterMarked:MCameraRecord = model.waterMark(
            original:filteredRecord)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.filterFinished(record:waterMarked)
        }
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func next()
    {
        viewOverlay.startLoading()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.filter()
        }
    }
}
