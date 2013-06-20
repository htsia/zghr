package com.hr319wg.xys.eva.pojo.vo;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-6
 * Time: 上午10:47
 * To change this template use File | Settings | File Templates.
 */
public class PostEvaVO {
    private String postId;
    private String postName;
    private String postClass;
    private String deptName;
    private String weightKpi;
    private String weight360;
    private String weightXspj;
    private String error;
    private String weightDes;
    
    
    public String getPostClass() {
		return postClass;
	}

	public void setPostClass(String postClass) {
		this.postClass = postClass;
	}

	public String getWeightDes() {
    	String des="";
    	if(weightKpi!=null&&!weightKpi.equals("")){
    		if(des.equals("")){
    			des+="<b>KPI</b>("+weightKpi+"%)";
    		}else{
    			des+=",<b>KPI</b>("+weightKpi+"%)";
    		}
    	}
    	if(weight360!=null&&!weight360.equals("")){
    		if(des.equals("")){
    			des+="<b>360</b>("+weight360+"%)";
    		}else{
    			des+=",<b>360</b>("+weight360+"%)";
    		}
    	}
    	if(weightXspj!=null&&!weightXspj.equals("")){
    		if(des.equals("")){
    			des+="<b>其他评价</b>("+weightXspj+"%)";
    		}else{
    			des+=",<b>其他评价</b>("+weightXspj+"%)";
    		}
    	}
    	weightDes=des;
		return weightDes;
	}

	public void setWeightDes(String weightDes) {
		this.weightDes = weightDes;
	}

	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}

	public String getPostId() {
        return postId;
    }

    public void setPostId(String postId) {
        this.postId = postId;
    }

    public String getPostName() {
        return postName;
    }

    public void setPostName(String postName) {
        this.postName = postName;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getWeightKpi() {
        return weightKpi;
    }

    public void setWeightKpi(String weightKpi) {
        this.weightKpi = weightKpi;
    }

    public String getWeight360() {
        return weight360;
    }

    public void setWeight360(String weight360) {
        this.weight360 = weight360;
    }

    public String getWeightXspj() {
        return weightXspj;
    }

    public void setWeightXspj(String weightXspj) {
        this.weightXspj = weightXspj;
    }
}
