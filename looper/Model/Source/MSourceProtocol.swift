import UIKit

protocol MSourceProtocol
{
    var icon:UIImage { get }
    var title:String { get }
    
    func controller(controllerCreate:CCreate) -> UIViewController
}
