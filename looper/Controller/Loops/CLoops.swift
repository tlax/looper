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
    
    private func confirmDelete(model:MLoopsItem)
    {
        
        
        loadFromDB()
    }
    
    //MARK: public
    
    func delete(model:MLoopsItem)
    {
        let alert:UIAlertController = UIAlertController(
            title:
            NSLocalizedString("CLoops_alertTitle", comment:""),
            message:nil,
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CLoops_alertCancel", comment:""),
            style:
            UIAlertActionStyle.cancel)
        
        let actionDelete:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CLoops_alertDelete", comment:""),
            style:
            UIAlertActionStyle.destructive)
        { [weak self] (action:UIAlertAction) in
            
            self?.viewLoops.startLoading()
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.confirmDelete(model:model)
            }
        }
        
        alert.addAction(actionDelete)
        alert.addAction(actionCancel)
        present(alert, animated:true, completion:nil)
    }
}
