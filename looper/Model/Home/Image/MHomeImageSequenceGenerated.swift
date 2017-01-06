import UIKit
import MetalKit

class MHomeImageSequenceGenerated:MHomeImageSequence
{
    private weak var device:MTLDevice!
    private let commandQueue:MTLCommandQueue
    private let mtlFunction:MTLFunction
    private let textureLoader:MTKTextureLoader
    private let length:Int
    private let kMetalFunctionName:String = "metalFilter_blender"
    private let kMapTexturePixelFormat:MTLPixelFormat = MTLPixelFormat.r32Float
    private let kTextureDefaultPixelFormat:MTLPixelFormat = MTLPixelFormat.bgra8Unorm
    private let kTextureDefaultSize:Int = 600
    private let kTextureMipMapped:Bool = false
    private let kTextureDepth:Int = 1
    private let kRepeatingElement:Float = 0
    private let kReplaceElement:Float = 1
    
    init?(
        device:MTLDevice,
        main:MHomeImageSequenceRaw?,
        sequences:[MHomeImageSequenceRaw],
        length:Int)
    {
        self.device = device
        self.length = length
        
        guard
            
            let mtlLibrary:MTLLibrary = device.newDefaultLibrary(),
            let mtlFunction:MTLFunction = mtlLibrary.makeFunction(name:kMetalFunctionName)
        
        else
        {
            return nil
        }
        
        self.mtlFunction = mtlFunction
        commandQueue = device.makeCommandQueue()
        textureLoader = MTKTextureLoader(device:device)
        
        super.init()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.render(main:main, sequences:sequences)
        }
    }
    
    override init()
    {
        fatalError()
    }
    
    override init(items:[MHomeImageSequenceItem])
    {
        fatalError()
    }
    
    //MARK: private
    
    private func render(
        main:MHomeImageSequenceRaw?,
        sequences:[MHomeImageSequenceRaw])
    {
        if let main:MHomeImageSequenceRaw = main
        {
            blendOverMain(main:main, sequences:sequences)
        }
        else if sequences.isEmpty
        {
            blendFinished()
        }
        else
        {
            blendOverBlank(sequences:sequences)
        }
    }
    
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
    
    private func mapTexture(
        texture:MTLTexture,
        point:MHomeImageSequenceRawPoint) -> MTLTexture
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
        let overRadius:Int = Int(textureWidthFloat * point.percentRadius)
        
        var minX:Int = overPosX - overRadius
        var maxX:Int = overPosX + overRadius
        var minY:Int = overPosY - overRadius
        var maxY:Int = overPosY + overRadius
        
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
            let currentRow:Int = textureWidth * indexVr
            
            for indexHr:Int in minX ..< maxX
            {
                let pixelIndex:Int = currentRow + indexHr
                textureArray[pixelIndex] = kReplaceElement
            }
        }
        
        let bytes:UnsafeRawPointer = UnsafeRawPointer(textureArray)
        mapTexture.replace(
            region:region,
            mipmapLevel:0,
            withBytes:bytes,
            bytesPerRow:bytesPerRow)
        
        return mapTexture
    }
    
    private func blendOverTexture(
        baseTexture:MTLTexture,
        index:Int,
        sequences:[MHomeImageSequenceRaw])
    {
        let baseWidth:CGFloat = CGFloat(baseTexture.width)
        let baseHeight:CGFloat = CGFloat(baseTexture.height)
        
        for sequence:MHomeImageSequenceRaw in sequences
        {
            let countSequenceItem:Int = sequence.items.count
            
            if countSequenceItem > index
            {
                guard
                    
                    let point:MHomeImageSequenceRawPoint = sequence.point
                    
                else
                {
                    continue
                }
                
                if point.mapTexture == nil
                {
                    point.mapTexture = mapTexture(
                        texture:baseTexture,
                        point:point)
                }
                
                let sequenceItem:MHomeImageSequenceItem = sequence.items[index]
                
                guard
                    
                    let overTexture:MTLTexture = sequenceItem.createTexture(
                        point:point,
                        textureWidth:baseWidth,
                        textureHeight:baseHeight,
                        textureLoader:textureLoader),
                    let mapTexture:MTLTexture = point.mapTexture
                    
                else
                {
                    continue
                }
                /*
                let commandBuffer:MTLCommandBuffer = commandQueue.makeCommandBuffer()
                let metalFilter:MetalFilterBlender = MetalFilterBlender(device:device)
                metalFilter.render(
                    mtlFunction:mtlFunction,
                    commandBuffer:commandBuffer,
                    overlayTexture:overTexture,
                    baseTexture:baseTexture,
                    mapTexture:mapTexture)
                
                commandBuffer.commit()
                commandBuffer.waitUntilCompleted()*/
            }
        }
        
        guard
            
            let textureImage:UIImage = baseTexture.exportImage()
            
        else
        {
            return
        }
        
        let finalItem:MHomeImageSequenceItem = MHomeImageSequenceItem(
            image:textureImage)
        items.append(finalItem)
    }
    
    private func blendOverMain(
        main:MHomeImageSequenceRaw,
        sequences:[MHomeImageSequenceRaw])
    {
        let countMainItems:Int = main.items.count
        
        for indexMainItem:Int in 0 ..< countMainItems
        {
            let mainItem:MHomeImageSequenceItem = main.items[indexMainItem]
            
            guard
                
                let mainItemTexture:MTLTexture = mainItem.createTexture(
                    textureLoader:textureLoader)
            
            else
            {
                continue
            }
            
            let baseTexture:MTLTexture = createBaseTexture(texture:mainItemTexture)
            blendOverTexture(
                baseTexture:baseTexture,
                index:indexMainItem,
                sequences:sequences)
        }
        
        blendFinished()
    }
    
    private func blendOverBlank(sequences:[MHomeImageSequenceRaw])
    {
        for indexItem:Int in 0 ..< length
        {
            let canvasTexture:MTLTexture = newCanvasTexure(
                pixelFormat:kTextureDefaultPixelFormat,
                width:kTextureDefaultSize,
                height:kTextureDefaultSize)
            let baseTexture:MTLTexture = createBaseTexture(texture:canvasTexture)
            
            blendOverTexture(
                baseTexture:baseTexture,
                index:indexItem,
                sequences:sequences)
        }
        
        blendFinished()
    }
}
