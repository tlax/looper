import UIKit

class CHome:CController
{
    weak var viewHome:VHome!
    let modelImage:MHomeImage
    
    override init()
    {
        modelImage = MHomeImage()
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewHome:VHome = VHome(controller:self)
        self.viewHome = viewHome
        view = viewHome
    }
    
    //MARK: private
    
    private func asyncAnimate()
    {
        guard
            
            let modelGenerated:MHomeImageSequenceGenerated = modelImage.generateSequence()
            
        else
        {
            return
        }
        
        var images:[UIImage] = []
        
        for itemGenerated:MHomeImageSequenceItem in modelGenerated.items
        {
            let image:UIImage = itemGenerated.image
            images.append(image)
        }
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewHome.viewDisplay.animateImages(images:images)
            MSession.sharedInstance.state = MSession.State.playing
        }
    }
    
    //MARK: public
    
    func animate()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncAnimate()
        }
    }
    
    func stopAnimation()
    {
        viewHome.viewDisplay.stopAnimation()
        MSession.sharedInstance.state = MSession.State.standBy
    }
}
