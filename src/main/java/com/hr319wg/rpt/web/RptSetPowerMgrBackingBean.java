package com.hr319wg.rpt.web;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import javax.faces.model.SelectItem;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.rpt.pojo.bo.RptSetBO;
import com.hr319wg.rpt.pojo.bo.RptSetUserBO;
import com.hr319wg.rpt.ucc.IRptInfoUCC;
import com.hr319wg.user.ucc.IUserManageUCC;

public class RptSetPowerMgrBackingBean extends BaseBackingBean {
	private List itemList = new ArrayList();
	private IUserManageUCC useruserManageUccImpl;
	private String roleID;
	private String rptSet;
	private IRptInfoUCC rptucc;
	private List rptSetList;

	public String getRoleID() {
		return roleID;
	}

	public void setRoleID(String roleID) {
		this.roleID = roleID;
	}

	public String getRptSet() {
		return this.rptSet;
	}

	public void setRptSet(String rptSet) {
		this.rptSet = rptSet;
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

	public void setRptSetList(List rptSetList) {
		this.rptSetList = rptSetList;
	}

	public String getPageInit() {
		String roleID1=super.getRequestParameter("roleID");
		if(roleID1!=null && !"".equals(roleID1)){
			this.roleID=roleID1;
		}
		doQuery();
		return this.pageInit;
	}
	
	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	
	public List getRptSetList() {
		try {
			List list = this.rptucc.getRptSetBOList();
			List userList = this.useruserManageUccImpl.getRptList(this.roleID);
			Hashtable ht = new Hashtable();
			for (int i = 0; i < userList.size(); i++) {
				RptSetUserBO rb = (RptSetUserBO) userList.get(i);
				ht.put(rb.getSetId(), rb.getSetId());
			}
			for (int i = 0; i < list.size(); i++) {
				RptSetBO rb = (RptSetBO) list.get(i);
				if (ht.get(rb.getSetId()) != null) {
					list.remove(i);
					i--;
				}
			}
			this.rptSetList = new ArrayList();
			for (int i = 0; i < list.size(); i++) {
				RptSetBO rb = (RptSetBO) list.get(i);
				SelectItem si = new SelectItem();
				si.setLabel(rb.getSetName());
				si.setValue(rb.getSetId());
				this.rptSetList.add(si);
			}
		} catch (Exception e) {
		}

		return this.rptSetList;
	}

	public String doQuery() {
		try {
			this.itemList = this.useruserManageUccImpl.getRptList(this.roleID);
			for (int i = 0; i < this.itemList.size(); i++) {
				RptSetUserBO bo = (RptSetUserBO) this.itemList.get(i);
				RptSetBO setbo = this.rptucc.getRptSetBO(bo.getSetId());
				if (setbo != null)
					bo.setSetName(setbo.getSetName());
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public String deleteBatch() {
		String[] ids = getServletRequest().getParameterValues("selected_ids");
		try {
			for (int i = 0; i < ids.length; i++)
				this.useruserManageUccImpl.deleteRptSetUserBO(ids[i]);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return null;
	}

	public String save() {
		try {
			if (this.useruserManageUccImpl.checkRptSetUserBO(this.roleID, this.rptSet)) {
				RptSetUserBO rb = new RptSetUserBO();
				rb.setRoleID(this.roleID);
				rb.setSetId(this.rptSet);
				this.useruserManageUccImpl.saveRptSetUserBO(rb);
			}
		} catch (Exception e) {
		}
		return null;
	}
}