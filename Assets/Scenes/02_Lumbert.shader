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
            #include "Lighting.cginc"//���������擾����̂ɕK�v


            struct appdata//�\���̂̐錾
            {
                float4 vertex : POSITION;//�\���̂ɂ̓Z�}���e�B�N�X���K�v
                float3 normal : NORMAL;//�@�����p�̃Z�}���e�B�N�X
            };

            struct v2f
            {
                float4 vertex : POSITION;
                float3 normal :NORMAL;
            };

            v2f vert (appdata v)//������Ԓl�̍\���̂̒��ɃZ�}���e�B�N�X��������Ă��邽�ߊ֐������ɂ͕s�v
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                //�@�����͒��_���̒��ɂ���̂�frag�ɓn���K�v������
                //���������f������󂯎���@�����̓��f���̃��[�J�����W�n�Ȃ̂Ń��[���h���W�n�̖@���ɕϊ�����K�v������
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                //�ʂ̖@���ƌ����̌����̓��ς����߂�
                //�����̌������ǂ̌����ɂ���̂���_worldSpaceLightPos0����擾�ł���
                //���_����󂯎�����@�����ui.normal�v�͂����ŕW�������Ă�������
                //satutate�͈����̒l��0-1�ɃN�����v����֐��ł����ς͓�̃x�N�g���̊p�x��90�x�𒴂���ƃ}�C�i�X�ɂȂ�܂�
                //���ꂾ�ƍ���̂œ��ϒn�ɂ�saturate�������Č��ʂ�0-1�ɃN�����v���Ă�������
                float intensity�@=�@saturate(dot(normalize(i.normal),_worldSpaceLightPos0));

                //���ς̒l�������邭����
                fixed4 color=fixed4(1,1,1,1);
                //_LightColor0�͌����̐Finclude����Lighting.cginc�Ő錾����Ă���
                fixed4 diffuse = color * intensity * _LightColor0;

                return diffuse;
            }
            ENDCG
        }
    }
}
