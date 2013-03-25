package com.hr319wg.insurace.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.faces.model.SelectItem;

import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.custom.ins.service.IInsDataService;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.insurace.ucc.IBaseSetUCC;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.wage.ucc.IWageItemPowerUCC;

public class BaseRateInputEditBackingBean extends BaseBackingBean {
	private String[] selectFields;
	private List fieldsList = new ArrayList();
	private Object[] personlist;
	private String pageInit;
	private IBaseSetUCC basesetucc;
	private IWageItemPowerUCC wagepowerucc;
	private String perIds;
	private String payAddress;
	private String changeType;
	private String changeDate;
	private String depName;
	private String addType;
	private String selfPay="00900";
	private String addRecord;
	private IInsDataService insDataService;
	
	public IInsDataService getInsDataService() {
		return insDataService;
	}

	public void setInsDataService(IInsDataService insDataService) {
		this.insDataService = insDataService;
	}

	public String getAddRecord() {
		return addRecord;
	}

	public void setAddRecord(String addRecord) {
		this.addRecord = addRecord;
	}

	public String getSelfPay() {
		return selfPay;
	}

	public void setSelfPay(String selfPay) {
		this.selfPay = selfPay;
	}

	public String getPayAddress() {
		return payAddress;
	}

	public void setPayAddress(String payAddress) {
		this.payAddress = payAddress;
	}

	public String getAddType() {
		return addType;
	}

	public void setAddType(String addType) {
		this.addType = addType;
	}

	public String getPerIds() {
		return perIds;
	}

	public void setPerIds(String perIds) {
		this.perIds = perIds;
	}

	public String getChangeType() {
		return changeType;
	}

	public void setChangeType(String changeType) {
		this.changeType = changeType;
	}

	public String getChangeDate() {
		return changeDate;
	}

	public void setChangeDate(String changeDate) {
		this.changeDate = changeDate;
	}

	public String getDepName() {
		return depName;
	}

	public void setDepName(String depName) {
		this.depName = depName;
	}

	public IWageItemPowerUCC getWagepowerucc() {
		return this.wagepowerucc;
	}

	public void setWagepowerucc(IWageItemPowerUCC wagepowerucc) {
		this.wagepowerucc = wagepowerucc;
	}

	public IBaseSetUCC getBasesetucc() {
		return this.basesetucc;
	}

	public void setBasesetucc(IBaseSetUCC basesetucc) {
		this.basesetucc = basesetucc;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public Object[] getPersonlist() {
		return this.personlist;
	}

	public void setPersonlist(Object[] personlist) {
		this.personlist = personlist;
	}

	public List getFieldsList() {
		return this.fieldsList;
	}

	public void setFieldsList(List fieldsList) {
		this.fieldsList = fieldsList;
	}

	public String[] getSelectFields() {
		return this.selectFields;
	}

	public void setSelectFields(String[] selectFields) {
		this.selectFields = selectFields;
	}

	// 录入基数初始页面
	public String getPageInit() {
		String act=super.getRequestParameter("act");
		if("init".equals(act)){
			this.addRecord=null;
		}
		String addRecord1=super.getRequestParameter("addRecord");
		if(addRecord1!=null && !"".equals(addRecord1)){
			this.addRecord=addRecord1;
		}
		this.changeDate=CommonFuns.getSysDate("yyyy-MM-dd");
		this.payAddress=super.getUserInfo().getOrgId();
		try {
			if ((super.getRequestParameter("PerStr") != null)
					&& (!super.getRequestParameter("PerStr").equals(""))) {
				super.getHttpSession().removeAttribute("field");
				super.getHttpSession().removeAttribute("persId");

				this.perIds = super.getServletRequest().getParameter("PerStr")
						.replaceAll("~", "#");
				String[] pId = this.perIds.split(",");
				String[] persId = new String[pId.length];
				this.personlist = new PersonBO[pId.length];
				for (int i = 0; i < pId.length; i++) {
					PersonBO pb = SysCacheTool.findPersonById(pId[i]);
					pb.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG,
							pb.getDeptId()));
					pb.setOrgId(CodeUtil.interpertCode(CodeUtil.TYPE_ORG,
							pb.getOrgId()));
					this.personlist[i] = pb;
					persId[i] = pb.getPersonId();
				}
				super.getHttpSession().setAttribute("pkIDs", pId);
				super.getHttpSession().setAttribute("persId", persId);

				this.fieldsList = new ArrayList();
				String[] fs = { "A755715", "A770710", "A765705", "A760710",
						"A775704", "A786700", "A780708", "A785708" };
				String SetID = super.getRequestParameter("SetID");
				String select = this.wagepowerucc.getInsuraceBaseFields(super
						.getUserInfo().getUserId(), SetID);
				for (int i = 0; i < fs.length; i++)
					if (select.indexOf(fs[i]) >= 0) {
						InfoItemBO ib = SysCacheTool.findInfoItem("", fs[i]);
						SelectItem s6 = new SelectItem();
						s6.setLabel(ib.getItemName());
						s6.setValue(ib.getItemId());
						this.fieldsList.add(s6);
					}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return this.pageInit;
	}

	// 点击确认录入基数按钮
	public String queryPersonInput() {
		try {
			super.getHttpSession().setAttribute("field", this.selectFields);
			String[] persId = (String[]) (String[]) super.getHttpSession()
					.getAttribute("persId");
			String[] field = (String[]) (String[]) super.getHttpSession()
					.getAttribute("field");
			HashMap hash = this.basesetucc.BaseRateInputEditSelectData(persId,
					field);
			super.getHttpSession().removeAttribute("value");
			super.getServletRequest().setAttribute("value", hash);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "inputEdit";
	}
	// 点击确认录入基数按钮2
	public String queryPersonInput2() {
		try {
			super.getHttpSession().setAttribute("field", this.selectFields);
			String[] persId = (String[]) (String[]) super.getHttpSession()
					.getAttribute("persId");
			String[] field = (String[]) (String[]) super.getHttpSession()
					.getAttribute("field");
			HashMap hash = this.basesetucc.BaseRateInputEditSelectData(persId,
					field);
			super.getHttpSession().removeAttribute("value");
			super.getServletRequest().setAttribute("value", hash);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "inputEdit";
	}

	// 保存基数并增加历史记录
	public String savePersonBase() {
		try {
			String[] persId = (String[]) (String[]) super.getHttpSession()
					.getAttribute("persId");
			String[] inputField = (String[]) (String[]) super.getHttpSession()
					.getAttribute("field");
			int col = inputField.length;
			int row = persId.length;
			if("1".equals(addRecord)){
				//添加变动记录
				this.insDataService.updateInsurceChangeInfo(this.perIds.split(","), this.changeType, this.changeDate, null, this.depName, this.selectFields);
			}
			for (int i = 0; i < row; i++) {
				for (int j = 0; j < col; j++) {
					String id = persId[i].trim();
					String tablename = inputField[j].trim().substring(0, 4);
					String value = CommonFuns.filterNullToZero(super.getRequestParameter(persId[i] + "|" + inputField[j]));
					//新增缴费基数
					this.insDataService.saveInsBaseData(id, tablename, value, "1".equals(addRecord)?this.changeDate:CommonFuns.getSysDate("yyyy-MM-dd"));
					//新增险种添加记录
					if("1".equals(addRecord)){
						JdbcTemplate jdbc = (JdbcTemplate)SysContext.getBean("jdbcTemplate");
						StringBuffer sql = new StringBuffer("update a754 set ");
						for(int k=0;k<this.selectFields.length;k++){
//							"A755715", "A770710", "A765705", "A760710",
//							"A775704", "A786700", "A780708", 
							String field=this.selectFields[k];
//							 是否参加养老保险(A754010) 国标 否 代码 99 启用    
//							 是否参加医疗保险(A754015) 国标 否 代码 99 启用    
//							 是否参加失业保险(A754020) 国标 否 代码 99 启用    
//							 是否参加工伤保险(A754025) 国标 否 代码 99 启用    
//							 是否参加生育保险(A754030) 国标 否 代码 99 启用    
//							 是否参加大额医疗(A754200) 
//							 是否参加住房公积金(A754035) 国标 否 代码 99 启用    
							if("A755715".equals(field)){//养老
								sql.append("A754010='00901',");							
							}else if("A770710".equals(field)){//失业
								sql.append("A754020='00901',");							
							}else if("A765705".equals(field)){//工伤
								sql.append("A754025='00901',");							
							}else if("A760710".equals(field)){//医疗
								sql.append("A754015='00901',");							
							}else if("A775704".equals(field)){//生育
								sql.append("A754030='00901',");						
							}else if("A786700".equals(field)){//大额
								sql.append("A754200='00901',");							
							}else if("A780708".equals(field)){//公积金
								sql.append("A754035='00901',");							
							}
						}
						sql.append("A754202='"+this.selfPay+"',A754002='"+this.payAddress+"' where "+CommonFuns.splitInSql(this.perIds.split(","), "id"));
						jdbc.execute(sql.toString());
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}
}