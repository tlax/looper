import UIKit

class CLoops:CController
{
    weak var viewLoops:VLoops!
    let model:MLoops

    override init()
    {
        model = MLoops()
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidLoad()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
         
            self?.loadFromDB()
        }
    }
    
    override func loadView()
    {
        let viewLoops:VLoops = VLoops(controller:self)
        self.viewLoops = viewLoops
        view = viewLoops
    }
    
    //MARK: private
    
    private func loadFromDB()
    {
        model.loadFromDb
        {
            DispatchQueue.main.async
            { [weak self] in
            
                self?.loadedFromDB()
            }
        }
    }
    
    private func loadedFromDB()
    {
        viewLoops.loopsLoaded()
    }
}
