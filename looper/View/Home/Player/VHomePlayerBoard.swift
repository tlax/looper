import UIKit

class VHomePlayerBoard:UIView
{
    private weak var controller:CHome!
    private weak var buttonMain:VHomePlayerBoardMain!
    
    convenience init(controller:CHome)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let buttonMain:VHomePlayerBoardMain = VHomePlayerBoardMain(
            controller:controller)
        
        addSubview(buttonMain)
    }
}
