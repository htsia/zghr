package com.hr319wg.emp.web;

import com.hr319wg.common.Constants;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.common.service.ICommonService;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.util.CommonFuns;

public class PersonAdjustShowBackingBean extends BaseBackingBean {
	private String unitId;
	private String unitName;
	private String flag;
	private String inputDate;
	private IPersonUCC personucc;
	private ICommonService commonService;
	

	public ICommonService getCommonService() {
		return commonService;
	}

	public void setCommonService(ICommonService commonService) {
		this.commonService = commonService;
	}

	public IPersonUCC getPersonucc() {
		return this.personucc;
	}

	public void setPersonucc(IPersonUCC ucc) {
		this.personucc = ucc;
	}

	public String getPageInit() {
		String unitId1=super.getRequestParameter("superId");
		if(unitId1!=null && !"".equals(unitId1)){
			this.unitId=unitId1;
		}
		this.unitName = SysCacheTool.findOrgById(this.unitId).getName();
		query();
		return this.pageInit;
	}

	public void query() {
		try {
			super.getHttpSession().removeAttribute("OBJECT");
			super.getHttpSession().removeAttribute("activeSql");
			super.getHttpSession().removeAttribute("pageNum");
			super.getHttpSession().removeAttribute("rowNum");

			TableVO table = new TableVO();
			String filter = "";
			if (this.inputDate != null && !"".equals(this.inputDate)) {
				filter = "B733702='" + this.inputDate + "'";
			}
			String sql = this.personucc.getAdjustInfo(table, this.unitId, filter);
			turnPageQuery(table, sql, 1, 0);
		} catch (Exception e) {
			super.showMessageDetail("´íÎó£º" + e.getMessage());
		}
	}

	public String turnPageQuery(TableVO table, String sql, int pageNum, int rowNum) {
		try {
			if (pageNum == 0)
				pageNum = Integer.parseInt(CommonFuns.filterNullToZero(super.getRequestParameter("pageNum")));
			if (pageNum == 0)
				pageNum = Integer.parseInt(CommonFuns.filterNullToZero((String) super.getHttpSession().getAttribute("pageNum")));
			if (pageNum == 0) {
				pageNum = 1;
			}
			if (rowNum == 0)
				rowNum = Integer.parseInt(CommonFuns.filterNullToZero(super.getRequestParameter("rowNum")));
			if (rowNum == 0)
				rowNum = Integer.parseInt(CommonFuns.filterNullToZero((String) super.getHttpSession().getAttribute("rowNum")));
			if (rowNum == 0)
				rowNum = Constants.ACTIVE_PAGE_SIZE;
			if (table == null)
				table = (TableVO) super.getHttpSession().getAttribute("OBJECT");
			if (sql == null) {
				sql = (String) super.getHttpSession().getAttribute("activeSql");
			}
			table = this.personucc.queryPersonBySql(table, sql, pageNum, rowNum);
			super.getHttpSession().setAttribute("activeSql", sql);
			super.getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
			super.getHttpSession().setAttribute("pageNum", String.valueOf(pageNum));
			super.getHttpSession().setAttribute("OBJECT", table);
		} catch (Exception e) {
			super.showMessageDetail("´íÎó£º" + e.getMessage());
		}
		return null;
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

	public String getInputDate() {
		return this.inputDate;
	}

	public void setInputDate(String Name) {
		this.inputDate = Name;
	}

	public String getFlag() {
		return this.flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}
}