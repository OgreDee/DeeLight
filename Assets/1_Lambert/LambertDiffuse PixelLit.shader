// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

//兰伯特光照模型，计算漫反射，diffuse = I*cosθ；
Shader "Dee/LambertDiffuse PixelLit"
{
    Properties
    {
        [Toggle] _HalfLambert ("HalfLambert", Float) = 0
    
        _DiffuseColor("Diffuse Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "LightMode"="ForwardBase"}
        LOD 100

        Pass
        {
            CGPROGRAM
            
            #pragma shader_feature _HALFLAMBERT_ON
            
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            
            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 normal : TEXCOORD0;
            };

            float4 _DiffuseColor;
            
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = v.normal;
                
                return o;
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                float3 worldNormal = mul((float3x3)unity_ObjectToWorld,i.normal);
            
                float3 normalDir = normalize(worldNormal); 
                float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);
                
                float dotV = dot(lightDir, normalDir);
                
                #if _HALFLAMBERT_ON
                dotV = dotV * 0.5 + 0.5;
                #else
                dotV = saturate(dotV);
                #endif
                
                float4 diffuseCol = _LightColor0* _DiffuseColor * dotV;
                
                return diffuseCol;
            }
            ENDCG
        }
    }
}
