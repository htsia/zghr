package com.hr319wg.rpt.web;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.rpt.pojo.bo.RptClassBO;
import com.hr319wg.rpt.pojo.bo.RptGroupDirBO;
import com.hr319wg.rpt.pojo.bo.RptSetBO;
import com.hr319wg.rpt.pojo.bo.RptSetItemBO;
import com.hr319wg.rpt.ucc.IRptInfoUCC;

public class RptSetListBackBean extends BaseBackingBean {
	private String pageInit;
	private IRptInfoUCC rptucc;
	private List rptSetItemList;
	private List rptSetList;
	private String editRptSetInit;
	private String editRptSetItemInit;
	private RptSetBO repSetBO = new RptSetBO();
	private RptSetItemBO rptSetItemBO = new RptSetItemBO();
	private String rptSetId = "";
	private String resultvalues;
	private String resultvaluess;

	public String getPageInit() {
		if ((super.getRequestParameter("superId") != null)
				&& (!"".equals(super.getRequestParameter("superId")))) {
			this.rptSetId = super.getRequestParameter("superId");
		}
		doQuery();
		return this.pageInit;
	}

	public void doQuery() {
		try {
			this.rptSetItemList = this.rptucc
					.getRptSetItemBOList(this.rptSetId);
			if ((this.rptSetItemList != null)
					&& (this.rptSetItemList.size() > 0))
				for (int i = 0; i < this.rptSetItemList.size(); i++) {
					RptSetItemBO tempBO = (RptSetItemBO) this.rptSetItemList
							.get(i);
					RptClassBO bos = this.rptucc.getRptClass(tempBO
							.getRptCode() + "");
					if (bos != null) {
						if ((bos.getRptDesc() != null)
								&& (!"".equals(bos.getRptDesc()))) {
							tempBO.setRptCodeName(bos.getRptDesc());
						} else
							tempBO.setRptCodeName("");
					}

					this.rptSetItemList.set(i, tempBO);
				}
		} catch (SysException e) {
			System.out.println(e.getMessage());
		}
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public String saveOrUpdateRptSetItem() {
		try {
			if ((this.resultvaluess != null)
					&& (!"".equals(this.resultvaluess))) {
				String[] strs = this.resultvaluess.split(",");
				for (int i = 0; i < strs.length; i++) {
					RptClassBO bo = this.rptucc.getRptClass(strs[i]);
					if ((bo != null) && ("0".equals(bo.getType()))) {
						continue;
					}
					RptSetItemBO rptSetItemBO1 = new RptSetItemBO();
					rptSetItemBO1.setRptCode(Integer.parseInt(strs[i]));
					rptSetItemBO1.setSetId(this.rptSetId);
					this.rptucc.saveOrUpdateRptSetItem(rptSetItemBO1);
					rptSetItemBO1.initPara();
					setResultvalues(null);
					setResultvaluess(null);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}

	public String getEditRptSetItemInit() {
		if ((super.getRequestParameter("curRptSetId") != null)
				&& (!"".equals(super.getRequestParameter("curRptSetId")))) {
			this.rptSetItemBO = new RptSetItemBO();
			this.rptSetId = super.getRequestParameter("curRptSetId");
		} else if ((super.getRequestParameter("rptItemId") != null)
				&& (!"".equals(super.getRequestParameter("rptItemId")))) {
			try {
				this.rptSetItemBO = this.rptucc.getRptSetItemBO(super
						.getRequestParameter("rptItemId"));
			} catch (SysException e) {
				System.out.println("添加出错[" + e.getMessage() + "]");
			}
		}
		return this.editRptSetItemInit;
	}

	public void setEditRptSetItemInit(String editRptSetItemInit) {
		this.editRptSetItemInit = editRptSetItemInit;
	}

	public String getRptSetId() {
		return this.rptSetId;
	}

	public void setRptSetId(String rptSetId) {
		this.rptSetId = rptSetId;
	}

	public String deleteRptSetItems() {
		String[] itemArray = getServletRequest().getParameterValues(
				"selected_ids");

		if ((itemArray != null) && (itemArray.length > 0)) {
			this.rptucc.deleteRptSetItems(itemArray);
		}
		return "";
	}

	public String deleteRptSetBO() {
		if ((this.rptSetId != null) && (!"".equals(this.rptSetId))) {
			this.repSetBO.setSetId(this.rptSetId);
			try {
				this.rptucc.deleteRptSetBO(this.repSetBO);
			} catch (SysException e) {
				System.out.println("删除出错[" + e.getMessage() + "]");
				e.printStackTrace();
			}
		}
		return "";
	}

	public String saveOrUpdateRptSetBO() {
		try {
			if ((this.repSetBO.getAchivesType() == null)
					|| ("".equals(this.repSetBO.getAchivesType()))) {
				this.repSetBO.setAchivesType("0");
			}

			this.rptucc.saveOrUpdateRptSetBO(this.repSetBO);
		} catch (SysException e) {
			System.out.println("更新或者添加出错[" + e.getMessage() + "]");
		}
		return "success";
	}

	public String getEditRptSetInit() {
		try {
			if ((super.getRequestParameter("rptcode") != null)
					&& (!"".equals(super.getRequestParameter("rptcode")))) {
				this.repSetBO = this.rptucc.getRptSetBO(super
						.getRequestParameter("rptcode"));
				if ((this.repSetBO.getAchivesType() == null)
						|| ("".equals(this.repSetBO.getAchivesType()))) {
					this.repSetBO.setAchivesType("0");
				}
				RptGroupDirBO groupDirBO = this.rptucc
						.getGroupDirBO(this.repSetBO.getGroupId());
				if (groupDirBO != null) {
					this.repSetBO.setGroupName(groupDirBO.getDirName());
				}
			} else if ((super.getRequestParameter("ok") != null)
					&& (!"".equals(super.getRequestParameter("ok")))) {
				this.repSetBO.initPara();
			}
		} catch (SysException e) {
			System.out.println("查询出错[" + e.getMessage() + "]");
		}
		return this.editRptSetInit;
	}

	public void setEditRptSetInit(String editRptSetInit) {
		this.editRptSetInit = editRptSetInit;
	}

	public List getRptSetItemList() {
		return this.rptSetItemList;
	}

	public void setRptSetItemList(List rptSetItemList) {
		this.rptSetItemList = rptSetItemList;
	}

	public IRptInfoUCC getRptucc() {
		return this.rptucc;
	}

	public void setRptucc(IRptInfoUCC rptucc) {
		this.rptucc = rptucc;
	}

	public RptSetBO getRepSetBO() {
		return this.repSetBO;
	}

	public void setRepSetBO(RptSetBO repSetBO) {
		this.repSetBO = repSetBO;
	}

	public RptSetItemBO getRptSetItemBO() {
		return this.rptSetItemBO;
	}

	public void setRptSetItemBO(RptSetItemBO rptSetItemBO) {
		this.rptSetItemBO = rptSetItemBO;
	}

	public List getRptSetList() {
		return this.rptSetList;
	}

	public void setRptSetList(List rptSetList) {
		this.rptSetList = rptSetList;
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
}