package com.hr319wg.attence.pojo.bo;

public class AttClassDetailBO {
    //时间表示：1第一天时刻2第二天时刻
    public static final String DAY_FLAG_FIRST="1";
    public static final String DAY_FLAG_SECOND="2";

    private String itemID;
    private String classID;
    private String itemName;
    private String itemTime;
    private String dayFlag;
    private String orderFlag;
    
    public String getOrderFlag() {
		return orderFlag;
	}

	public void setOrderFlag(String orderFlag) {
		this.orderFlag = orderFlag;
	}

	public String getItemID() {
        return itemID;
    }

    public void setItemID(String itemID) {
        this.itemID = itemID;
    }

    public String getClassID() {
        return classID;
    }

    public void setClassID(String classID) {
        this.classID = classID;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getItemTime() {
        return itemTime;
    }

    public void setItemTime(String itemTime) {
        this.itemTime = itemTime;
    }

    public String getDayFlag() {
        return dayFlag;
    }

    public void setDayFlag(String dayFlag) {
        this.dayFlag = dayFlag;
    }

}
