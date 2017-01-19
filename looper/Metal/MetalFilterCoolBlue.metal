#include <metal_stdlib>
using namespace metal;

kernel void
metalFilter_coolBlue(texture2d<float, access::read> baseTexture [[texture(0)]],
                    texture2d<float, access::read> overTexture [[texture(1)]],
                    texture2d<float, access::read> mapTexture [[texture(2)]],
                    texture2d<float, access::write> destinationTexture [[texture(3)]],
                    uint2 gridId [[thread_position_in_grid]])
{
    float4 basePixel = baseTexture.read(gridId);
    float mapPixel = mapTexture.read(gridId)[0];
    
    if (mapPixel > 0)
    {
        float4 overPixel = overTexture.read(gridId);
        float4 newPixel = mix(basePixel, overPixel, mapPixel);
        destinationTexture.write(newPixel, gridId);
    }
    else
    {
        destinationTexture.write(basePixel, gridId);
    }
}
