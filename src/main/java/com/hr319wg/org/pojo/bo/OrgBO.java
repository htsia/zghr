package com.hr319wg.org.pojo.bo;

import com.hr319wg.common.pojo.vo.NodeVO;

public class OrgBO extends NodeVO  implements Comparable<OrgBO>{
	public static String UNITTYPE = "089110";
	public static String DEPTTYPE = "089111";
	public static String GROUPTYPE = "089112";
	public static String VIRTUALTYPE = "089113";
	private String orgId;
	private String orgCode;
	private String orgSort;
	private String orgType;
	private String orgHeader;
	private String orgCancel;
	private String orgClass;
	private String operId;
	private String orgAddress;
	private String orgRegAddress;
	private String orgPhoto;
	private String postCode;
	private String postAddress;
	private String phone;
	private String partySetup;
	private String insuraceID;
	private String taxID;
	private String lawID;
	private String registType;
	private String vocation;
	private String subordinate;
	private String account;
	private String control;
	private String orgScale;
	private String bodyStyle;
	private String orgTask;
	private String orgCreateDate;

	public String getBodyStyle() {
		return this.bodyStyle;
	}

	public void setBodyStyle(String bodyStyle) {
		this.bodyStyle = bodyStyle;
	}

	public String getOrgTask() {
		return this.orgTask;
	}

	public void setOrgTask(String orgTask) {
		this.orgTask = orgTask;
	}

	public String getOrgCreateDate() {
		return this.orgCreateDate;
	}

	public void setOrgCreateDate(String orgCreateDate) {
		this.orgCreateDate = orgCreateDate;
	}

	public String getOrgScale() {
		return this.orgScale;
	}

	public void setOrgScale(String orgScale) {
		this.orgScale = orgScale;
	}

	public String getcontrol() {
		return this.control;
	}

	public void setcontrol(String type) {
		this.control = type;
	}

	public String getaccount() {
		return this.account;
	}

	public void setaccount(String type) {
		this.account = type;
	}

	public String getsubordinate() {
		return this.subordinate;
	}

	public void setsubordinate(String type) {
		this.subordinate = type;
	}

	public String getvocation() {
		return this.vocation;
	}

	public void setvocation(String type) {
		this.vocation = type;
	}

	public String getregistType() {
		return this.registType;
	}

	public void setregistType(String type) {
		this.registType = type;
	}

	public String getlawID() {
		return this.lawID;
	}

	public void setlawID(String id) {
		this.lawID = id;
	}

	public String getOrgHeader() {
		return this.orgHeader;
	}

	public void setOrgHeader(String orgHeader) {
		this.orgHeader = orgHeader;
	}

	public String getinsuraceID() {
		return this.insuraceID;
	}

	public void setinsuraceID(String orgId) {
		this.insuraceID = orgId;
	}

	public String gettaxID() {
		return this.taxID;
	}

	public void settaxID(String orgId) {
		this.taxID = orgId;
	}

	public String getorgType() {
		return this.orgType;
	}

	public void setorgType(String type) {
		this.orgType = type;
	}

	public String getOrgId() {
		return this.orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
		super.setPkId(orgId);
	}

	public String getOrgCode() {
		return this.orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public String getOrgSort() {
		return this.orgSort;
	}

	public void setOrgSort(String orgSort) {
		this.orgSort = orgSort;
	}

	public String getOrgCancel() {
		return this.orgCancel;
	}

	public void setOrgCancel(String orgCancel) {
		this.orgCancel = orgCancel;
	}

	public String getOrgClass() {
		return this.orgClass;
	}

	public void setOrgClass(String orgClass) {
		this.orgClass = orgClass;
	}

	public String getOperId() {
		return this.operId;
	}

	public void setOperId(String operId) {
		this.operId = operId;
	}

	public String getOrgAddress() {
		return this.orgAddress;
	}

	public void setOrgAddress(String orgAddress) {
		this.orgAddress = orgAddress;
	}

	public String getOrgRegAddress() {
		return this.orgRegAddress;
	}

	public void setOrgRegAddress(String orgAddress) {
		this.orgRegAddress = orgAddress;
	}

	public String getOrgPhoto() {
		return this.orgPhoto;
	}

	public void setOrgPhoto(String orgPhoto) {
		this.orgPhoto = orgPhoto;
	}

	public String getPostCode() {
		return this.postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	public String getPostAddress() {
		return this.postAddress;
	}

	public void setPostAddress(String postAddress) {
		this.postAddress = postAddress;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPartySetup() {
		return this.partySetup;
	}

	public void setPartySetup(String partySetup) {
		this.partySetup = partySetup;
	}

	public int compareTo(OrgBO o) {
		if(this.orgSort!=null && "".equals(this.orgSort) && o!=null && !"".equals(o.getOrgSort())){
			return this.orgSort.compareTo(o.getOrgSort());	
		}
		return 0;
	}
}