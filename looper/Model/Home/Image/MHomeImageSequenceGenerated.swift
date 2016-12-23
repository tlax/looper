import UIKit
import MetalKit

class MHomeImageSequenceGenerated:MHomeImageSequence
{
    //MARK: private
    
    private func loadSequenceTextures(
        sequence:MHomeImageSequenceRaw,
        textureLoader:MTKTextureLoader,
        textureOptions:[String:NSObject])
    {
        for item:MHomeImageSequenceItem in sequence.items
        {
            item.createTexture(
                textureLoader:textureLoader,
                textureOptions:textureOptions)
        }
    }
    
    private func blendFinished()
    {
        MSession.sharedInstance.state = MSession.State.standBy
        NotificationCenter.default.post(
            name:Notification.imagesUpdated,
            object:nil)
    }
    
    //MARK: public
    
    func blend(
        device:MTLDevice,
        mtlFunction:MTLFunction,
        commandQueue:MTLCommandQueue,
        textureLoader:MTKTextureLoader,
        textureOptions:[String:NSObject],
        main:MHomeImageSequenceRaw?,
        sequences:[MHomeImageSequenceRaw])
    {
        var items:[MHomeImageSequenceItem] = []
        
        if let main:MHomeImageSequenceRaw = main
        {
            loadSequenceTextures(
                sequence:main,
                textureLoader:textureLoader,
                textureOptions:textureOptions)
            
            guard
            
                let firstTexture:MTLTexture =  main.items.first?.texture
                
            else
            {
                return
            }
            
            for blendingSequence:MHomeImageSequenceRaw in sequences
            {
                loadSequenceTextures(
                    sequence:blendingSequence,
                    textureLoader:textureLoader,
                    textureOptions:textureOptions)
            }
            
            let totalWidth:Int = firstTexture.width
            let totalHeight:Int = firstTexture.height
            let pixelFormat:MTLPixelFormat = firstTexture.pixelFormat
            
            for mainItem:MHomeImageSequenceItem in main.items
            {
                guard
                    
                    let sourceTexture:MTLTexture = mainItem.texture
                
                else
                {
                    continue
                }
                
                let textureDescriptor:MTLTextureDescriptor = MTLTextureDescriptor.texture2DDescriptor(
                    pixelFormat:pixelFormat,
                    width:totalWidth,
                    height:totalHeight,
                    mipmapped:false)
                
                let destinationTexture:MTLTexture = device.makeTexture(
                    descriptor:textureDescriptor)
                
                let metalFilter:MetalFilter = MetalFilter(device:device)
                metalFilter.mtlFunction = mtlFunction
                
                let commandBuffer:MTLCommandBuffer = commandQueue.makeCommandBuffer()
                metalFilter.encode(
                    commandBuffer:commandBuffer,
                    sourceTexture:sourceTexture,
                    destinationTexture:destinationTexture)
                commandBuffer.commit()
                commandBuffer.waitUntilCompleted()
                
                guard
                    
                let newImage:UIImage = destinationTexture.exportImage()
                    
                    else
                {
                    return
                }
                
                let newItem:MHomeImageSequenceItem = MHomeImageSequenceItem(image:newImage)
                items.append(newItem)
            }
        }
        else
        {
            
        }
        
        
        self.items = items
        
        self.blendFinished()
    }
}
