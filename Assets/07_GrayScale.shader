Shader "Unlit/07_PostEffect"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }

    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv=v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                fixed l=(col.r+col.g+col.b)/3;

               // return fixed4(0,col.g,0,1);

                // //グレースケール
                // fixed grayScale=col.r*0.299+col.g*0.587+col.b*0.114;
                // fixed4 color =fixed4(grayScale, grayScale, grayScale, 1);

                // return color;

                //セピアカラー
                fixed sepia=0.1;
                fixed grayScale=col.r*0.299+col.g*0.587+col.b*0.114;
                fixed4 color =fixed4(grayScale+sepia, grayScale, grayScale-sepia, 1);

                return color;
            }

            ENDCG
        }
    }
}
