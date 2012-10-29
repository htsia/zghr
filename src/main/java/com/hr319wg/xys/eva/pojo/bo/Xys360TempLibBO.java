package com.hr319wg.xys.eva.pojo.bo;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-10
 * Time: ÏÂÎç2:23
 * To change this template use File | Settings | File Templates.
 */
public class Xys360TempLibBO {
    private String tempLibId;
    private String tempLibName;
    private String superId;

    private String superName;

    public void initRow(){
        this.tempLibId=null;
        this.tempLibName="";
        this.superId="";
    }

    public String getSuperName() {
        return superName;
    }

    public void setSuperName(String superName) {
        this.superName = superName;
    }

    public String getTempLibId() {
        return tempLibId;
    }

    public void setTempLibId(String tempLibId) {
        this.tempLibId = tempLibId;
    }

    public String getTempLibName() {
        return tempLibName;
    }

    public void setTempLibName(String tempLibName) {
        this.tempLibName = tempLibName;
    }

    public String getSuperId() {
        return superId;
    }

    public void setSuperId(String superId) {
        this.superId = superId;
    }
}
