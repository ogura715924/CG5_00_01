using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PostEffectAttacher : MonoBehaviour
{
    public Shader highLumiShader;//���P�x�ӏ��𒊏o����V�F�[�_
    public Shader blurShader;//�u���[��������V�F�[�_
    public Shader compoShader;//�e�N�X�`������������V�F�[�_

    private Material highLumiMat;//���P�x�ӏ����𒊏o����V�F�[�_
    private Material blurMat;//�u���[��������V�F�[�_�����蓖�Ă�}�e���A��
    private Material compoMat;//�e�N�X�`������������V�F�[�_�����蓖�Ă�}�e���A��

    private void Awake()
    {
        highLumiMat = new Material(highLumiShader);
        blurMat=new Material(blurShader);
        compoMat = new Material(compoShader);
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {

        RenderTexture highLumiTex = RenderTexture.GetTemporary(source.width, source.height, 0, source.format);//���P�x�ӏ��𒊏o�������̂��i�[���邽�߂̃e�N�X�`��
        RenderTexture blurTex = RenderTexture.GetTemporary(source.width, source.height, 0, source.format);//���P�x�ӏ����ڂ��������̂��i�[���邽�߂̃e�N�X�`��

        Graphics.Blit(source, highLumiTex, highLumiMat);//���P�x�ӏ��𒊏o���AhightLumiTex�Ɋi�[
        Graphics.Blit(highLumiTex, blurTex, blurMat);//���P�x�ӏ��Ƀu���[��������blurTex�Ɋi�[

        compoMat.SetTexture("_HighLumiTex", blurTex);//�����p�V�F�[�_compoMat�́u_HIghLumiTex�v�ϐ��Ɋi�[
        Graphics.Blit(source, destination, compoMat);//���P�x�ӏ��Ƀu���[�������o��

        RenderTexture.ReleaseTemporary(blurTex);
        RenderTexture.ReleaseTemporary(highLumiTex);

    }

}