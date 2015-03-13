texture PixelShadTexture; 

sampler screenSampler = sampler_state
{
 Texture = <PixelShadTexture>;
};

float4 main(float2 uv : TEXCOORD0) : COLOR0 
{ 
    float4 Color; 
    float4 Color2; 
    float4 Color3; 
    Color = tex2D( screenSampler , uv.xy);
    Color2 = Color;
    Color3 = Color;
    Color -= tex2D( screenSampler, uv.xy+0.0004)*14.0f;
    Color += tex2D( screenSampler, uv.xy-0.0004)*14.0f;
    Color2 += tex2D( screenSampler, uv.xy+0.0004)*14.0f;
    Color2 -= tex2D( screenSampler, uv.xy-0.0004)*14.0f;
    if (Color.r <= 0.03 && Color.g <= 0.03 && Color.b <= 0.03) {
	return (Color); 
    }
    else if (Color2.r <= 0.03 && Color2.g <= 0.03 && Color2.b <= 0.03) {
	return (Color2); 
    }
    else{
	return Color3*1.5;
    }
};

technique PixelShad
{
 pass P1
 {
  PixelShader = compile ps_2_0 main();
 }
}