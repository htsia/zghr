package com.hr319wg.sys.pojo.bo;

import java.io.Serializable;

public class NewsParamBO implements Serializable {
	public static final String READTYPE_ALL = "01";
	public static final String READTYPE_HR = "02";
	private String newId;
	private String authorId;
	private String submitDate;
	private String newTopic;
	private String startDate;
	private String endDate;
	private String newEndDate;
	private String organScope;
	private String readerType;
	private String creatorRoleId;
	private String infoLevel;
	private boolean newNews;
	private String newsSource;
	private String display;
	private String publicFlag;
	private String express;
	private String itemOrder;

	public String getItemOrder() {
		return itemOrder;
	}

	public void setItemOrder(String itemOrder) {
		this.itemOrder = itemOrder;
	}

	public String getExpress() {
		return this.express;
	}

	public void setExpress(String express) {
		this.express = express;
	}

	public String getPublicFlag() {
		return this.publicFlag;
	}

	public void setPublicFlag(String publicFlag) {
		this.publicFlag = publicFlag;
	}

	public String getDisplay() {
		this.display = "";
		if ((this.newsSource != null) && (!"".equals(this.newsSource))) {
			this.display = (this.display + "¹©¸å:" + this.newsSource);
		}
		return this.display;
	}

	public void setDisplay(String display) {
		this.display = display;
	}

	public String getNewsSource() {
		return this.newsSource;
	}

	public void setNewsSource(String newsSource) {
		this.newsSource = newsSource;
	}

	public boolean getNewNews() {
		return this.newNews;
	}

	public void setNewNews(boolean b) {
		this.newNews = b;
	}

	public String getInfoLevel() {
		return this.infoLevel;
	}

	public void setInfoLevel(String status) {
		this.infoLevel = status;
	}

	public void BulletinParamBO() {
	}

	public String getOrganScope() {
		return this.organScope;
	}

	public void setOrganScope(String Id) {
		this.organScope = Id;
	}

	public String getAuthorId() {
		return this.authorId;
	}

	public void setAuthorId(String authorId) {
		this.authorId = authorId;
	}

	public String getNewId() {
		return this.newId;
	}

	public void setNewId(String Id) {
		this.newId = Id;
	}

	public String getNewTopic() {
		return this.newTopic;
	}

	public void setNewTopic(String newTopic) {
		this.newTopic = newTopic;
	}

	public String getCreatorRoleId() {
		return this.creatorRoleId;
	}

	public void setCreatorRoleId(String creatorRoleId) {
		this.creatorRoleId = creatorRoleId;
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

	public String getReaderType() {
		return this.readerType;
	}

	public void setReaderType(String readerType) {
		this.readerType = readerType;
	}

	public String getSubmitDate() {
		return this.submitDate;
	}

	public void setSubmitDate(String submitDate) {
		this.submitDate = submitDate;
	}
}