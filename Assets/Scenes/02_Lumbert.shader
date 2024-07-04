Shader "Unlit/02_Lumbert"
{
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "Lighting.cginc"//光源情報を取得するのに必要


            struct appdata//構造体の宣言
            {
                float4 vertex : POSITION;//構造体にはセマンティクスが必要
                float3 normal : NORMAL;//法線情報用のセマンティクス
            };

            struct v2f
            {
                float4 vertex : POSITION;
                float3 normal :NORMAL;
            };

            v2f vert (appdata v)//引数や返値の構造体の中にセマンティクスが書かれているため関数部分には不要
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                //法線情報は頂点情報の中にあるのでfragに渡す必要がある
                //ただしモデルから受け取れる法線情報はモデルのローカル座標系なのでワールド座標系の法線に変換する必要がある
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                //面の法線と光源の向きの内積を求める
                //光源の向きがどの向きにあるのかは_worldSpaceLightPos0から取得できる
                //頂点から受け取った法線情報「i.normal」はここで標準化してください
                //satutateは引数の値を0-1にクランプする関数です内積は二つのベクトルの角度が90度を超えるとマイナスになります
                //それだと困るので内積地にはsaturateをかけて結果を0-1にクランプしてください
                float intensity　=　saturate(dot(normalize(i.normal),_worldSpaceLightPos0));

                //内積の値だけ明るくする
                fixed4 color=fixed4(1,1,1,1);
                //_LightColor0は光源の色includeしたLighting.cgincで宣言されている
                fixed4 diffuse = color * intensity * _LightColor0;

                return diffuse;
            }
            ENDCG
        }
    }
}
