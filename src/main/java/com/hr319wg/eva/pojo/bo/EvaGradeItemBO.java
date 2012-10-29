package com.hr319wg.eva.pojo.bo;

public class EvaGradeItemBO {
    private String itemID;
    private String gradeID;
    private String itemName;
    private String itemDes;
    private String lowValue;
    private String highValue;
    private String flagChar;
    private String showSeq;
    private String evaRatio;
    
    public void InitPara(){
        itemID=null;
        gradeID="";
        itemName="";
        itemDes="";
        lowValue="";
        highValue=""; 
        flagChar="";
        showSeq="";
        this.evaRatio="";
    }
    
    
    public String getEvaRatio() {
		return evaRatio;
	}


	public void setEvaRatio(String evaRatio) {
		this.evaRatio = evaRatio;
	}


	public String getShowSeq() {
		return showSeq;
	}
	public void setShowSeq(String showSeq) {
		this.showSeq = showSeq;
	}
	public String getFlagChar() {
		return flagChar;
	}
	public void setFlagChar(String flagChar) {
		this.flagChar = flagChar;
	}
	
    public String getHighValue() {
        return highValue;
    }
    public void setHighValue(String id) {
        this.highValue = id;
    }

    public String getLowValue() {
        return lowValue;
    }
    public void setLowValue(String id) {
        this.lowValue = id;
    }

    public String getItemID() {
        return itemID;
    }
    public void setItemID(String id) {
        this.itemID = id;
    }

    public String getGradeID() {
        return gradeID;
    }
    public void setGradeID(String id) {
        this.gradeID = id;
    }

    public String getItemName() {
        return itemName;
    }
    public void setItemName(String id) {
        this.itemName = id;
    }

    public String getItemDes() {
        return itemDes;
    }
    public void setItemDes(String id) {
        this.itemDes = id;
    }

}
