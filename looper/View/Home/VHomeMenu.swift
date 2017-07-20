import UIKit

class VHomeMenu:View<VHome, MHome, CHome>
{
    required init(controller:CHome)
    {
        super.init(controller:controller)
        
        
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
