import UIKit

protocol MSourceVideoImportFactoryDelegate:class
{
    func importSequenceReady(sequence:MEditSequence)
    func importError()
    func importProgress(percent:CGFloat)
}
