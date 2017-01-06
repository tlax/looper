import MetalPerformanceShaders

class MetalFilter:MPSUnaryImageKernel
{
    let pipeline:MTLComputePipelineState
    let commandEncoder:MTLComputeCommandEncoder
    let threadgroupCounts:MTLSize
    let threadgroups:MTLSize
    private let kThreadgroupWidth:Int = 8
    private let kThreadgroupHeight:Int = 8
    private let kThreadgroupDeep:Int = 1
    
    init?(
        device:MTLDevice,
        mtlFunction:MTLFunction,
        commandBuffer:MTLCommandBuffer,
        width:Int,
        height:Int)
    {
        let pipeline:MTLComputePipelineState
        
        do
        {
            try pipeline = device.makeComputePipelineState(function:mtlFunction)
        }
        catch
        {
            return nil
        }
        
        commandEncoder = commandBuffer.makeComputeCommandEncoder()
        let threadgroupsHorizontal:Int = width / kThreadgroupWidth
        let threadgroupsVertical:Int = height / kThreadgroupHeight
        threadgroupCounts = MTLSizeMake(
            kThreadgroupWidth,
            kThreadgroupHeight,
            kThreadgroupDeep)
        threadgroups = MTLSizeMake(
            threadgroupsHorizontal,
            threadgroupsVertical,
            kThreadgroupDeep)
        
        self.pipeline = pipeline
        super.init(device:device)
    }
}
