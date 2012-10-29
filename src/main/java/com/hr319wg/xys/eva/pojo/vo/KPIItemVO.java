package com.hr319wg.xys.eva.pojo.vo;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-12
 * Time: ÉÏÎç8:43
 * To change this template use File | Settings | File Templates.
 */
public class KPIItemVO {
    private String personId;
    private String superName;
    private String itemName;
    private String itemGrade;
    private String aimValue;
    private String dataSource;
    private String weight;
    private String hiScore;
    private String lowScore;
    private String execution;

    
    public String getExecution() {
		return execution;
	}

	public void setExecution(String execution) {
		this.execution = execution;
	}

	public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getSuperName() {
        return superName;
    }

    public void setSuperName(String superName) {
        this.superName = superName;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getItemGrade() {
        return itemGrade;
    }

    public void setItemGrade(String itemGrade) {
        this.itemGrade = itemGrade;
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

    public String getHiScore() {
        return hiScore;
    }

    public void setHiScore(String hiScore) {
        this.hiScore = hiScore;
    }

    public String getLowScore() {
        return lowScore;
    }

    public void setLowScore(String lowScore) {
        this.lowScore = lowScore;
    }
}
