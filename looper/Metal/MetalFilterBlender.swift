import MetalPerformanceShaders

class MetalFilterBlender:MetalFilter
{
    private let kIndexBaseTexture:Int = 0
    private let kIndexOverTexture:Int = 1
    private let kIndexMapTexture:Int = 2
    private let kIndexDestinationTexture:Int = 3
    
    //MARK: public
    
    func render(
        overlayTexture:MTLTexture,
        baseTexture:MTLTexture,
        mapTexture:MTLTexture)
    {
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
