package com.hr319wg.xys.eva.pojo.bo;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-10
 * Time: ÏÂÎç6:01
 * To change this template use File | Settings | File Templates.
 */
public class Xys360TempSetBO {
    private String setId;
    private String setName;
    private String tempId;
    private String setType;

    public void initRow(){
        this.setId=null;
        this.setName="";
        this.tempId="";
        this.setType="";
    }
    public String getSetId() {
        return setId;
    }

    public void setSetId(String setId) {
        this.setId = setId;
    }

    public String getSetName() {
        return setName;
    }

    public void setSetName(String setName) {
        this.setName = setName;
    }

    public String getTempId() {
        return tempId;
    }

    public void setTempId(String tempId) {
        this.tempId = tempId;
    }

    public String getSetType() {
        return setType;
    }

    public void setSetType(String setType) {
        this.setType = setType;
    }
}
