package com.hr319wg.xys.eva.pojo.bo;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-2
 * Time: ÏÂÎç3:53
 * To change this template use File | Settings | File Templates.
 */
public class Xys360KeyLibBO {
    private String libId;
    private String libName;
    private String superId;

    private String superName;

    public void initRow(){
        this.libId=null;
        this.libName="";
        this.superId="";
    }

    public String getSuperName() {
        return superName;
    }

    public void setSuperName(String superName) {
        this.superName = superName;
    }

    public String getLibId() {
        return libId;
    }

    public void setLibId(String libId) {
        this.libId = libId;
    }

    public String getLibName() {
        return libName;
    }

    public void setLibName(String libName) {
        this.libName = libName;
    }

    public String getSuperId() {
        return superId;
    }

    public void setSuperId(String superId) {
        this.superId = superId;
    }
}
