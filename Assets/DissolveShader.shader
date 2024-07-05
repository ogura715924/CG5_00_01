Shader "Unlit/NewUnlitShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass//ˆê‚Â–Ú‚ÌPass
        {
            Cull front//CGPROGRAM‚Ì‘O‚É‰ÂƒŠƒ“ƒO‚Ìİ’è
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include"UnityCG.cginc"

            struct appdata{
                float4 vertex:POSITION;
                float2 uv:TEXCOORD0;
            };

            struct v2f{
                float4 vertex:SV_POSITION;
                float2 uv:TEXCOORD0;
            };

            sampler2D _MaskTex;
            float4 _MaskTex_ST;
            float _Dissolve;

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex=UnityObjectToClipPos(v.vertex);
                o.uv=v.uv;
                return o;
            }
            fixed4 frag(v2f i):SV_Target
            {
                fixed4 mask = tex2D(_MaskTex, i.uv);
                clip(mask-_Dissolve);
                return fixed4(0,1,1,1);
            }
            ENDCG
        }

        Pass//“ñ‚Â–Ú‚ÌPass
        {
            Cull back//— –Ê‚Ì•`‰æÈ—ª
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include"UnityCG.cginc"

            struct appdata
            {
                float4 vertex:POSITION;
                float2 uv:TEXCOORD0;
            };

            struct v2f{
                float4 vertex:SVPOSITION;
                float2 uv :TEXCOORD0;
            };

            sampler2D _MaskTex;
            float4 _MaskTex_ST;
            float _Dissolve;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex=UnityObjectToClipPos(v.vertex);
                o.uv=v.uv;
                return o;
            }

            fixed4 frag(v2f i):SV_Target
            {
                fixed4 mask=tex2D(_MaskTex,i.uv);
                clip(mask.r-_Dissolve);
                return mask;
            }
            ENDCG
        }

    }
}
