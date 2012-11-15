package com.hr319wg.wage.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.WFTypeBO;
import com.hr319wg.sys.pojo.vo.WFTransaction;
import com.hr319wg.sys.service.WorkFlowService;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.wage.pojo.bo.WageAdjustBO;
import com.hr319wg.wage.pojo.bo.WageAdjustDetailBO;
import com.hr319wg.wage.pojo.bo.WageAdjustRuleBO;
import com.hr319wg.wage.pojo.vo.AdjustVO;
import com.hr319wg.wage.ucc.IWageAdjustUCC;
import com.hr319wg.wage.ucc.IWageSetPersonUCC;

public class CommonAdjustBackingBean extends BaseBackingBean {
	private IWageAdjustUCC adjustucc;
	private IWageSetPersonUCC wagesetpersonucc;
	private WorkFlowService workflowservice;
	private List adjustList;
	private PageVO pagevo = new PageVO();
	private boolean followFlow;
	private String initDetail;
	private String initValidate;
	private String initUserValidate;
	private String validate = CommonFuns.getSysDate("yyyy-MM-dd");
	private String itemID;
	private List wageItemList;
	private List wageUserList;
	private String adjustId;
	private String initEdit;
	private WageAdjustDetailBO detailbo;
	private String initSetRule;
	private WageAdjustRuleBO wb;
	private String infoItem;
	private List baseFields = new ArrayList();
	private boolean isAppro;
	private boolean isNotAppro=true;
	
	public List getWageUserList() {
		return wageUserList;
	}

	public void setWageUserList(List wageUserList) {
		this.wageUserList = wageUserList;
	}

	public String getInitUserValidate() {
		String act = super.getRequestParameter("act");
		if("init".equals(act)){
			this.wageUserList=new ArrayList();
			String[]IDs=super.getRequestParameter("IDs").split("-");
			String[]userIDs=IDs[1].split(",");
			this.itemID=IDs[0];
			for(int i=0;i<userIDs.length;i++){
				PersonBO p = SysCacheTool.findPersonById(userIDs[i]);
				Map m = new HashMap();
				m.put("personCode", p.getPersonCode());
				m.put("name", p.getName());
				m.put("deptName", CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
				this.wageUserList.add(m);
			}
		}
		return null;
	}

	public boolean isAppro() {
		return isAppro;
	}

	public void setAppro(boolean isAppro) {
		this.isAppro = isAppro;
	}

	public boolean isNotAppro() {
		return isNotAppro;
	}

	public void setNotAppro(boolean isNotAppro) {
		this.isNotAppro = isNotAppro;
	}

	public IWageSetPersonUCC getWagesetpersonucc() {
		return this.wagesetpersonucc;
	}

	public void setWagesetpersonucc(IWageSetPersonUCC wagesetpersonucc) {
		this.wagesetpersonucc = wagesetpersonucc;
	}

	public WorkFlowService getWorkflowservice() {
		return this.workflowservice;
	}

	public void setWorkflowservice(WorkFlowService workflowservice) {
		this.workflowservice = workflowservice;
	}

	public String doApply() {
		try {
			WageAdjustBO adjust = this.adjustucc.getWageAdjustBO(this.itemID);
			adjust.setStatus(WageAdjustBO.STATUS_AUDITING);
			this.adjustucc.saveWageAdjustBO(adjust);
			PersonBO pb = SysCacheTool.findPersonById(adjust.getPersonID());
			WFTransaction trans = new WFTransaction();
			trans.setUser(super.getUserInfo());
			trans.setLinkID(this.itemID);
			trans.setWfType(WFTypeBO.WAGE_ADJUST_AUDIT);
			trans.setOperID("0661");
			trans.setStatusValue("0");
			trans.setDeptID(pb.getDeptId());
			trans.setWffunction("wage_adjustUCC");
			this.workflowservice.processTrans(trans);
		} catch (Exception e) {
		}
		return doQuery();
	}

	public boolean isFollowFlow() {
		try {
			this.followFlow = this.workflowservice.haveWorkFlow(super
					.getUserInfo().getOrgId(), WFTypeBO.WAGE_ADJUST_AUDIT);
		} catch (Exception e) {
		}
		return this.followFlow;
	}

	public void setFollowFlow(boolean followFlow) {
		this.followFlow = followFlow;
	}

	public List getAdjustList() {
		return this.adjustList;
	}

	public void setAdjustList(List adjustList) {
		this.adjustList = adjustList;
	}

	public PageVO getPagevo() {
		return this.pagevo;
	}

	public void setPagevo(PageVO pagevo) {
		this.pagevo = pagevo;
	}

	public String getPageInit() {
		this.itemID=null;
		if (super.getRequestParameter("Init") != null) {
			first();
		}
		doQuery();
		return null;
	}

	public String first() {
		this.pagevo.setCurrentPage(1);
		return null;
	}

	public String last() {
		this.pagevo.setCurrentPage(this.pagevo.getTotalPage());
		return null;
	}

	public String pre() {
		if (this.pagevo.getCurrentPage() >= 2) {
			this.pagevo.setCurrentPage(this.pagevo.getCurrentPage() - 1);
		}
		return null;
	}

	public String next() {
		if (this.pagevo.getCurrentPage() < this.pagevo.getTotalPage()) {
			this.pagevo.setCurrentPage(this.pagevo.getCurrentPage() + 1);
		}
		return null;
	}

	public String doQuery() {
		try {
			if (this.pagevo.getCurrentPage() <= 0)
				this.pagevo.setCurrentPage(1);
			this.adjustList = this.adjustucc.getAdjustList(this.pagevo,this.isAppro, this.isNotAppro, super.getUserInfo());
			for (int i = 0; i < this.adjustList.size(); i++) {
				AdjustVO wb = (AdjustVO)this.adjustList.get(i);
				PersonBO p = SysCacheTool.findPersonById(wb.getAdjustbo().getPersonID());
				wb.getAdjustbo().setPersonCode(p.getPersonCode());
				wb.getAdjustbo().setPersonName(p.getName());
				wb.getAdjustbo().setOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
			}
		} catch (Exception e) {
		}

		return null;
	}

	public String selPerson() {
		try {
			PersonBO[] pbos = (PersonBO[]) (PersonBO[]) super.getHttpSession()
					.getAttribute(Constants.SELPERSON_SESSION);
			if ((pbos != null) && (pbos.length > 0)) {
				WageAdjustBO adjust;
				Iterator it;
				for (int i = 0; i < pbos.length; i++) {
					adjust = new WageAdjustBO();
					adjust.setPersonID(pbos[i].getPersonId());
					adjust.setOrgID(super.getUserInfo().getOrgId());
					adjust.setStatus(WageAdjustBO.STATUS_APPLY);
					adjust.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
					this.adjustucc.saveWageAdjustBO(adjust);

					PersonBO pb = SysCacheTool.findPersonById(adjust
							.getPersonID());
					WageAdjustRuleBO rule = this.adjustucc
							.getWageAdjustRuleBO(pb.getOrgId());
					if (rule != null) {
						String[] personids = new String[1];
						personids[0] = adjust.getPersonID();
						HashMap hash = this.wagesetpersonucc
								.queryPersonBaseItem(personids, rule
										.getWageItems().split(","));
						if ((hash != null) && (hash.size() > 0)) {
							for (it = hash.entrySet().iterator(); it.hasNext();) {
								WageAdjustDetailBO bo = new WageAdjustDetailBO();
								Map.Entry entry = (Map.Entry) it.next();
								String[] para = entry.getKey().toString()
										.split("\\|");
								bo.setItemID(adjust.getItemID());
								bo.setFieldID(para[1]);
								bo.setOldValue(entry.getValue().toString());
								this.adjustucc.saveWageAdjustDetailBO(bo);
							}
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return doQuery();
	}

	public IWageAdjustUCC getAdjustucc() {
		return this.adjustucc;
	}

	public void setAdjustucc(IWageAdjustUCC adjustucc) {
		this.adjustucc = adjustucc;
	}

	public String refreshDetail() {
		try {
			this.wageItemList = this.adjustucc.getAdjustDetail(this.itemID);
			for (int i = 0; i < this.wageItemList.size(); i++) {
				WageAdjustDetailBO wb = (WageAdjustDetailBO) this.wageItemList
						.get(i);
				InfoItemBO ibo = SysCacheTool.findInfoItem("", wb.getFieldID());
				wb.setFieldName(ibo.getItemName());
				if ("6".equals(ibo.getItemDataType())) {
					wb.setOldValue(CodeUtil.interpertCode(wb.getOldValue()));
					wb.setNewValue(CodeUtil.interpertCode(wb.getNewValue()));
				}
			}
		} catch (Exception e) {
		}
		return null;
	}

	public String getInitDetail() {
		try {
			if (super.getRequestParameter("itemID") != null) {
				this.itemID = super.getRequestParameter("itemID");
				refreshDetail();
			}
		} catch (Exception e) {
		}
		return this.initDetail;
	}

	public void setInitDetail(String initDetail) {
		this.initDetail = initDetail;
	}

	public String getInitValidate() {
		try {
			if (super.getRequestParameter("itemID") != null) {
				this.itemID = super.getRequestParameter("itemID");
				refreshDetail();
			}
		} catch (Exception e) {
		}
		return this.initValidate;
	}

	public void setInitValidate(String initValidate) {
		this.initValidate = initValidate;
	}

	public String getValidate() {
		return this.validate;
	}

	public void setValidate(String validate) {
		this.validate = validate;
	}

	public List getWageItemList() {
		return this.wageItemList;
	}

	public void setWageItemList(List wageItemList) {
		this.wageItemList = wageItemList;
	}

	public String getAdjustId() {
		return this.adjustId;
	}

	public void setAdjustId(String adjustId) {
		this.adjustId = adjustId;
	}

	public String getItemID() {
		return this.itemID;
	}

	public void setItemID(String itemID) {
		this.itemID = itemID;
	}

	public String delete() {
		try {
			this.adjustucc.deleteWageAdjustDetailBO(this.adjustId);
			refreshDetail();
		} catch (Exception e) {
		}
		return null;
	}

	public String getInitEdit() {
		try {
			if (super.getRequestParameter("adjustID") != null) {
				this.detailbo = this.adjustucc.getWageAdjustDetailBO(super
						.getRequestParameter("adjustID"));
				this.detailbo.setFieldName(CodeUtil.interpertCode(
						CodeUtil.TYPE_INFOITEM, this.detailbo.getFieldID()));
				super.getHttpSession().setAttribute("filed",
						this.detailbo.getFieldID());
				super.getHttpSession().setAttribute("oldValue",
						this.detailbo.getOldValue());
			}
		} catch (Exception e) {
		}
		return this.initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public WageAdjustDetailBO getDetailbo() {
		return this.detailbo;
	}

	public void setDetailbo(WageAdjustDetailBO detailbo) {
		this.detailbo = detailbo;
	}

	public String saveDetailItem() {
		try {
			String newValue = super.getRequestParameter("newValue");
			this.detailbo.setNewValue(newValue);
			this.adjustucc.saveWageAdjustDetailBO(this.detailbo);
		} catch (Exception e) {
		}
		return "success";
	}

	public String doDelete() {
		try {
			this.adjustucc.deleteAdjust(this.itemID);
		} catch (Exception e) {
		}
		return doQuery();
	}

	//ÉúÐ§
	public String doOK() {
		try {
			this.adjustucc.ValidateAdjust(super.getUserInfo(), this.itemID);
		} catch (Exception e) {
		}
		return "success";
	}

	public String getInitSetRule() {
		try {
			if (super.getRequestParameter("Action") != null) {
				this.wb = this.adjustucc.getWageAdjustRuleBO(super
						.getUserInfo().getOrgId());
				if (this.wb == null) {
					this.wb = new WageAdjustRuleBO();
					this.wb.setOrgID(super.getUserInfo().getOrgId());
				}
				this.wb.setOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG,
						this.wb.getOrgID()));
				this.baseFields.clear();
				if ((this.wb.getWageItems() != null)
						&& (!"".equals(this.wb.getWageItems()))) {
					String[] array = this.wb.getWageItems().split(",");
					for (int i = 0; i < array.length; i++) {
						this.baseFields.add(SysCacheTool.findInfoItem("",
								array[i]));
					}
				}
			}
		} catch (Exception e) {
		}
		return this.initSetRule;
	}

	public void setInitSetRule(String initSetRule) {
		this.initSetRule = initSetRule;
	}

	public WageAdjustRuleBO getWb() {
		return this.wb;
	}

	public void setWb(WageAdjustRuleBO wb) {
		this.wb = wb;
	}

	public String getInfoItem() {
		return this.infoItem;
	}

	public void setInfoItem(String infoItem) {
		this.infoItem = infoItem;
	}

	public String addfield() {
		if ((this.infoItem != null) && (!"".equals(this.infoItem))) {
			String[] inf = this.infoItem.replace('.', ',').split(",");
			InfoItemBO ib = SysCacheTool.findInfoItem("", inf[1]);
			ib.setSetId(CodeUtil.interpertCode(CodeUtil.TYPE_INFOSET, inf[0]));
			ib.setItemSequence(String.valueOf(this.baseFields.size() + 1));
			this.baseFields.add(ib);
		}
		return null;
	}

	public List getBaseFields() {
		return this.baseFields;
	}

	public void setBaseFields(List baseFields) {
		this.baseFields = baseFields;
	}

	public String delfield() {
		if ((this.infoItem != null) && (!"".equals(this.infoItem))
				&& (this.baseFields != null)) {
			int i = 0;

			while (i < this.baseFields.size()) {
				InfoItemBO ib = (InfoItemBO) this.baseFields.get(i);
				if (this.infoItem.equals(ib.getItemId())) {
					this.baseFields.remove(i);
					if ((this.wb.getWageItems() == null)
							|| ("".equals(this.wb.getWageItems())))
						break;
					String items = "";
					String[] fs = this.wb.getWageItems().split(",");
					for (int j = 0; j < fs.length; j++) {
						InfoItemBO ib1 = SysCacheTool.findInfoItem("", fs[j]);
						if (!ib1.getItemId().equals(ib.getItemId())) {
							items = items + ib1.getItemId() + ",";
						}
					}
					this.wb.setWageItems(items);
					try {
						this.adjustucc.saveWageAdjustRuleBO(this.wb);
					} catch (SysException e) {
						e.printStackTrace();
					}
					break;
				}

				i++;
			}
		}
		return null;
	}

	public String movePre() {
		if ((this.infoItem != null) && (!"".equals(this.infoItem))
				&& (this.baseFields != null)) {
			int i = 0;
			i = 0;

			while (i < this.baseFields.size()) {
				InfoItemBO ib = (InfoItemBO) this.baseFields.get(i);
				if (this.infoItem.equals(ib.getItemId()))
					break;
				i++;
			}
			if ((i < this.baseFields.size()) && (i > 0)) {
				InfoItemBO ib = (InfoItemBO) this.baseFields.get(i);
				this.baseFields.set(i, this.baseFields.get(i - 1));
				this.baseFields.set(i - 1, ib);
			}
		}
		return null;
	}

	public String moveNext() {
		if ((this.infoItem != null) && (!"".equals(this.infoItem))
				&& (this.baseFields != null)) {
			int i = 0;
			i = 0;

			while (i < this.baseFields.size()) {
				InfoItemBO ib = (InfoItemBO) this.baseFields.get(i);
				if (this.infoItem.equals(ib.getItemId()))
					break;
				i++;
			}
			if (i < this.baseFields.size() - 1) {
				InfoItemBO ib = (InfoItemBO) this.baseFields.get(i + 1);
				this.baseFields.set(i + 1, this.baseFields.get(i));
				this.baseFields.set(i, ib);
			}
		}
		return null;
	}

	public String saveAdjustRule() {
		try {
			this.wb.setWageItems("");
			for (int i = 0; i < this.baseFields.size(); i++) {
				if (i == 0)
					this.wb.setWageItems(((InfoItemBO) this.baseFields.get(i))
							.getItemId());
				else
					this.wb.setWageItems(this.wb.getWageItems() + ","
							+ ((InfoItemBO) this.baseFields.get(i)).getItemId());
			}
			this.adjustucc.saveWageAdjustRuleBO(this.wb);
		} catch (Exception e) {
		}
		return "success";
	}
	public void setIsAppro(ValueChangeEvent event) {
		this.isAppro = event.getNewValue().toString().equals("true");
	}
	public void setIsNotAppro(ValueChangeEvent event) {
		this.isNotAppro = event.getNewValue().toString().equals("true");
	}
}