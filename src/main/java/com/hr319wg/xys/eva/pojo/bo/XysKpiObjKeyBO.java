package com.hr319wg.xys.eva.pojo.bo;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-12
 * Time: ÏÂÎç5:10
 * To change this template use File | Settings | File Templates.
 */
public class XysKpiObjKeyBO {
    private String objKeyId;
    private String keyName;
    private String gradeStd;
    private String aimValue;
    private String dataSource;
    private String weight;
    private String hiValue;
    private String lowValue;
    private String objLibId;
    private String objId;
    private String execution;
    private String selfGrade;
    private int orderby;

    public void initRow(){
        this.objKeyId=null;
        this.keyName="";
        this.gradeStd="";
        this.aimValue="";
        this.dataSource="";
        this.weight="";
        this.hiValue="";
        this.lowValue="";
        this.objLibId="";
        this.objId="";
        this.execution="";
        this.selfGrade="";
    }

    
    public String getSelfGrade() {
		return selfGrade;
	}


	public void setSelfGrade(String selfGrade) {
		this.selfGrade = selfGrade;
	}


	public String getObjKeyId() {
        return objKeyId;
    }

    public void setObjKeyId(String objKeyId) {
        this.objKeyId = objKeyId;
    }

    public String getKeyName() {
        return keyName;
    }

    public void setKeyName(String keyName) {
        this.keyName = keyName;
    }

    public String getGradeStd() {
        return gradeStd;
    }

    public void setGradeStd(String gradeStd) {
        this.gradeStd = gradeStd;
    }

    public String getAimValue() {
        return aimValue;
    }

    public void setAimValue(String aimValue) {
        this.aimValue = aimValue;
    }

    public String getDataSource() {
        return dataSource;
    }

    public void setDataSource(String dataSource) {
        this.dataSource = dataSource;
    }

    public String getWeight() {
        return weight;
    }

    public void setWeight(String weight) {
        this.weight = weight;
    }

    public String getHiValue() {
        return hiValue;
    }

    public void setHiValue(String hiValue) {
        this.hiValue = hiValue;
    }

    public String getLowValue() {
        return lowValue;
    }

    public void setLowValue(String lowValue) {
        this.lowValue = lowValue;
    }

    public String getObjLibId() {
        return objLibId;
    }

    public void setObjLibId(String objLibId) {
        this.objLibId = objLibId;
    }

    public String getObjId() {
        return objId;
    }

    public void setObjId(String objId) {
        this.objId = objId;
    }

    public String getExecution() {
        return execution;
    }

    public void setExecution(String execution) {
        this.execution = execution;
    }


	public int getOrderby() {
		return orderby;
	}


	public void setOrderby(int orderby) {
		this.orderby = orderby;
	}
    
    
}
