package com.hr319wg.eva.pojo.bo;

public class EvaKeyItemBO {
    private String itemID;
    private String itemName;
    private String setID;
    private String setName;
    private String itemType;
    private String itemFun;
    private String validFlag;
    private String orguid;
    private String showSEQ;
    private String scoreStandard;
    private String lowValue;
    private String highValue;
    private String createDate;
    private String itemDes;
    
    public String getItemFun() {
		return itemFun;
	}

	public void setItemFun(String itemFun) {
		this.itemFun = itemFun;
	}

	public void initRow(){
    	this.createDate="";
    	this.highValue="";
    	this.itemID=null;
    	this.itemName="";
    	this.itemType="";
    	this.lowValue="";
    	this.scoreStandard="";
    	this.showSEQ="";
    	this.validFlag="";
    	this.itemFun="";
    }

    public String getItemDes() {
        return itemDes;
    }
    public void setItemDes(String itemDes) {
        this.itemDes = itemDes;
    }

    public String getItemID() {
        return itemID;
    }
    public void setItemID(String id) {
        this.itemID = id;
    }

    public String getItemName() {
        return itemName;
    }
    public void setItemName(String id) {
        this.itemName = id;
    }

    public String getSetID() {
        return setID;
    }
    public void setSetID(String id) {
        this.setID = id;
    }

    public String getSetName() {
        return setName;
    }
    public void setSetName(String id) {
        this.setName = id;
    }

    public String getItemType() {
        return itemType;
    }
    public void setItemType(String id) {
        this.itemType = id;
    }

    public String getValidFlag() {
        return validFlag;
    }
    public void setValidFlag(String id) {
        this.validFlag = id;
    }


    public String getOrguid() {
        return orguid;
    }
    public void setOrguid(String id) {
        this.orguid = id;
    }

    public String getShowSEQ() {
        return showSEQ;
    }
    public void setShowSEQ(String id) {
        this.showSEQ = id;
    }

    public String getScoreStandard() {
        return scoreStandard;
    }
    public void setScoreStandard(String id) {
        this.scoreStandard = id;
    }

    public String getLowValue() {
        return lowValue;
    }
    public void setLowValue(String id) {
        this.lowValue = id;
    }

    public String getHighValue() {
        return highValue;
    }
    public void setHighValue(String id) {
        this.highValue = id;
    }

    public String getCreateDate() {
        return createDate;
    }
    public void setCreateDate(String id) {
        this.createDate = id;
    }

}
