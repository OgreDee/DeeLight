// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Dee/CubeReflect"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
        _Cube("Cube Map", Cube) = "_Skybox" {}
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
                //float3 reflectDir : TEXCOORD1;
                float3 worldNormal : TEXCOORD1;
                float3 worldPos : TEXCOORD2;
                
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
            samplerCUBE _Cube;
			
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
				//fixed4 col = tex2D(_MainTex, i.uv);
                
                float3 viewDir = UnityWorldSpaceViewDir(i.worldPos);
                
                float3 reflectDir = reflect(-normalize(viewDir), normalize(i.worldNormal));
                
                return float4(texCUBE(_Cube, normalize(reflectDir)).rgb, 1);
                
				//return col;
			}
			ENDCG
		}
	}
}
