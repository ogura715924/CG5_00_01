using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CrossFilter : MonoBehaviour
{
    public Shader highLumiShader;//高輝度抽出用
    public Shader blurShader;//直接的にぼかすシェーダ
    public Shader compoShader;//テクスチャ合成用シェーダ

    private Material highLumiMat;
    private Material blurMat;
    private Material compoMat;

    private void Awake()
    {
        highLumiMat = new Material(highLumiShader);
        blurMat = new Material(blurShader);
        compoMat = new Material(compoShader);
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        RenderTexture highLumiTex = RenderTexture.GetTemporary(source.width, source.height, 0, source.format);
        RenderTexture blurTex0 = RenderTexture.GetTemporary(source.width, source.height, 0, source.format);
        RenderTexture blurTex1 = RenderTexture.GetTemporary(source.width, source.height, 0, source.format);
        RenderTexture bufTex = RenderTexture.GetTemporary(source.width, source.height, 0, source.format);

        Graphics.Blit(source, highLumiTex, highLumiMat);
        blurMat.SetFloat("_AngleDeg", 45);//角度調整
        Graphics.Blit(highLumiTex, blurTex0, blurMat);

        blurMat.SetFloat("_AngleDeg", 135);
        Graphics.Blit(highLumiTex, blurTex1, blurMat);

        compoMat.SetTexture("_BlurTex", blurTex0);
        Graphics.Blit(source, bufTex, compoMat);
        compoMat.SetTexture("_BlurTex", blurTex1);
        Graphics.Blit(bufTex, destination, compoMat);
    }
}