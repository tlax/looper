import UIKit
import MetalKit

class MHomeImageSequenceGenerated:MHomeImageSequence
{
    private weak var device:MTLDevice!
    private weak var commandQueue:MTLCommandQueue!
    private weak var mtlFunction:MTLFunction!
    private weak var textureLoader:MTKTextureLoader!
    private let kTextureMipMapped:Bool = false
    private let kTextureDepth:Int = 1
    
    //MARK: private
    
    private func blendFinished()
    {
        MSession.sharedInstance.state = MSession.State.standBy
        NotificationCenter.default.post(
            name:Notification.imagesUpdated,
            object:nil)
    }
    
    private func newCanvasTexure(
        pixelFormat:MTLPixelFormat,
        width:Int,
        height:Int) -> MTLTexture
    {
        let textureDescriptor:MTLTextureDescriptor = MTLTextureDescriptor.texture2DDescriptor(
            pixelFormat:pixelFormat,
            width:width,
            height:height,
            mipmapped:kTextureMipMapped)
        
        let newTexture:MTLTexture = device.makeTexture(
            descriptor:textureDescriptor)
        
        return newTexture
    }
    
    private func createBaseTexture(texture:MTLTexture) -> MTLTexture
    {
        let baseTexture:MTLTexture = newCanvasTexure(
            pixelFormat:texture.pixelFormat,
            width:texture.width,
            height:texture.height)
        
        let textureBuffer:MTLCommandBuffer = commandQueue.makeCommandBuffer()
        let size:MTLSize = MTLSizeMake(
            texture.width,
            texture.height,
            kTextureDepth)
        let blitEncoder:MTLBlitCommandEncoder = textureBuffer.makeBlitCommandEncoder()
        
        blitEncoder.copy(
            from:texture,
            sourceSlice:0,
            sourceLevel:0,
            sourceOrigin:MTLOriginMake(0, 0, 0),
            sourceSize:size,
            to:baseTexture,
            destinationSlice:0,
            destinationLevel:0,
            destinationOrigin:MTLOriginMake(0, 0, 0))
        blitEncoder.endEncoding()
        
        textureBuffer.commit()
        textureBuffer.waitUntilCompleted()
        
        return baseTexture
    }
    
    private func blendOverMain(
        main:MHomeImageSequenceRaw,
        sequences:[MHomeImageSequenceRaw])
    {
        let countMainItems:Int = main.items.count
        
        for indexMainItem:Int in 0 ..< countMainItems
        {
            let mainItem:MHomeImageSequenceItem = main.items[indexMainItem]
            mainItem.createTexture(textureLoader:textureLoader)
            
            guard
                
                let mainItemTexture:MTLTexture = mainItem.texture
            
            else
            {
                continue
            }
            
            let baseTexture:MTLTexture = createBaseTexture(texture:mainItemTexture)
            
            for sequence:MHomeImageSequenceRaw in sequences
            {
                let countSequenceItem:Int = sequence.items.count
                
                if countSequenceItem > indexMainItem
                {
                    let sequenceItem:MHomeImageSequenceItem = sequence.items[indexMainItem]
                    sequenceItem.createTexture(textureLoader:textureLoader)
                    
                    guard
                        
                        let overTexture:MTLTexture = sequenceItem.texture
                    
                    else
                    {
                        continue
                    }
                    
                    let metalFilter:MetalFilter = MetalFilter(device:device)
                    metalFilter.mtlFunction = mtlFunction
                    
                    let commandBuffer:MTLCommandBuffer = commandQueue.makeCommandBuffer()
                    metalFilter.encode(
                        commandBuffer:commandBuffer,
                        sourceTexture:overTexture,
                        destinationTexture:baseTexture)
                    commandBuffer.commit()
                    commandBuffer.waitUntilCompleted()
                }
            }
            
            guard
                
                let textureImage:UIImage = baseTexture.exportImage()
                
            else
            {
                continue
            }
            
            let finalItem:MHomeImageSequenceItem = MHomeImageSequenceItem(
                image:textureImage)
            items.append(finalItem)
        }
        
        blendFinished()
    }
    
    //MARK: public
    
    func blend(
        device:MTLDevice,
        mtlFunction:MTLFunction,
        commandQueue:MTLCommandQueue,
        textureLoader:MTKTextureLoader,
        main:MHomeImageSequenceRaw?,
        sequences:[MHomeImageSequenceRaw])
    {
        self.device = device
        self.commandQueue = commandQueue
        self.mtlFunction = mtlFunction
        self.textureLoader = textureLoader
        
        if let main:MHomeImageSequenceRaw = main
        {
            blendOverMain(main:main, sequences:sequences)
            
            /*
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
                    textureLoader:textureLoader)
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
            
            */
        }
        else
        {
            
        }
        
        self.blendFinished()
    }
}
