import UIKit

protocol MEditActionProtocol
{
    var image:UIImage { get }
    
    func selected(edit:MEdit) -> UIViewController
}
