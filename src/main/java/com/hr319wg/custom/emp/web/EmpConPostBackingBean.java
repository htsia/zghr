package com.hr319wg.custom.emp.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.common.service.ICommonService;
import com.hr319wg.custom.pojo.bo.UserBO;
import com.hr319wg.emp.pojo.bo.ConPostBO;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;

public class EmpConPostBackingBean extends BaseBackingBean {

	private String pageInit;
	private String editInit;
	private String superID;
	private String personID;
	private String deptID;
	private String postID;
	private String conDate;
	private String operUserID;
	private String operConPostID;
	private ICommonService commonService;
	private List list;

	public String getConDate() {
		return conDate;
	}

	public void setConDate(String conDate) {
		this.conDate = conDate;
	}

	public String getOperConPostID() {
		return operConPostID;
	}

	public void setOperConPostID(String operConPostID) {
		this.operConPostID = operConPostID;
	}

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	public String getOperUserID() {
		return operUserID;
	}

	public void setOperUserID(String operUserID) {
		this.operUserID = operUserID;
	}

	public String getEditInit() {
		String act = super.getRequestParameter("act");
		if ("init".equals(act)) {
			this.personID = null;
			this.deptID = null;
			this.postID = null;
			this.conDate=CommonFuns.getSysDate("yyyy-MM-dd");
		}
		return editInit;
	}

	public void setEditInit(String editInit) {
		this.editInit = editInit;
	}

	public String getPersonID() {
		return personID;
	}

	public void setPersonID(String personID) {
		this.personID = personID;
	}

	public String getDeptID() {
		return deptID;
	}

	public void setDeptID(String deptID) {
		this.deptID = deptID;
	}

	public String getPostID() {
		return postID;
	}

	public void setPostID(String postID) {
		this.postID = postID;
	}

	public String getSuperID() {
		return superID;
	}

	public void setSuperID(String superID) {
		this.superID = superID;
	}

	public String getPageInit() {
		String superID1 = super.getRequestParameter("superId");
		if (superID1 != null && !"".equals(superID1)) {
			this.superID = superID1;
		}
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public ICommonService getCommonService() {
		return commonService;
	}

	public void setCommonService(ICommonService commonService) {
		this.commonService = commonService;
	}

	public void doQuery() {
		this.list = new ArrayList();
		try {
			List list = this.commonService.getAllConPostBO(this.superID);
			if (list == null) {
				list = new ArrayList<UserBO>();
			}
			for (int i = 0; i < list.size(); i++) {
				Object[] obj = (Object[]) list.get(i);
				ConPostBO post = (ConPostBO)obj[0];
				UserBO user = (UserBO) obj[1];
				Map m = new HashMap();
				m.put("conPostID", post.getConPostID());
				m.put("conDate", post.getConDate());
				m.put("id", user.getUserID());
				m.put("name", user.getName());
				m.put("pCode", user.getPersonSeq());
				m.put("orgName", CodeUtil.interpertCode(CodeUtil.TYPE_ORG, user.getOrgId()));
				m.put("deptName", CodeUtil.interpertCode(CodeUtil.TYPE_ORG, user.getDeptId()));
				m.put("postName", CodeUtil.interpertCode(CodeUtil.TYPE_POST, user.getPostId()));
				this.list.add(m);
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}

	public String save() {
		try {
			this.commonService.saveConPost(super.getUserInfo(), personID, deptID, postID, this.conDate);
			return "success";
		} catch (SysException e) {
			e.printStackTrace();
		}
		return null;
	}

	public void cancel() {
		try {
			this.commonService.updateCancelConPost(operConPostID, operUserID);
			super.showMessageDetail("取消完成");
		} catch (SysException e) {
			super.showMessageDetail("取消失败");
			e.printStackTrace();
		}
	}
}
