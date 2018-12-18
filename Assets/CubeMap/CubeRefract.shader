Shader "Dee/CubeRefract"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
        _Cube("Cube Map", Cube) = "_Skybox" {}
        _Refract("Refract Rate", Range(0.1, 3)) = 1
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
                
                float3 worldNormal : TEXCOORD1;
                float3 worldPos : TEXCOORD2;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
            samplerCUBE _Cube;
            float _Refract;
			
			v2f vert (appdata v)
			{
				v2f o;
                                
				o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                
                o.worldNormal = mul(unity_ObjectToWorld, v.normal);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				float3 viewDir = UnityWorldSpaceViewDir(i.worldPos);
                
                float3 refractDir = refract(-normalize(viewDir), normalize(i.worldNormal), _Refract);
                
                return float4(texCUBE(_Cube, normalize(refractDir)).rgb, 1);
			}
			ENDCG
		}
	}
}
