#include <metal_stdlib>
using namespace metal;

static constant float kMixLevel = 0.5;

kernel void
metalFilter_watermark(texture2d<float, access::read> baseTexture [[texture(0)]],
                    texture2d<float, access::read> overTexture [[texture(1)]],
                    texture2d<float, access::write> destinationTexture [[texture(2)]],
                    uint2 gridId [[thread_position_in_grid]])
{
    float4 basePixel = baseTexture.read(gridId);
    float4 overPixel = overTexture.read(gridId);
    float overAlpha = overPixel[3];
    
    if (overAlpha > 0)
    {
        float4 newPixel = mix(basePixel, overPixel, kMixLevel);
        destinationTexture.write(newPixel, gridId);
    }
    else
    {
        destinationTexture.write(basePixel, gridId);
    }
}
