package com.hr319wg.attence.web;

import java.util.List;

import com.hr319wg.attence.pojo.bo.AttClassBO;
import com.hr319wg.attence.pojo.bo.AttWorkDateBO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.web.BaseBackingBean;

public class AttFeastWorkDateBackingBean extends BaseBackingBean {
	private IAttenceSetUCC attenceSetUCC;
	private String pageInit;
	private String superId = super.getUserInfo().getOrgId();
	private String feastID;
	private String orgId;
	private List lists;
	private String attworkdateId;
	private AttWorkDateBO bo = new AttWorkDateBO();
	private String initEdit;
	private String timeObject;
	private boolean isExist = false;
	private String workDatelists;

	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}

	public String getPageInit() {
		if (super.getRequestParameter("feastID") != null
				&& !super.getRequestParameter("feastID").equals("")
				&& super.getRequestParameter("oid") != null
				&& !super.getRequestParameter("oid").equals("")) {
			feastID = super.getRequestParameter("feastID");
			orgId = super.getRequestParameter("oid");
		}
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public String getFeastID() {
		return feastID;
	}

	public void setFeastID(String feastID) {
		this.feastID = feastID;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public List getLists() {
		return lists;
	}

	public void setLists(List lists) {
		this.lists = lists;
	}

	public String getAttworkdateId() {
		return attworkdateId;
	}

	public void setAttworkdateId(String attworkdateId) {
		this.attworkdateId = attworkdateId;
	}

	public AttWorkDateBO getBo() {
		return bo;
	}

	public void setBo(AttWorkDateBO bo) {
		this.bo = bo;
	}

	public String getTimeObject() {
		return timeObject;
	}

	public void setTimeObject(String timeObject) {
		this.timeObject = timeObject;
	}

	public boolean getIsExist() {
		return isExist;
	}

	public void setIsExist(boolean isExist) {
		this.isExist = isExist;
	}

	public String getWorkDatelists() {
		return workDatelists;
	}

	public void setWorkDatelists(String workDatelists) {
		this.workDatelists = workDatelists;
	}

	public String getInitEdit() {
		try {
			if (super.getRequestParameter("feastID") != null
					&& !super.getRequestParameter("feastID").equals("")
					&& super.getRequestParameter("oid") != null
					&& !super.getRequestParameter("oid").equals("")
					&& super.getRequestParameter("okId") != null
					&& !super.getRequestParameter("okId").equals("")) {
				feastID = super.getRequestParameter("feastID");
				orgId = super.getRequestParameter("oid");
				String okId = super.getRequestParameter("okId");
				bo = new AttWorkDateBO();
				bo.setWorkDate("");
				workDatelists = "";
				isExist = true;
			} else if (super.getRequestParameter("attworkdateId") != null
					&& !super.getRequestParameter("attworkdateId").equals("")
					&& super.getRequestParameter("feastID") != null
					&& !super.getRequestParameter("feastID").equals("")
					&& super.getRequestParameter("oid") != null
					&& !super.getRequestParameter("oid").equals("")) {
				attworkdateId = super.getRequestParameter("attworkdateId");
				feastID = super.getRequestParameter("feastID");
				orgId = super.getRequestParameter("oid");
				bo = attenceSetUCC.findAttWorkDateBObyId(attworkdateId);
				workDatelists = "";
				isExist = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public String doQuery() {
		try {
			lists = attenceSetUCC.getAllAttWorkDate(feastID, orgId);
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					AttWorkDateBO attworkdatebo = (AttWorkDateBO) lists.get(i);
					lists.set(i, attworkdatebo);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public String delete() {
		try {
			if (attworkdateId != null) {
				attenceSetUCC.deleteAttWorkDateBO(attworkdateId);
			}
		} catch (Exception e) {
			super.showMessageDetail("É¾³ýÊ§°Ü£¡");
		}
		return "";
	}

	public String save() {
		try {
			if (workDatelists != null && !"".equals(workDatelists)) {
				String[] strs = workDatelists.split(",");
				for (int i = 0; i < strs.length; i++) {
					AttWorkDateBO attworkdatebo = new AttWorkDateBO();
					attworkdatebo.setFeastId(feastID);
					attworkdatebo.setWorkDate(strs[i]);
					attworkdatebo.setOrgId(orgId);
					attenceSetUCC.saveorupdateAttWorkDate(attworkdatebo);
				}
			} else {
				super.showMessageDetail("ÇëÑ¡Ôñµ¹ÐÝÈÕÆÚ£¡");
				return "";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	public String update() {
		try {
			if (bo.getWorkDate() != null && !"".equals(bo.getWorkDate())) {
				bo.setFeastId(feastID);
				bo.setOrgId(orgId);
				attenceSetUCC.saveorupdateAttWorkDate(bo);
			} else {
				super.showMessageDetail("ÇëÑ¡Ôñµ¹ÐÝÈÕÆÚ£¡");
				return "";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}
}
