package com.hr319wg.insurace.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.model.SelectItem;

import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.custom.ins.service.IInsDataService;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.insurace.ucc.IBaseSetUCC;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.RecordVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.util.CommonFuns;

public class PersonInsuraceBackingBean extends BaseBackingBean {
	private IBaseSetUCC basesetucc;
	private IPersonUCC personucc;
	private String pageInit;
	private String personType;
	private String changeType;
	private String changeDate;
	private String changeReason;
	private String depName;
	private String perIds;
	private String namelist;
	private List levelList;
	private String[] inputList;
	private String initSingleEdit;
	private String caclpersonType;
	private String selfPay;
	private IInsDataService insDataService;
	
	public String getPerIds() {
		return perIds;
	}

	public void setPerIds(String perIds) {
		this.perIds = perIds;
	}

	public IInsDataService getInsDataService() {
		return insDataService;
	}

	public void setInsDataService(IInsDataService insDataService) {
		this.insDataService = insDataService;
	}

	public String getSelfPay() {
		return selfPay;
	}

	public void setSelfPay(String selfPay) {
		this.selfPay = selfPay;
	}

	public String getChangeReason() {
		return changeReason;
	}

	public void setChangeReason(String changeReason) {
		this.changeReason = changeReason;
	}

	public IBaseSetUCC getBasesetucc() {
		return this.basesetucc;
	}

	public void setBasesetucc(IBaseSetUCC basesetucc) {
		this.basesetucc = basesetucc;
	}

	public String getPersonType() {
		return this.personType;
	}

	public void setPersonType(String type) {
		this.personType = type;
	}

	public String getInitSingleEdit() {
		try {
			if (super.getRequestParameter("perIds") != null) {
				this.perIds = super.getRequestParameter("perIds");
				PersonBO pb = SysCacheTool.findPersonById(this.perIds);
				this.namelist = pb.getName();

				TableVO table = this.personucc.queryPageInfo("A754",
						this.perIds, "", super.getUserInfo());
				String value = "";
				if (table.getRowData() != null) {
					RecordVO row = table.getRowData()[0];
					for (int i = 0; i < row.getCell().length; i++) {
						CellVO cell = row.getCell()[i];
						if ("00901".equals(cell.getValue())) {
							value = value + cell.getItemId() + ",";
						}
					}
					this.inputList = value.split(",");
				}

				this.levelList = new ArrayList();
				List list = SysCacheTool.queryInfoItemBySetId("A754");
				for (int i = 0; i < list.size(); i++) {
					InfoItemBO ib = (InfoItemBO) list.get(i);
					if (("0".equals(ib.getItemStatus()))
							|| (!"0090".equals(ib.getItemCodeSet()))
							|| (value.indexOf(ib.getItemId()) >= 0)
							|| "A754202".equals(ib.getItemId()))
						continue;
					SelectItem si = new SelectItem();
					si.setLabel(ib.getItemName());
					si.setValue(ib.getItemId());
					this.levelList.add(si);
				}
			}
		} catch (Exception e) {
		}

		return this.initSingleEdit;
	}

	public void setInitSingleEdit(String init) {
		this.initSingleEdit = init;
	}

	public List getLevelList() {
		return this.levelList;
	}

	public void setLevelList(List list) {
		this.levelList = list;
	}

	public String[] getInputList() {
		return this.inputList;
	}

	public void setInputList(String[] list) {
		this.inputList = list;
	}

	public String getNamelist() {
		return this.namelist;
	}

	public void setNamelist(String newtype) {
		this.namelist = newtype;
	}

	public String getChangeDate() {
		return this.changeDate;
	}

	public void setChangeDate(String newtype) {
		this.changeDate = newtype;
	}

	public String getDepName() {
		return this.depName;
	}

	public void setDepName(String newtype) {
		this.depName = newtype;
	}

	public String getPageInit() {
		try {
			if (super.getRequestParameter("perIds") != null) {
				this.perIds = super.getRequestParameter("perIds");
				this.namelist = "";
				String[] pelist = this.perIds.split(",");
				for (int i = 0; i < pelist.length; i++) {
					PersonBO pb = SysCacheTool.findPersonById(pelist[i]);
					if (this.namelist.equals("")) {
						this.namelist = pb.getName();
					} else {
						this.namelist = (this.namelist + "," + pb.getName());
					}
				}
				this.namelist = ("   " + this.namelist);
				this.levelList=new ArrayList();
				List list = SysCacheTool.queryInfoItemBySetId("A754");
				for (int i = 0; i < list.size(); i++) {
					InfoItemBO ib = (InfoItemBO) list.get(i);
					if (("0".equals(ib.getItemStatus())) || (!"0090".equals(ib.getItemCodeSet()))){
						continue;
					}
					SelectItem si = new SelectItem();
					si.setLabel(ib.getItemName());
					si.setValue(ib.getItemId());
					this.levelList.add(si);
				}
			}
		} catch (Exception e) {
		}
		return this.pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public String getChangeType() {
		return this.changeType;
	}

	public void setChangeType(String chgs) {
		this.changeType = chgs;
	}

	public IPersonUCC getPersonucc() {
		return this.personucc;
	}

	public void setPersonucc(IPersonUCC personucc) {
		this.personucc = personucc;
	}

	public String getCaclpersonType() {
		return this.caclpersonType;
	}

	public void setCaclpersonType(String caclpersonType) {
		this.caclpersonType = caclpersonType;
	}

	public String save() {
		try {
			if ((this.inputList == null) || (this.inputList.length == 0)) {
				super.showMessageDetail("没有选择任何保险数据");
				return "";
			}
			this.basesetucc.updateInsurceChangeInfo(this.perIds.split(","), this.changeType, this.changeDate, this.depName, this.inputList);
			this.basesetucc.updateInsurceBaseInfo(this.perIds.split(","), this.inputList, this.personType, this.caclpersonType);
			getServletRequest().setAttribute("message", "业务处理成功");
			if("00901".equals(this.selfPay)){
				JdbcTemplate jdbc = (JdbcTemplate)SysContext.getBean("jdbcTemplate");
				String sql="update a754 set A754202='00901' where "+CommonFuns.splitInSql(this.perIds.split(","), "id");				
			}
		} catch (Exception e) {
			super.showMessageDetail("处理业务失败:" + e.getMessage());
			getServletRequest().setAttribute("message", "业务处理失败");
			getServletRequest().setAttribute("flag", "1");
			return "close";
		}
		return "close";
	}

	public String delete() {
		try {
			String inputList1="";
			TableVO table = this.personucc.queryPageInfo("A754",this.perIds, "", super.getUserInfo());
			if (table.getRowData() != null) {
				RecordVO row = table.getRowData()[0];
				for (int i = 0; i < row.getCell().length; i++) {
					CellVO cell = row.getCell()[i];
					if ("00901".equals(cell.getValue())) {
						inputList1 += cell.getItemId() + ",";
					}
				}
			}
			this.insDataService.updateInsurceChangeInfo(this.perIds.split(","), this.changeType, this.changeDate, this.changeReason, this.depName, inputList1.split(","));
//			this.basesetucc.updateInsurceChangeInfo(this.perIds.split(","), this.changeType, this.changeDate, this.depName, inputList1.split(","));
		    this.basesetucc.deleteInsurceBase(this.perIds.split(","), null);
			getServletRequest().setAttribute("message", "处理业务成功!");
		} catch (Exception e) {
			this.msg.setMainMsg(e, getClass());
			getServletRequest().setAttribute("flag", "1");
			return "close";
		}
		return "close";
	}
}