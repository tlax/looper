import Foundation
import MetalKit

class MHomeImage
{
    weak var mainSequence:MHomeImageSequenceRaw?
    private var device:MTLDevice?
    private var mtlFunction:MTLFunction?
    private var commandQueue:MTLCommandQueue?
    private var commandBuffer:MTLCommandBuffer?
    private var textureLoader:MTKTextureLoader?
    private var generatedSequence:MHomeImageSequenceGenerated?
    private(set) var longestSequence:Int
    private(set) var sequences:[MHomeImageSequenceRaw]
    private let kMetalFunctionName:String = "metalFilter_blender"
    
    init()
    {
        longestSequence = 0
        sequences = []
    }
    
    //MARK: private
    
    private func loadMetal()
    {
        self.device = MTLCreateSystemDefaultDevice()
        
        guard
            
            let device:MTLDevice = self.device,
            let mtlLibrary:MTLLibrary = device.newDefaultLibrary(),
            let mtlFunction:MTLFunction = mtlLibrary.makeFunction(name:kMetalFunctionName)
        
        else
        {
            return
        }
        
        commandQueue = device.makeCommandQueue()
        commandBuffer = commandQueue!.makeCommandBuffer()
        textureLoader = MTKTextureLoader(device:device)
        self.device = device
        self.mtlFunction = mtlFunction
    }
    
    private func asyncGenerateSequence()
    {
        if self.textureLoader == nil
        {
            loadMetal()
        }
        
        guard
            
            let device:MTLDevice = self.device,
            let commandQueue:MTLCommandQueue = self.commandQueue,
            let textureLoader:MTKTextureLoader = self.textureLoader,
            let mtlFunction:MTLFunction = self.mtlFunction
        
        else
        {
            return
        }
        
        generatedSequence = MHomeImageSequenceGenerated()
        generatedSequence?.blend(
            longestSequence:longestSequence,
            device:device,
            mtlFunction:mtlFunction,
            commandQueue:commandQueue,
            textureLoader:textureLoader,
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
        let sequenceLength:Int = sequence.items.count
        
        if sequenceLength > longestSequence
        {
            longestSequence = sequenceLength
        }
        
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
