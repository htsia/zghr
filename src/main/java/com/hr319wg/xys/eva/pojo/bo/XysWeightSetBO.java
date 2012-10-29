package com.hr319wg.xys.eva.pojo.bo;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-11
 * Time: 上午11:41
 * To change this template use File | Settings | File Templates.
 */
public class XysWeightSetBO {
	//1直接上级2同级3下级4上上级5其他上级6其他同级
    public static final String EVA_TYPE_LEADER="1";
    public static final String EVA_TYPE_VIS="2";
    public static final String EVA_TYPE_LOWER="3";
    public static final String EVA_TYPE_PRE_LEADER="4";
    public static final String EVA_TYPE_OTHER_LEADER="5";
    public static final String EVA_TYPE_OTHER_VIS="6";

    public static final String TYPE_KPI="1";
    public static final String TYPE_360="2";

    private String setId;
    private String postId;
    private String type;
    private String evaPostId;
    private String evaType;
    private String planId;

    private String evaTypeDes;
    private String deptName;

    public void initRow(){
        this.setId=null;
        this.postId="";
        this.type="";
        this.evaPostId="";
        this.evaType="";
    }
    
    
    public String getPlanId() {
		return planId;
	}


	public void setPlanId(String planId) {
		this.planId = planId;
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
                 evaTypeDes="直接上级";
            }else if(evaType.equals(EVA_TYPE_VIS)){
                 evaTypeDes="同级";
            }else if(evaType.equals(EVA_TYPE_LOWER)){
                 evaTypeDes="下级";
            }else if(evaType.equals(EVA_TYPE_PRE_LEADER)){
            	 evaTypeDes="上上级";
            }else if(evaType.equals(EVA_TYPE_OTHER_LEADER)){
            	evaTypeDes="其他上级";
            }else if(evaType.equals(EVA_TYPE_OTHER_VIS)){
            	evaTypeDes="其他同级";
            }
        }
        return evaTypeDes;
    }

    public void setEvaTypeDes(String evaTypeDes) {
        this.evaTypeDes = evaTypeDes;
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

    public String getSetId() {
        return setId;
    }

    public void setSetId(String setId) {
        this.setId = setId;
    }

    public String getPostId() {
        return postId;
    }

    public void setPostId(String postId) {
        this.postId = postId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
