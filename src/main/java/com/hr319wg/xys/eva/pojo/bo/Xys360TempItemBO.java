package com.hr319wg.xys.eva.pojo.bo;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-10
 * Time: ÏÂÎç6:03
 * To change this template use File | Settings | File Templates.
 */
public class Xys360TempItemBO {
    private String itemId;
    private String itemName;
    private String itemDesc;
    private String weight;
    private String hiValue;
    private String lowValue;
    private String keyId;
    private String setId;

    public void initRow(){
        this.itemId=null;
        this.itemName="";
        this.itemDesc="";
        this.weight="";
        this.hiValue="";
        this.lowValue="";
        this.keyId="";
        this.setId="";
    }
    public String getSetId() {
        return setId;
    }

    public void setSetId(String setId) {
        this.setId = setId;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getItemDesc() {
        return itemDesc;
    }

    public void setItemDesc(String itemDesc) {
        this.itemDesc = itemDesc;
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

    public String getKeyId() {
        return keyId;
    }

    public void setKeyId(String keyId) {
        this.keyId = keyId;
    }
}
