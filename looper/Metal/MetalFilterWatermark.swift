import MetalPerformanceShaders

class MetalFilterWatermark:MetalFilter
{
    private let kIndexBaseTexture:Int = 0
    private let kIndexOverTexture:Int = 1
    private let kIndexDestinationTexture:Int = 2
    
    //MARK: public
    
    func render(
        overlayTexture:MTLTexture,
        baseTexture:MTLTexture)
    {
        commandEncoder.setComputePipelineState(pipeline)
        commandEncoder.setTexture(baseTexture, at:kIndexBaseTexture)
        commandEncoder.setTexture(overlayTexture, at:kIndexOverTexture)
        commandEncoder.setTexture(baseTexture, at:kIndexDestinationTexture)
        
        commandEncoder.dispatchThreadgroups(
            threadgroups,
            threadsPerThreadgroup:threadgroupCounts)
        commandEncoder.endEncoding()
    }
}
