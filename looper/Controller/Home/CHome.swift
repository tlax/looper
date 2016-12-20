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
    
    //MARK: public
    
    func animate()
    {
        guard
            
            let modelGenerated:MHomeImageSequenceGenerated = modelImage.generateSequence()
        
        else
        {
            return
        }
        
        var images:[UIImage] = []
        
        
        
        MSession.sharedInstance.state = MSession.State.playing
    }
    
    func stopAnimation()
    {
        MSession.sharedInstance.state = MSession.State.standBy
    }
}
