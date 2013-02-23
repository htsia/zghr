package com.hr319wg.sys.pojo.vo;

import java.io.Serializable;

public class NewsEditVO implements Serializable {
	private String topic;
	private String content;
	private String submitDate;
	private String startDate;
	private String newEndDate;
	private String endDate;
	private String readerType;
	private String scopeOrgNames;
	private String scopeOrgIds;
	private String newId;
	private String infoLevel;
	private String newsFile;
	private String newsSource;
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

	public String getNewsSource() {
		return this.newsSource;
	}

	public void setNewsSource(String newsSource) {
		this.newsSource = newsSource;
	}

	public String getNewsFile() {
		return this.newsFile;
	}

	public void setNewsFile(String file) {
		this.newsFile = file;
	}

	public String getInfoLevel() {
		return this.infoLevel;
	}

	public void setInfoLevel(String status) {
		this.infoLevel = status;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public String getTopic() {
		return this.topic;
	}

	public void setTopic(String topic) {
		this.topic = topic;
	}

	public String getNewId() {
		return this.newId;
	}

	public void setNewId(String Id) {
		this.newId = Id;
	}

	public String getScopeOrgIds() {
		return this.scopeOrgIds;
	}

	public void setScopeOrgIds(String scopeOrgIds) {
		this.scopeOrgIds = scopeOrgIds;
	}

	public String getScopeOrgNames() {
		return this.scopeOrgNames;
	}

	public void setScopeOrgNames(String scopeOrgNames) {
		this.scopeOrgNames = scopeOrgNames;
	}

	public String getEndDate() {
		return this.endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getStartDate() {
		return this.startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getNewEndDate() {
		return this.newEndDate;
	}

	public void setNewEndDate(String endDate) {
		this.newEndDate = endDate;
	}
}