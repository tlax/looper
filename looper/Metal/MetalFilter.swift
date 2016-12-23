import MetalPerformanceShaders

class MetalFilter:MPSUnaryImageKernel
{
    weak var mtlFunction:MTLFunction!
    private let kThreadgroupWidth:Int = 8
    private let kThreadgroupHeight:Int = 8
    private let kThreadgroupDeep:Int = 1
    private let kIndexBaseTexture:Int = 0
    private let kIndexOverTexture:Int = 1
    private let kIndexMapTexture:Int = 2
    private let kIndexDestinationTexture:Int = 3
    
    //MARK: public
    
    func render(
        mtlFunction:MTLFunction,
        commandBuffer:MTLCommandBuffer,
        overlayTexture:MTLTexture,
        baseTexture:MTLTexture,
        mapTexture:MTLTexture)
    {
        let tryPipeline:MTLComputePipelineState?
        
        do
        {
            try tryPipeline = device.makeComputePipelineState(function:mtlFunction)
        }
        catch
        {
            tryPipeline = nil
        }
        
        guard
            
            let pipeline:MTLComputePipelineState = tryPipeline
        
        else
        {
            return
        }
        
        let threadgroupsHorizontal:Int = baseTexture.width / kThreadgroupWidth
        let threadgroupsVertical:Int = baseTexture.height / kThreadgroupHeight
        let threadgroupCounts:MTLSize = MTLSizeMake(
            kThreadgroupWidth,
            kThreadgroupHeight,
            kThreadgroupDeep)
        let threadgroups:MTLSize = MTLSizeMake(
            threadgroupsHorizontal,
            threadgroupsVertical,
            kThreadgroupDeep)
        
        let commandEncoder:MTLComputeCommandEncoder = commandBuffer.makeComputeCommandEncoder()
        commandEncoder.setComputePipelineState(pipeline)
        commandEncoder.setTexture(baseTexture, at:kIndexBaseTexture)
        commandEncoder.setTexture(overlayTexture, at:kIndexOverTexture)
        commandEncoder.setTexture(mapTexture, at:kIndexMapTexture)
        commandEncoder.setTexture(baseTexture, at:kIndexDestinationTexture)
        
        commandEncoder.dispatchThreadgroups(
            threadgroups,
            threadsPerThreadgroup:threadgroupCounts)
        commandEncoder.endEncoding()
    }
}
