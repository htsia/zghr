package com.hr319wg.lead.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.model.SelectItem;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.lead.pojo.bo.LeadResourceBO;
import com.hr319wg.lead.pojo.vo.LeadResVO;
import com.hr319wg.lead.ucc.IResMaintenanceUCC;

public class ResMaintenanceBackingBean extends BaseBackingBean {
	private IResMaintenanceUCC resmaintenanceucc;
	private List showtypelist;
	private List showtypevolist = null;
	private boolean savebuttdis = true;
	private String beginEdit;
	private LeadResVO stVO;
	private LeadResourceBO leadResBO;
	private String resID;
	private static SelectItem[] levelselects = { new SelectItem("01", "日频抽取"),
			new SelectItem("02", "月频抽取"), new SelectItem("03", "季频抽取"),
			new SelectItem("04", "半年频抽取"), new SelectItem("05", "年频抽取") };

	private static SelectItem[] yesselects = { new SelectItem("1", "是(1)"),
			new SelectItem("0", "否(0)") };

	private static SelectItem[] showtypes = { new SelectItem("T", "文本条"),
			new SelectItem("L", "表格"), new SelectItem("C", "图表"),
			new SelectItem("H", "html文本") };

	public String getResID() {
		return this.resID;
	}

	public void setResID(String id) {
		this.resID = id;
	}

	public LeadResourceBO getLeadResBO() {
		return this.leadResBO;
	}

	public void setLeadResBO(LeadResourceBO bo) {
		this.leadResBO = bo;
	}

	public String getPageInit() {
		leadinit();
		return null;
	}

	public String getBeginEdit() {
		String ID = super.getRequestParameter("ID");
		if ((ID != null) && (!"".equals(ID))) {
			this.leadResBO = this.resmaintenanceucc.findLeadResource(ID);
		}
		String act = super.getRequestParameter("act");
		if ("init".equals(act)) {
			this.leadResBO = new LeadResourceBO();
		}
		return this.beginEdit;
	}

	public void setBeginEdit(String edit) {
		this.beginEdit = edit;
	}

	public String save() {
		try {
			this.resmaintenanceucc.saveLeadResourceBO(this.leadResBO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	public void deleTypeList() {
		List dellist = new ArrayList();
		dellist.add(this.resmaintenanceucc.findLeadResource(this.resID));
		deleByObj(dellist);
		this.showtypevolist = null;
	}

	private void deleByObj(List list) {
		try {
			this.resmaintenanceucc.deleByObj(list);
		} catch (SysException e) {
			showMessageDetail("数据删除失败");
			e.printStackTrace();
		} catch (Exception e) {
			showMessageDetail("数据删除失败");
			e.printStackTrace();
		}
	}

	public String leadinit() {
		this.showtypevolist = new ArrayList();
		try {
			this.showtypelist = this.resmaintenanceucc.queryForMaint();
			if (this.showtypelist == null)
				return "notfound";
			for (int i = 0; i < this.showtypelist.size(); i++) {
				LeadResourceBO leadshowtypeBO = (LeadResourceBO) this.showtypelist
						.get(i);
				this.stVO = new LeadResVO(leadshowtypeBO, false, false);
				String tt = this.stVO.getStoreTable();

				for (int j = 0; j < showtypes.length; j++) {
					if (tt.equals(showtypes[j].getValue())) {
						this.stVO.setStoreTable(showtypes[j].getLabel());
						break;
					}
				}

				tt = this.stVO.getUpdateFrequency();
				for (int j = 0; j < levelselects.length; j++) {
					if (tt.equals(levelselects[j].getValue())) {
						this.stVO
								.setUpdateFrequency(levelselects[j].getLabel());
						break;
					}
				}
				if ("1".equals(this.stVO.getIsuse())) {
					this.stVO.setIsuse("启用");
				} else {
					this.stVO.setIsuse("禁用");
				}
				this.showtypevolist.add(this.stVO);
			}
		} catch (SysException e) {
			showMessageDetail("查找展示代码表出错.");
		} catch (Exception e) {
			e.printStackTrace();
			showMessageDetail("查找展示代码表出错.");
		}
		return null;
	}

	public void statchanged() {
		this.savebuttdis = false;
	}

	public SelectItem[] getLevelselects() {
		return levelselects;
	}

	public SelectItem[] getYesselects() {
		return yesselects;
	}

	public boolean isSavebuttdis() {
		return this.savebuttdis;
	}

	public void setSavebuttdis(boolean savebuttdis) {
		this.savebuttdis = savebuttdis;
	}

	public List getShowtypelist() {
		return this.showtypelist;
	}

	public void setShowtypelist(List showtypelist) {
		this.showtypelist = showtypelist;
	}

	public List getShowtypevolist() {
		return this.showtypevolist;
	}

	public void setShowtypevolist(List showtypevolist) {
		this.showtypevolist = showtypevolist;
	}

	public IResMaintenanceUCC getResmaintenanceucc() {
		return this.resmaintenanceucc;
	}

	public void setResmaintenanceucc(IResMaintenanceUCC resmaintenanceucc) {
		this.resmaintenanceucc = resmaintenanceucc;
	}

	public SelectItem[] getShowtypes() {
		return showtypes;
	}
}