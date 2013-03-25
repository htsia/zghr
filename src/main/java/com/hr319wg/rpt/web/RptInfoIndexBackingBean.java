package com.hr319wg.rpt.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.common.service.ICommonService;
import com.hr319wg.rpt.pojo.bo.RptClassBO;
import com.hr319wg.rpt.pojo.bo.RptDataBO;
import com.hr319wg.rpt.pojo.bo.RptDateListBO;
import com.hr319wg.rpt.pojo.bo.RptSetBO;
import com.hr319wg.rpt.pojo.bo.RptSetItemBO;
import com.hr319wg.rpt.pojo.bo.RptSetUserBO;
import com.hr319wg.rpt.pojo.vo.RptInfoVO;
import com.hr319wg.rpt.ucc.IRptInfoUCC;
import com.hr319wg.user.ucc.IUserManageUCC;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;

public class RptInfoIndexBackingBean extends BaseBackingBean {
	private final String OperID = "0721";
	private String unitId;
	private String unitName;
	private String processDate;
	private String dateId;
	private List dateList;
	private IRptInfoUCC rptucc;
	private RptDateListBO date = new RptDateListBO();
	private RptSetBO rptSetBO = new RptSetBO();
	private String staticdate;
	private String staticWeek;
	private String initDocument;
	private String docRptids;
	private String docRptnames;
	private String initShow;
	private String initShowchild;
	private String inithandBook;
	private boolean canApply = false;
	private String setName;
	private String setID;
	private boolean flowState;
	private boolean showWeek = false;
	private String initSelectMonth;
	private List setList;
	private ICommonService commonService;

	public ICommonService getCommonService() {
		return commonService;
	}

	public void setCommonService(ICommonService commonService) {
		this.commonService = commonService;
	}

	public boolean isShowWeek() {
		return this.showWeek;
	}

	public void setShowWeek(boolean showWeek) {
		this.showWeek = showWeek;
	}

	public String getInitSelectMonth() {
		try {
			if ((super.getRequestParameter("rptSet") != null)
					&& (!"".equals(super.getRequestParameter("rptSet")))) {
				RptSetBO bo = this.rptucc.getRptSetBO(super
						.getRequestParameter("rptSet"));
				if ("4".equals(bo.getAchivesType())) {
					this.showWeek = true;
				} else {
					this.showWeek = false;
				}
			}
		} catch (Exception e) {
		}
		return this.initSelectMonth;
	}

	public void setInitSelectMonth(String initSelectMonth) {
		this.initSelectMonth = initSelectMonth;
	}

	public String doApply() {
		try {
			RptDateListBO bo = this.rptucc.getDateBo(this.dateId);
			this.rptSetBO = this.rptucc.getRptSetBO(this.setID);
			if ("1".equals(this.rptSetBO.getIsFlow())) {
				bo.setStauts("1");
				this.rptucc.saveDate(bo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	public String endReprot() {
		try {
			RptDateListBO bo = this.rptucc.getDateBo(this.dateId);
			bo.setStauts("2");
			this.rptucc.saveDate(bo);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "";
	}

	public boolean getFlowState() {
		try {
			this.rptSetBO = this.rptucc.getRptSetBO(this.setID);
			if (this.rptSetBO != null)
				if ("1".equals(this.rptSetBO.getIsFlow()))
					this.flowState = false;
				else if ("0".equals(this.rptSetBO.getIsFlow()))
					this.flowState = true;
		} catch (SysException e) {
			e.printStackTrace();
		}
		return this.flowState;
	}

	public void setFlowState(boolean flowState) {
		this.flowState = flowState;
	}

	public String getOperID() {
		return "0721";
	}

	public String getSetName() {
		return this.setName;
	}

	public void setSetName(String setName) {
		this.setName = setName;
	}

	public List getSetList() {
		return this.setList;
	}

	public void setSetList(List setList) {
		this.setList = setList;
	}

	public String getSetID() {
		return this.setID;
	}

	public void setSetID(String setID) {
		this.setID = setID;
	}

	public boolean isCanApply() {
		return this.canApply;
	}

	public void setCanApply(boolean b) {
		this.canApply = b;
	}

	public String getInitShowchild() {
		if (super.getRequestParameter("staticdate") != null) {
			this.staticdate = super.getRequestParameter("staticdate");
			super.getServletRequest().setAttribute("time", this.staticdate);
			this.unitId = super.getRequestParameter("unitId");
			this.unitName = CodeUtil.interpertCode(CodeUtil.TYPE_ORG,
					this.unitId);
			super.getServletRequest().setAttribute("orgId", this.unitId);
			this.initShow = "true";
		}
		return this.initShowchild;
	}

	public void setInitShowchild(String show) {
		this.initShowchild = show;
	}

	public String getInithandBook() {
		if (super.getRequestParameter("processDate") != null) {
			this.staticdate = super.getRequestParameter("processDate");
			this.unitId = Constants.ORG_BENBU;
			this.unitName = CodeUtil.interpertCode(CodeUtil.TYPE_ORG,
					this.unitId);
		}
		return this.inithandBook;
	}

	public void setInithandBook(String show) {
		this.inithandBook = show;
	}

	public String getInitShow() {
		if (super.getRequestParameter("staticdate") != null) {
			this.staticdate = super.getRequestParameter("staticdate");
			super.getServletRequest().setAttribute("time", this.staticdate);
			this.unitId = super.getRequestParameter("unitId");
			this.unitName = CodeUtil.interpertCode(CodeUtil.TYPE_ORG,
					this.unitId);
			super.getServletRequest().setAttribute("orgId", this.unitId);
			this.initShow = "true";
		}
		return this.initShow;
	}

	public void setInitShow(String show) {
		this.initShow = show;
	}

	public String getDateId() {
		return this.dateId;
	}

	public void setDateId(String id) {
		this.dateId = id;
	}

	public String getDocRptnames() {
		return this.docRptnames;
	}

	public void setDocRptnames(String doc) {
		this.docRptnames = doc;
	}

	public String getDocRptids() {
		return this.docRptids;
	}

	public void setDocRptids(String doc) {
		this.docRptids = doc;
	}

	public String getInitDocument() {
		this.setID = super.getRequestParameter("setID");
		try {
			if (super.getRequestParameter("date") != null) {
				this.processDate = super.getRequestParameter("date");
				User user = (User) (User) getHttpSession().getAttribute(
						"USER_INFO");
				this.unitId = user.getOrgId();
				this.unitName = user.getOrgName();
				this.docRptids = super.getRequestParameter("ReportIDs");
				this.canApply = true;
				this.dateId = super.getRequestParameter("dateId");
				String[] ids = this.docRptids.split("\\^");
				this.docRptnames = "";
				if (ids.length > 0) {
					for (int i = 0; i < ids.length; i++) {
						RptDataBO databo = this.rptucc.getRptStaticInfo(
								this.unitId, ids[i]);
						RptInfoVO rpt = this.rptucc.queryRptInfo(ids[i]);
						String des = rpt.getDescription();
						if (databo == null) {
							des = des + "[未生成]";
							this.canApply = false;
						} else {
							des = des + "[ " + databo.getInnerCheckDes() + " "
									+ databo.getOutterCheckDes() + "]";
							if ((!"1".equals(databo.getInnerCheck()))
									|| (!"1".equals(databo.getOutterCheck()))) {
								this.canApply = false;
							}
						}

						if ("".equals(this.docRptnames)) {
							this.docRptnames = des;
						} else {
							this.docRptnames = (this.docRptnames + "\r\n" + des);
						}
					}
				}
			}
		} catch (Exception e) {
		}

		return this.initDocument;
	}

	public void setInitDocument(String doc) {
		this.initDocument = doc;
	}

	public String getStaticdate() {
		return this.staticdate;
	}

	public void setStaticdate(String des) {
		this.staticdate = des;
	}

	public String getStaticWeek() {
		return this.staticWeek;
	}

	public void setStaticWeek(String staticWeek) {
		this.staticWeek = staticWeek;
	}

	public RptDateListBO getDate() {
		return this.date;
	}

	public void setDate(RptDateListBO da) {
		this.date = da;
	}

	public String saveDate() {
		try {
			User user = super.getUserInfo();
			this.date.setOrguid(user.getOrgId());
			this.date.setCreateID(user.getUserId());
			this.date.setStauts("0");
			this.date.setRptSet(this.setID);

			if (this.rptucc.haveNotFinish(user.getOrgId(), this.setID)) {
				super.showMessageDetail("还没有结束以前的报表工作，不能新建！");
				return "";
			}
			this.rptucc.saveDate(this.date);
			queryDateList();
		} catch (Exception e) {
		}
		return "";
	}

	public IRptInfoUCC getRptucc() {
		return this.rptucc;
	}

	public void setRptucc(IRptInfoUCC ucc) {
		this.rptucc = ucc;
	}

	public void changeDateList(ValueChangeEvent event) {
		this.setID = ((String) event.getNewValue());
		queryDateList();
	}

	public String queryDateList() {
		try {
			this.dateList = new ArrayList();
			List list = this.rptucc.queryDateListInfo(super.getUserInfo()
					.getOrgId());
			if (list != null)
				for (int i = 0; i < list.size(); i++) {
					RptDateListBO rb = (RptDateListBO) list.get(i);
					if ((this.setID != null) && (!"".equals(this.setID))
							&& (!this.setID.equals(rb.getRptSet()))) {
						continue;
					}
					rb.setCreateID(CodeUtil.interpertCode(CodeUtil.TYPE_PERSON,
							rb.getCreateID()));
					if ((rb.getRptSet() != null)
							&& (!"".equals(rb.getRptSet()))) {
						RptSetBO setbo = this.rptucc
								.getRptSetBO(rb.getRptSet());
						if (setbo != null) {
							rb.setSetName(setbo.getSetName());
							rb.setAchivesTypeDes(setbo.getAchivesTypeDes());
							this.showWeek = "4".equals(setbo.getAchivesType());
						}
					}
					this.dateList.add(rb);
				}
		} catch (Exception e) {
			this.dateList = new ArrayList();
		}
		return "";
	}

	public List getDateList() {
		return this.dateList;
	}

	public void setDateList(List list) {
		this.dateList = list;
	}

	public String getProcessDate() {
		if (this.processDate == null) {
			this.processDate = CommonFuns.getSysDate("yyyy-MM");
		}
		return this.processDate;
	}

	public void setProcessDate(String date) {
		this.processDate = date;
	}

	public String getPageInit() {
		try {
			if ("true".equals(super.getRequestParameter("Init"))) {
				User user = super.getUserInfo();
				this.unitId = user.getOrgId();
				this.unitName = user.getOrgName();

				List list = this.commonService.getRptList(user.getUserId());
				this.setList = new ArrayList();
				for (int i = 0; i < list.size(); i++) {
					RptSetUserBO setuserbo = (RptSetUserBO) list.get(i);
					RptSetBO setbo = this.rptucc.getRptSetBO(setuserbo
							.getSetId());

					SelectItem si = new SelectItem();
					si.setLabel(setbo.getSetName());
					si.setValue(setbo.getSetId());
					this.setList.add(si);
				}

				if (this.setList.size() > 0) {
					this.setID = ((SelectItem) (SelectItem) this.setList.get(0))
							.getValue().toString();
				}
				queryDateList();
			}
		} catch (Exception ee) {
		}
		return this.pageInit;
	}

	public String beginStatic() {
		try {
			User user = (User) (User) getHttpSession()
					.getAttribute("USER_INFO");
			this.unitId = user.getOrgId();
			this.unitName = user.getOrgName();
			PageVO page = new PageVO();
			page.setCurrentPage(1);
			page.setPageSize(1000);
			List list = this.rptucc.getRptSetItemBOList(page, this.setID);
			List reportList = new ArrayList();
			for (int i = 0; i < list.size(); i++) {
				RptSetItemBO rs = (RptSetItemBO) list.get(i);
				SelectItem si = new SelectItem();
				si.setValue(String.valueOf(rs.getRptCode()));
				RptClassBO classbo = this.rptucc.getRptClass(String.valueOf(rs
						.getRptCode()));
				if (classbo != null) {
					si.setLabel(classbo.getRptDesc());
				}
				reportList.add(si);
			}
			super.getHttpSession().setAttribute("reportList", reportList);
		} catch (Exception ee) {
		}
		return "beginStatic";
	}

	public String beginHisView() {
		try {
			User user = (User) (User) getHttpSession()
					.getAttribute("USER_INFO");
			this.unitId = user.getOrgId();
			this.unitName = user.getOrgName();
			super.getServletRequest().setAttribute("time", this.staticdate);
			super.getServletRequest().setAttribute("orgId", this.unitId);
			super.getServletRequest().setAttribute("setID", this.setID);
		} catch (Exception ee) {
		}
		return "beginHisView";
	}

	public String getUnitId() {
		return this.unitId;
	}

	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}

	public String getUnitName() {
		return this.unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	public RptSetBO getRptSetBO() {
		return this.rptSetBO;
	}

	public void setRptSetBO(RptSetBO rptSetBO) {
		this.rptSetBO = rptSetBO;
	}
}