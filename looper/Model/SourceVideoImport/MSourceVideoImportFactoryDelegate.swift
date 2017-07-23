import UIKit

protocol MSourceVideoImportFactoryDelegate:class
{
    func importImagesReady(images:[CGImage])
    func importError()
}
