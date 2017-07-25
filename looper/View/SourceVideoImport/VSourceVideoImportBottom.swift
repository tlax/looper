import UIKit

class VSourceVideoImportBottom:
    View<VSourceVideoImport, MSourceVideoImport, CSourceVideoImport>
{
    required init(controller:CSourceVideoImport)
    {
        super.init(controller:controller)
        
        
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
