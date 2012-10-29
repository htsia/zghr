package com.hr319wg.xys.eva.pojo.bo;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-12
 * Time: ÏÂÎç5:09
 * To change this template use File | Settings | File Templates.
 */
public class XysKpiObjLibBO {
    private String objLibId;
    private String objId;
    private String objLibName;

    public void initRow(){
        this.objLibId=null;
        this.objId="";
        this.objLibName="";
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

    public String getObjLibName() {
        return objLibName;
    }

    public void setObjLibName(String objLibName) {
        this.objLibName = objLibName;
    }
}
