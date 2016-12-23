import Foundation
import MetalKit

class MHomeImage
{
    weak var mainSequence:MHomeImageSequenceRaw?
    private var device:MTLDevice?
    private var commandQueue:MTLCommandQueue?
    private var commandBuffer:MTLCommandBuffer?
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
        
        commandQueue = device.makeCommandQueue()
        commandBuffer = commandQueue!.makeCommandBuffer()
        textureLoader = MTKTextureLoader(device:device)
        self.device = device
    }
    
    private func asyncGenerateSequence()
    {
        if self.textureLoader == nil
        {
            loadMetal()
        }
        
        guard
            
            let device:MTLDevice = self.device,
            let commandBuffer:MTLCommandBuffer = self.commandBuffer,
            let textureLoader:MTKTextureLoader = self.textureLoader
        
        else
        {
            return
        }
        
        generatedSequence = MHomeImageSequenceGenerated()
        generatedSequence?.blend(
            device:device,
            commandBuffer:commandBuffer,
            textureLoader:textureLoader,
            textureOptions:textureOptions,
            main:mainSequence,
            sequences:sequences)
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
        var generatedSequence:MHomeImageSequenceGenerated?
        
        if !sequences.isEmpty
        {
            if MSession.sharedInstance.state != MSession.State.rendering
            {
                generatedSequence = self.generatedSequence
                
                if generatedSequence == nil
                {
                    MSession.sharedInstance.state = MSession.State.rendering
                    
                    DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
                    { [weak self] in
                        
                        self?.asyncGenerateSequence()
                    }
                }
            }
        }
        
        return generatedSequence
    }
}
