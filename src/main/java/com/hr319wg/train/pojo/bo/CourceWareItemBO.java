package com.hr319wg.train.pojo.bo;

public class CourceWareItemBO {
	public static String ACTION_PLAY = "1";
	public static String ACTION_LINK = "2";
	private String itemID;
	private String typeID;
	private String typeName;
	private String title;
	private String createDate;
	private String startDate;
	private String endDate;
	private String newEndDate;
	private String fileName;
	private String orgID;
	private String action;
	private boolean newCource;
	private String createor;
	private String iconFile;
	private String haveIcon;
	private String publicFlag;
	private String publicDes;
	private String top;
	private String itemOrder;

	public String getItemOrder() {
		return itemOrder;
	}

	public void setItemOrder(String itemOrder) {
		this.itemOrder = itemOrder;
	}

	public String getTop() {
		return top;
	}

	public void setTop(String top) {
		this.top = top;
	}

	public String getPublicDes() {
		if ((this.publicFlag != null) && (!this.publicFlag.equals(""))) {
			if (this.publicFlag.equals("0"))
				this.publicDes = "·ñ";
			else if (this.publicFlag.equals("1")) {
				this.publicDes = "ÊÇ";
			}
		}
		return this.publicDes;
	}

	public void setPublicDes(String publicDes) {
		this.publicDes = publicDes;
	}

	public String getPublicFlag() {
		return this.publicFlag;
	}

	public void setPublicFlag(String publicFlag) {
		this.publicFlag = publicFlag;
	}

	public String getHaveIcon() {
		if ((this.iconFile != null) && (!this.iconFile.equals("")))
			this.haveIcon = "1";
		else {
			this.haveIcon = "0";
		}
		return this.haveIcon;
	}

	public void setHaveIcon(String haveIcon) {
		this.haveIcon = haveIcon;
	}

	public String getIconFile() {
		return this.iconFile;
	}

	public void setIconFile(String iconFile) {
		this.iconFile = iconFile;
	}

	public String getCreateor() {
		return this.createor;
	}

	public void setCreateor(String id) {
		this.createor = id;
	}

	public boolean getNewCource() {
		return this.newCource;
	}

	public void setNewCource(boolean b) {
		this.newCource = b;
	}

	public String getAction() {
		return this.action;
	}

	public void setAction(String act) {
		this.action = act;
	}

	public String getOrgID() {
		return this.orgID;
	}

	public void setOrgID(String subId) {
		this.orgID = subId;
	}

	public String getTypeID() {
		return this.typeID;
	}

	public void setTypeID(String subId) {
		this.typeID = subId;
	}

	public String getTypeName() {
		return this.typeName;
	}

	public void setTypeName(String name) {
		this.typeName = name;
	}

	public String getItemID() {
		return this.itemID;
	}

	public void setItemID(String name) {
		this.itemID = name;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String name) {
		this.title = name;
	}

	public String getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(String name) {
		this.createDate = name;
	}

	public String getFileName() {
		return this.fileName;
	}

	public void setFileName(String name) {
		this.fileName = name;
	}

	public String getStartDate() {
		return this.startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return this.endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getNewEndDate() {
		return this.newEndDate;
	}

	public void setNewEndDate(String endDate) {
		this.newEndDate = endDate;
	}
}