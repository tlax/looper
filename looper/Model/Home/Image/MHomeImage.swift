import Foundation
import MetalKit

class MHomeImage
{
    weak var mainSequence:MHomeImageSequenceRaw?
    private var device:MTLDevice?
    private var commandQueue:MTLCommandQueue?
    private var textureLoader:MTKTextureLoader?
    private var generatedSequence:MHomeImageSequenceGenerated?
    private(set) var sequences:[MHomeImageSequenceRaw]
    private let textureOptions:[String:NSObject]
    
    init()
    {
        sequences = []
        textureOptions = [
            MTKTextureLoaderOptionTextureUsage:MTLTextureUsage.shaderRead.rawValue as NSObject,
            MTKTextureLoaderOptionSRGB:true as NSObject
        ]
    }
    
    //MARK: private
    
    private func loadMetal()
    {
        self.device = MTLCreateSystemDefaultDevice()
        
        guard
            
            let device:MTLDevice = self.device
        
        else
        {
            return
        }
        
        self.device = device
        self.commandQueue = device.makeCommandQueue()
        self.textureLoader = MTKTextureLoader(device:device)
    }
    
    private func asyncGenerateSequence()
    {
        if self.textureLoader == nil
        {
            loadMetal()
        }
        
        guard
            
            let textureLoader:MTKTextureLoader = self.textureLoader
        
        else
        {
            return
        }
        
        generatedSequence = MHomeImageSequenceGenerated()
        generatedSequence?.blend(
            textureLoader:textureLoader,
            textureOptions:textureOptions,
            main:mainSequence,
            items:sequences)
    }
    
    //MARK: public
    
    func clear()
    {
        generatedSequence = nil
    }
    
    func add(sequence:MHomeImageSequenceRaw)
    {
        sequences.append(sequence)
        sequence.render()
    }
    
    func generateSequence() -> MHomeImageSequenceGenerated?
    {
        if MSession.sharedInstance.state == MSession.State.rendering
        {
            return nil
        }
        
        guard
        
            let generatedSequence:MHomeImageSequenceGenerated = self.generatedSequence
        
        else
        {
            MSession.sharedInstance.state = MSession.State.rendering
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.asyncGenerateSequence()
            }
            
            return nil
        }
        
        return generatedSequence
    }
}
