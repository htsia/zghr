package com.hr319wg.xys.eva.pojo.bo;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-9
 * Time: ÏÂÎç5:16
 * To change this template use File | Settings | File Templates.
 */
public class XysKpiKeyBO {
    private String keyId;
    private String keyName;
    private String gradeStd;
    private String aimValue;
    private String dataSource;
    private String weight;
    private String hiValue;
    private String lowValue;
    private String libId;

    public void initRow(){
        this.keyId=null;
        this.keyName="";
        this.gradeStd="";
        this.aimValue="";
        this.dataSource="";
        this.weight="";
        this.hiValue="";
        this.lowValue="";
        this.libId="";
    }
    public String getKeyId() {
        return keyId;
    }

    public void setKeyId(String keyId) {
        this.keyId = keyId;
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

    public String getLibId() {
        return libId;
    }

    public void setLibId(String libId) {
        this.libId = libId;
    }
}
