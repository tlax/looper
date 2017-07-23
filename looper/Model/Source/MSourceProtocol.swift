import UIKit

protocol MSourceProtocol
{
    var icon:UIImage { get }
    var title:String { get }
    
    func controller(create:CCreate) -> UIViewController
}
