package com.hr319wg.custom.common.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.faces.event.ValueChangeEvent;

import org.apache.myfaces.custom.fileupload.UploadedFile;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.common.service.ICommonService;
import com.hr319wg.custom.pojo.bo.ReportBO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.user.pojo.bo.RoleInfoBO;
import com.hr319wg.util.CodeUtil;

public class UploadReportBackingBean extends BaseBackingBean {

	private User user=super.getUserInfo();
	private String pageInit;
	private String editInit;
	private String scopeInit;
	private ICommonService commonService;
	private UploadedFile myFile;
	private String operID;
	private String operUserID;
	private String operRoleID;
	private List<ReportBO> list;
	private List<ReportBO> list2;
	private String scopeType;
	private List<Map> personList;
	private List<RoleInfoBO> roleList;
	private PageVO mypage = new PageVO();
	private ReportBO bo;
	private UploadedFile rptFile;

	public List<ReportBO> getList2() {
		List list=null;
		try {
			list = this.commonService.getReportBO(user, null);
		} catch (SysException e) {
			e.printStackTrace();
		}
		if(list==null){
			list=new ArrayList();
		}
		return list;
	}

	public void setList2(List<ReportBO> list2) {
		this.list2 = list2;
	}

	public String getOperUserID() {
		return operUserID;
	}

	public void setOperUserID(String operUserID) {
		this.operUserID = operUserID;
	}

	public String getOperRoleID() {
		return operRoleID;
	}

	public void setOperRoleID(String operRoleID) {
		this.operRoleID = operRoleID;
	}

	public String getScopeType() {
		return scopeType;
	}

	public void setScopeType(String scopeType) {
		this.scopeType = scopeType;
	}

	public List<Map> getPersonList() {
		return personList;
	}

	public void setPersonList(List<Map> personList) {
		this.personList = personList;
	}

	public List<RoleInfoBO> getRoleList() {
		return roleList;
	}

	public void setRoleList(List<RoleInfoBO> roleList) {
		this.roleList = roleList;
	}

	public void setScopeInit(String scopeInit) {
		this.scopeInit = scopeInit;
	}

	public UploadedFile getRptFile() {
		return rptFile;
	}

	public void setRptFile(UploadedFile rptFile) {
		this.rptFile = rptFile;
	}

	public void setEditInit(String editInit) {
		this.editInit = editInit;
	}

	public ReportBO getBo() {
		return bo;
	}

	public void setBo(ReportBO bo) {
		this.bo = bo;
	}

	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public List<ReportBO> getList() {
		return list;
	}

	public void setList(List<ReportBO> list) {
		this.list = list;
	}

	public String getOperID() {
		return operID;
	}

	public void setOperID(String operID) {
		this.operID = operID;
	}

	public UploadedFile getMyFile() {
		return myFile;
	}

	public void setMyFile(UploadedFile myFile) {
		this.myFile = myFile;
	}

	public ICommonService getCommonService() {
		return commonService;
	}

	public void setCommonService(ICommonService commonService) {
		this.commonService = commonService;
	}

	public String first() {
		mypage.setCurrentPage(1);
		return null;
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		return null;
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		return null;
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		return null;
	}

	public String getPageInit() {
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public void doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			
			this.list = this.commonService.getAllReportBO(this.mypage, null);
		} catch (SysException e) {
			e.printStackTrace();
		}
	}

	public void delete() {
		try {
			this.commonService.deleteReport(this.operID);
		} catch (SysException e) {
			e.printStackTrace();
		}
	}

	public String getEditInit() {
		String act = super.getRequestParameter("act");
		if ("init".equals(act)) {
			this.bo = new ReportBO();
		}
		String rptID = super.getRequestParameter("rptID");
		if (rptID != null && !"".equals(rptID)) {
			try {
				this.bo = (ReportBO) this.commonService.getObjBO(ReportBO.class, rptID);
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		return editInit;
	}

	public String save() {
		String path = super.getServletContext().getRealPath("/");
		try {
			this.commonService.saveReport(myFile, path, this.bo);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public String getScopeInit() {
		String itemID1 = super.getRequestParameter("itemID");
		if (itemID1 != null && !"".equals(itemID1)) {
			this.scopeType = "0";
			this.personList = new ArrayList<Map>();
			this.roleList = new ArrayList<RoleInfoBO>();

			this.operID = itemID1;
			try {
				this.bo = (ReportBO) this.commonService.getObjBO(ReportBO.class, itemID1);
				this.scopeType = this.bo.getScopeType();
				String userID = this.bo.getUserID();
				if (userID != null && !"".equals(userID)) {
					String[] userIDs = userID.split(",");
					for (int i = 0; i < userIDs.length; i++) {
						PersonBO p = SysCacheTool.findPersonById(userIDs[i]);
						if (p != null) {
							Map m = new HashMap();
							m.put("userID", p.getPersonId());
							m.put("pCode", p.getPersonCode());
							m.put("name", p.getName());
							m.put("org", CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getOrgId()));
							m.put("dept", CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
							this.personList.add(m);
						}
					}
				}

				String roleID = this.bo.getRoleID();
				if (roleID != null && !"".equals(roleID)) {
					String[] roleIDs = roleID.split(",");
					for (int i = 0; i < roleIDs.length; i++) {
						RoleInfoBO role = (RoleInfoBO) this.commonService.getObjBO(RoleInfoBO.class, roleIDs[i]);
						if (role != null) {
							this.roleList.add(role);
						}
					}
				}
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		return scopeInit;
	}

	public void selChanged(ValueChangeEvent event) {
		this.scopeType = (String) event.getNewValue();
	}

	public void addPerson() {
		PersonBO[] pers = (PersonBO[]) super.getHttpSession().getAttribute(Constants.SELPERSON_SESSION);
		if (pers != null) {
			for (PersonBO p : pers) {
				boolean has=false;
				for(Map m : personList){
					if(m.get("userID").equals(p.getPersonId())){
						has=true;
						break;
					}
				}
				if(!has){
					Map m = new HashMap();
					m.put("userID", p.getPersonId());
					m.put("pCode", p.getPersonCode());
					m.put("name", p.getName());
					m.put("org", CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getOrgId()));
					m.put("dept", CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
					this.personList.add(m);
				}
			}
		}
		super.getHttpSession().removeAttribute(Constants.SELPERSON_SESSION);
	}

	public void deletePerson() {
		List<Map> tempList = new ArrayList<Map>();
		for (Map m : personList) {
			if (!m.get("userID").equals(this.operUserID)) {
				tempList.add(m);
			}
		}
		this.personList = tempList;
	}

	public void addRole() {
		if(this.operRoleID!=null && !"".equals(this.operRoleID)){
			String[]roleIDs=this.operRoleID.split(",");
			for(int i=0;i<roleIDs.length;i++){
				try {
					boolean has=false;
					for(RoleInfoBO role : roleList){
						if(role.getRoleId().equals(roleIDs[i])){
							has=true;
							break;
						}
					}
					if(!has){
						RoleInfoBO role = (RoleInfoBO) this.commonService.getObjBO(RoleInfoBO.class, roleIDs[i]);
						this.roleList.add(role);						
					}
				} catch (SysException e) {
					e.printStackTrace();
				}
			}
		}
	}

	public void deleteRole() {
		List<RoleInfoBO> tempList = new ArrayList<RoleInfoBO>();
		for (RoleInfoBO role : roleList) {
			if (!role.getRoleId().equals(this.operRoleID)) {
				tempList.add(role);
			}
		}
		this.roleList = tempList;
	}

	public void saveScope() {
		String userID = "";
		String roleID = "";
		for (Map m : personList) {
			userID += m.get("userID") + ",";
		}
		for (RoleInfoBO role : roleList) {
			roleID += role.getRoleId() + ",";
		}
		try {
			this.commonService.saveRptScope(this.operID, this.scopeType, userID, roleID);
			super.showMessageDetail("…Ë÷√ÕÍ≥…");
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
}
