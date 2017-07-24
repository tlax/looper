import UIKit

protocol MSourceProtocol
{
    var icon:UIImage { get }
    var title:String { get }
    var controller:UIViewController.Type { get }
}
