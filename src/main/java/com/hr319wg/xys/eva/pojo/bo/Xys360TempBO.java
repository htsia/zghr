package com.hr319wg.xys.eva.pojo.bo;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-10
 * Time: ÏÂÎç2:24
 * To change this template use File | Settings | File Templates.
 */
public class Xys360TempBO {
    private String tempId;
    private String tempName;
    private String tmpLibId;
    private String tatalScore;

    public void initRow(){
        this.tempId=null;
        this.tempName="";
        this.tmpLibId="";
        this.tatalScore="";
    }
    public String getTempId() {
        return tempId;
    }

    public void setTempId(String tempId) {
        this.tempId = tempId;
    }

    public String getTempName() {
        return tempName;
    }

    public void setTempName(String tempName) {
        this.tempName = tempName;
    }

    public String getTmpLibId() {
        return tmpLibId;
    }

    public void setTmpLibId(String tmpLibId) {
        this.tmpLibId = tmpLibId;
    }

    public String getTatalScore() {
        return tatalScore;
    }

    public void setTatalScore(String tatalScore) {
        this.tatalScore = tatalScore;
    }
}
