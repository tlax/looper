import UIKit
import MetalKit

class MHomeImageSequenceGenerated:MHomeImageSequence
{
    private weak var device:MTLDevice!
    private weak var commandQueue:MTLCommandQueue!
    private weak var mtlFunction:MTLFunction!
    private weak var textureLoader:MTKTextureLoader!
    private let kMapTexturePixelFormat:MTLPixelFormat = MTLPixelFormat.r32Float
    private let kTextureMipMapped:Bool = false
    private let kTextureDepth:Int = 1
    private let kRepeatingElement:Float = 0
    
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
    
    private func mapTexture(texture:MTLTexture, point:MHomeImageSequenceRawPoint)
    {
        let textureWidth:Int = texture.width
        let textureHeight:Int = texture.height
        let textureWidthFloat:CGFloat = CGFloat(textureWidth)
        let textureHeightFloat:CGFloat = CGFloat(textureHeight)
        let maxWidth:Int = textureWidth - 1
        let maxHeight:Int = textureHeight - 1
        let textureMatrixSize:Int = textureWidth * textureHeight
        let sizeOfFloat:Int = MemoryLayout.size(ofValue:kRepeatingElement)
        var textureArray:[Float] = Array(
            repeating:kRepeatingElement,
            count:textureMatrixSize)
        let bytesPerRow:Int = sizeOfFloat * textureWidth
        let region:MTLRegion = MTLRegionMake2D(
            0,
            0,
            textureWidth,
            textureHeight)
        
        let mapTexture:MTLTexture = newCanvasTexure(
            pixelFormat:kMapTexturePixelFormat,
            width:textureWidth,
            height:textureHeight)
        
        let overPosX:Int = Int(ceil(
            textureWidthFloat * point.percentPosX))
        let overPosY:Int = Int(ceil(
            textureHeightFloat * point.percentPosY))
        
        
        
        let features:[CIFeature] = detector.features(in:image)
        let faceRadius:Int = bokehSize * sizeRatio
        let faceRadiusFloat:Float = Float(faceRadius)
        
        for feature:CIFeature in features
        {
            if let faceFeature:CIFaceFeature = feature as? CIFaceFeature
            {
                let faceFeatureX:Int = Int(faceFeature.bounds.origin.x)
                let faceFeatureW:Int = Int(faceFeature.bounds.size.width)
                let faceFeatureH:Int = Int(faceFeature.bounds.size.height)
                let faceFeatureY:Int = sourceHeight - (Int(faceFeature.bounds.origin.y) + faceFeatureH)
                let faceFeatureMaxX:Int = faceFeatureX + faceFeatureW
                let faceFeatureMaxY:Int = faceFeatureY + faceFeatureH
                let faceFeatureW_2:Int = Int(round(Float(faceFeatureW) / 2.0))
                let faceFeatureH_2:Int = Int(round(Float(faceFeatureH) / 2.0))
                let faceFeatureCenterX:Int = faceFeatureX + faceFeatureW_2
                let faceFeatureCenterY:Int = faceFeatureY + faceFeatureH_2
                let faceFeatureRadius:Int = min(faceFeatureW_2, faceFeatureH_2)
                
                var minX:Int = faceFeatureX - faceRadius
                var maxX:Int = faceFeatureMaxX + faceRadius
                var minY:Int = faceFeatureY - faceRadius
                var maxY:Int = faceFeatureMaxY + faceRadius
                
                if minX < 0
                {
                    minX = 0
                }
                
                if maxX > maxWidth
                {
                    maxX = maxWidth
                }
                
                if minY < 0
                {
                    minY = 0
                }
                
                if maxY > maxHeight
                {
                    maxY = maxHeight
                }
                
                for indexVr:Int in minY ..< maxY
                {
                    let deltaY:Int = indexVr - faceFeatureCenterY
                    let deltaY2:Int = deltaY * deltaY
                    let currentRow:Int = sourceWidth * indexVr
                    
                    for indexHr:Int in minX ..< maxX
                    {
                        let pixelIndex:Int = currentRow + indexHr
                        let currentWeight:Float = textureArray[pixelIndex]
                        
                        if currentWeight > 0
                        {
                            let deltaX:Int = indexHr - faceFeatureCenterX
                            let deltaX2:Int = deltaX * deltaX
                            let deltaSum:Int = deltaX2 + deltaY2
                            let hyp:Int = Int(sqrt(Float(deltaSum)))
                            let deltaRadius:Int = hyp - faceFeatureRadius
                            let pixelWeight:Float
                            
                            if deltaRadius > faceRadius
                            {
                                pixelWeight = 1
                            }
                            else if deltaRadius > 0
                            {
                                let deltaRadiusFloat:Float = Float(deltaRadius)
                                pixelWeight = deltaRadiusFloat / faceRadiusFloat
                            }
                            else
                            {
                                pixelWeight = 0
                            }
                            
                            if pixelWeight < currentWeight
                            {
                                textureArray[pixelIndex] = pixelWeight
                            }
                        }
                    }
                }
            }
        }
        
        let bytes:UnsafeRawPointer = UnsafeRawPointer(textureArray)
        facesTexture.replace(
            region:region,
            mipmapLevel:0,
            withBytes:bytes,
            bytesPerRow:bytesPerRow)
        
        commandEncoder.setTexture(facesTexture, at:kFacesTextureIndex)
        commandEncoder.setTexture(destinationTexture, at:kBokehTextureIndex)
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
