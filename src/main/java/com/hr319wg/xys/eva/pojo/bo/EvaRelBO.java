package com.hr319wg.xys.eva.pojo.bo;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-5-26
 * Time: ����12:20
 * To change this template use File | Settings | File Templates.
 */
public class EvaRelBO {
    //1ֱ���ϼ�2ͬ��3�¼�4���ϼ�5�����ϼ�6����ͬ��
    public static final String EVA_TYPE_LEADER="1";
    public static final String EVA_TYPE_VIS="2";
    public static final String EVA_TYPE_LOWER="3";
    public static final String EVA_TYPE_PRE_LEADER="4";
    public static final String EVA_TYPE_OTHER_LEADER="5";
    public static final String EVA_TYPE_OTHER_VIS="6";

    private String relId;
    private String postId;
    private String evaPostId;
    private String evaType;

    private String evaTypeDes;
    private String deptName;

    public void initRow(){
         this.relId=null;
         this.postId="";
         this.evaPostId="";
         this.evaType="";
    }
    
    
    public String getDeptName() {
		return deptName;
	}


	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}


	public String getEvaTypeDes() {
        if(evaType!=null&&!evaType.equals("")){
            if(evaType.equals(EVA_TYPE_LEADER)){
                 evaTypeDes="ֱ���ϼ�";
            }else if(evaType.equals(EVA_TYPE_VIS)){
                 evaTypeDes="ͬ��";
            }else if(evaType.equals(EVA_TYPE_LOWER)){
                 evaTypeDes="�¼�";
            }else if(evaType.equals(EVA_TYPE_PRE_LEADER)){
            	 evaTypeDes="���ϼ�";
            }else if(evaType.equals(EVA_TYPE_OTHER_LEADER)){
            	evaTypeDes="�����ϼ�";
            }else if(evaType.equals(EVA_TYPE_OTHER_VIS)){
            	evaTypeDes="����ͬ��";
            }
        }
        return evaTypeDes;
    }

    public void setEvaTypeDes(String evaTypeDes) {
        this.evaTypeDes = evaTypeDes;
    }

    public String getRelId() {
        return relId;
    }

    public void setRelId(String relId) {
        this.relId = relId;
    }

    public String getPostId() {
        return postId;
    }

    public void setPostId(String postId) {
        this.postId = postId;
    }

    public String getEvaPostId() {
        return evaPostId;
    }

    public void setEvaPostId(String evaPostId) {
        this.evaPostId = evaPostId;
    }

    public String getEvaType() {
        return evaType;
    }

    public void setEvaType(String evaType) {
        this.evaType = evaType;
    }
}
