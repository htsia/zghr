package com.hr319wg.rpt.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.rpt.pojo.bo.RptClassBO;
import com.hr319wg.rpt.ucc.IRptInfoUCC;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.user.pojo.bo.ModuleBO;
import com.hr319wg.user.pojo.bo.OperateBO;
import com.hr319wg.user.pojo.bo.UserRptBO;
import com.hr319wg.user.ucc.IUserManageUCC;

public class ReportPowerMgrBackingBean extends BaseBackingBean {
	private String pageInits;
	private String resultvalues;
	private String resultvaluess;
	private List itemList = new ArrayList();
	private IUserManageUCC useruserManageUccImpl;
	private List detailList = new ArrayList();
	private String operID;
	private String roleID;
	private IRptInfoUCC rptucc;

	public String getRoleID() {
		return roleID;
	}

	public void setRoleID(String roleID) {
		this.roleID = roleID;
	}

	public String getOperID() {
		return this.operID;
	}

	public void setOperID(String operID) {
		this.operID = operID;
	}

	public void changeDetailValue1(ValueChangeEvent event) {
		this.operID = event.getNewValue().toString();
	}

	public List getItemList() {
		return this.itemList;
	}

	public void setItemList(List itemList) {
		this.itemList = itemList;
	}

	public IRptInfoUCC getRptucc() {
		return this.rptucc;
	}

	public void setRptucc(IRptInfoUCC rptucc) {
		this.rptucc = rptucc;
	}

	public IUserManageUCC getUseruserManageUccImpl() {
		return this.useruserManageUccImpl;
	}

	public void setUseruserManageUccImpl(IUserManageUCC useruserManageUccImpl) {
		this.useruserManageUccImpl = useruserManageUccImpl;
	}

	public List getDetailList() {
		doQueryDetail();
		return this.detailList;
	}

	public void setDetailList(List detailList1) {
		this.detailList = detailList1;
	}

	public String getResultvalues() {
		return this.resultvalues;
	}

	public void setResultvalues(String resultvalues) {
		this.resultvalues = resultvalues;
	}

	public String getResultvaluess() {
		return this.resultvaluess;
	}

	public void setResultvaluess(String resultvaluess) {
		this.resultvaluess = resultvaluess;
	}

	public String getPageInits() {
		return this.pageInits;
	}

	public void setPageInits(String pageInits) {
		this.pageInits = pageInits;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public String getPageInit() {
		if ((this.detailList != null) && (this.detailList.size() > 0)) {
			this.detailList = new ArrayList();
		}
		String roleID1=super.getRequestParameter("roleID");
		if(roleID1!=null && !"".equals(roleID1)){
			this.roleID=roleID1;
		}
		doQuery();
		return this.pageInit;
	}

	public String doQuery() {
		if ((this.itemList != null) && (this.itemList.size() > 0))
			this.itemList = new ArrayList();
		try {
			List listsss = this.rptucc.getUserRptBO(this.roleID, this.operID);
			if ((listsss != null) && (listsss.size() > 0))
				for (int i = 0; i < listsss.size(); i++) {
					UserRptBO bo = (UserRptBO) listsss.get(i);
					RptClassBO bos = this.rptucc.getRptClass(bo.getRptCode());
					if ((bos.getRptDesc() != null) && (!"".equals(bos.getRptDesc()))) {
						bo.setRptCodeName(bos.getRptDesc());
						bo.setRptCode(bos.getRptcode());
					} else {
						bo.setRptCodeName("");
						bo.setRptCode("");
					}
					this.itemList.add(bo);
				}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "";
	}

	public void doQueryDetail() {
		try {
			if ((this.detailList != null) && (this.detailList.size() > 0)) {
				this.detailList = new ArrayList();
			}
			List listss = this.useruserManageUccImpl.getHaveRptOperate();
			if ((listss != null) && (listss.size() > 0))
				for (int i = 0; i < listss.size(); i++) {
					OperateBO bo = (OperateBO) listss.get(i);
					if (!OperateBO.RPTMODULEID.equals(bo.getModuleID())) {
						String operateNames = "";
						if ((bo.getModuleID() != null) && (!"".equals(bo.getModuleID()))) {
							ModuleBO modulebo = SysCacheTool.findModule(bo.getModuleID());
							if (modulebo != null) {
								operateNames = modulebo.getModuleName();
							}
						}
						SelectItem si = new SelectItem();
						si.setLabel(operateNames + "->" + bo.getOperateName());
						si.setValue(bo.getOperateId());
						this.detailList.add(si);
					}
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String deleteBatch() {
		String[] ids = getServletRequest().getParameterValues("selected_ids");
		try {
			for (int i = 0; i < ids.length; i++) {
				this.rptucc.deleteUserRptBO(ids[i]);
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "";
	}

	public String save() {
		try {
			if ((this.resultvaluess != null) && (!"".equals(this.resultvaluess))) {
				String[] strs = this.resultvaluess.split(",");
				String[] strsss = this.resultvalues.split(",");
				for (int i = 0; i < strs.length; i++) {
					List listsss = this.rptucc.getUserRptBO1(this.roleID, this.operID, strs[i]);
					if ((listsss != null) && (listsss.size() > 0)) {
						UserRptBO bo = (UserRptBO) listsss.get(0);
						if (strs[i].equals(bo.getRptCode())) {
							continue;
						}
					}
					RptClassBO bo = this.rptucc.getRptClass(strs[i]);
					if ("0".equals(bo.getType())) {
						continue;
					}
					UserRptBO bos = new UserRptBO();
					bos.setRoleID(this.roleID);
					bos.setOperateID(this.operID);
					bos.setRptCode(strs[i]);
					bos.setShowQue("9999");
					this.rptucc.saveorupdateUserRptBO(bos);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}

		return "";
	}

	public String saveSort() {
		try {
			String[] orgids = getServletRequest().getParameterValues("showItem");
			String superSort = "";
			for (int i = 0; i < orgids.length; i++) {
				UserRptBO userrptbo = this.rptucc.getUserRptBO(orgids[i]);
				if (i < 9){
					userrptbo.setShowQue(superSort + "00" + (i + 1));
				}else if (i < 99){
					userrptbo.setShowQue(superSort + "0" + (i + 1));
				}else {
					userrptbo.setShowQue(superSort + (i + 1));
				}
				this.rptucc.saveorupdateUserRptBO(userrptbo);
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}
}