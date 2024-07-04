using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PostEffectAttacher : MonoBehaviour
{
    public Shader highLumiShader;//高輝度箇所を抽出するシェーダ
    public Shader blurShader;//ブラーをかけるシェーダ
    public Shader compoShader;//テクスチャを合成するシェーダ

    private Material highLumiMat;//高輝度箇所をを抽出するシェーダ
    private Material blurMat;//ブラーをかけるシェーダを割り当てるマテリアル
    private Material compoMat;//テクスチャを合成するシェーダを割り当てるマテリアル

    private void Awake()
    {
        highLumiMat = new Material(highLumiShader);
        blurMat=new Material(blurShader);
        compoMat = new Material(compoShader);
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {

        RenderTexture highLumiTex = RenderTexture.GetTemporary(source.width, source.height, 0, source.format);//高輝度箇所を抽出したものを格納するためのテクスチャ
        RenderTexture blurTex = RenderTexture.GetTemporary(source.width, source.height, 0, source.format);//高輝度箇所をぼかしたものを格納するためのテクスチャ

        Graphics.Blit(source, highLumiTex, highLumiMat);//高輝度箇所を抽出し、hightLumiTexに格納
        Graphics.Blit(highLumiTex, blurTex, blurMat);//高輝度箇所にブラーをかけてblurTexに格納

        compoMat.SetTexture("_HighLumiTex", blurTex);//合成用シェーダcompoMatの「_HIghLumiTex」変数に格納
        Graphics.Blit(source, destination, compoMat);//高輝度箇所にブラーをかけ出力

        RenderTexture.ReleaseTemporary(blurTex);
        RenderTexture.ReleaseTemporary(highLumiTex);

    }

}