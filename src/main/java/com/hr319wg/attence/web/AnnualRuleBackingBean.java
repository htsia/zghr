package com.hr319wg.attence.web;

import java.util.List;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.attence.pojo.bo.AttAnnualRuleBO;
import com.hr319wg.attence.ucc.IAttAnnualUCC;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;


public class AnnualRuleBackingBean extends BaseBackingBean {
	private String initEdit;
	private String atttype;
	private AttAnnualRuleBO bo=new AttAnnualRuleBO();
	private String superName;
	private static String status = "1";
	private String ruleID;
	private String pageInit;
	private List lists;
	private String superId = super.getUserInfo().getOrgId();
    private IAttAnnualUCC attAnnualUcc;

    public IAttAnnualUCC getAttAnnualUcc() {
        return attAnnualUcc;
    }

    public void setAttAnnualUcc(IAttAnnualUCC attAnnualUcc) {
        this.attAnnualUcc = attAnnualUcc;
    }

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public String getSuperName() {
		OrgBO b = SysCacheTool.findOrgById(this.superId);
		if (b != null) {
			superName = b.getName();
		}
		return superName;
	}

	public void setSuperName(String superName) {
		this.superName = superName;
	}

	public List getLists() {
		return lists;
	}

	public void setLists(List lists) {
		this.lists = lists;
	}

	public String getPageInit() {
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public String getRuleID() {
		return ruleID;
	}

	public void setRuleID(String ruleID) {
		this.ruleID = ruleID;
	}
	public void doQuery() {
		try {
			lists = attAnnualUcc.getAllAttAnnualRuleBOByOrgId(superId);
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					AttAnnualRuleBO attannualrulebo=(AttAnnualRuleBO)lists.get(i);
					OrgBO b = SysCacheTool.findOrgById(this.superId);
					if (b != null) {
						attannualrulebo.setCreateOrgName(b.getName());
					}
					if (!"".equals(attannualrulebo.getCreateOrg())) {
						OrgBO b1 = SysCacheTool.findOrgById(attannualrulebo
								.getCreateOrg());
						if (b1 != null) {
							if (superId.equals(attannualrulebo.getCreateOrg())) {
								attannualrulebo.setCreateOrgName1(b1.getName());
								attannualrulebo.setStatus1(this.status);
							} else {
								attannualrulebo.setCreateOrgName1(b1.getName());
							}
						}
					}
					lists.set(i, attannualrulebo);
					
				}
			}
			
			if (superId != null) {
				String org = "-1";
				List lists1 = attAnnualUcc.getAllAttAnnualRuleBOByOrgId(org);
				if (lists1 != null && lists1.size() > 0) {
					for (int i = 0; i < lists1.size(); i++) {
						AttAnnualRuleBO attannualrulebo1=(AttAnnualRuleBO)lists1.get(i);
						attannualrulebo1.setCreateOrgName("È«¼¯ÍÅ");
						if (!"".equals(attannualrulebo1.getCreateOrg())) {
							OrgBO b1 = SysCacheTool
									.findOrgById(attannualrulebo1
											.getCreateOrg());
							if (b1 != null) {
								if (superId.equals(attannualrulebo1
										.getCreateOrg())) {
									attannualrulebo1.setCreateOrgName1(b1
											.getName());
									attannualrulebo1.setStatus1(this.status);
								} else {
									attannualrulebo1.setCreateOrgName1(b1
											.getName());
								}
							}
						}
						lists1.set(i, attannualrulebo1);						
					}
					
					lists.addAll(lists1);
				}		
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}

	public AttAnnualRuleBO getBo() {
		return bo;
	}

	public void setBo(AttAnnualRuleBO bo) {
		this.bo = bo;
	}
	
	public String getAtttype() {
		return atttype;
	}

	public void setAtttype(String atttype) {
		this.atttype = atttype;
	}

	public String getInitEdit() {
		try {
			if (super.getRequestParameter("ruleID") != null
					&& !super.getRequestParameter("ruleID").equals("")
					&& super.getRequestParameter("oid") != null
					&& !super.getRequestParameter("oid").equals("")) {
				String ruleID = super.getRequestParameter("ruleID");
				String oid = super.getRequestParameter("oid");
				bo = attAnnualUcc.findAttAnnualRuleBObyId(ruleID);
			} else if (super.getRequestParameter("okID") != null) {
				bo.setRuleID(null);
				bo.setRuleName("");
				bo.setCreateOrg("");
				bo.setOrgID("");
				bo.setDescription("");
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public String delete() {
		try {
			if (ruleID != null) {
				attAnnualUcc.deleteAttAnnualRuleBO(ruleID);
			}
		} catch (Exception e) {
			super.showMessageDetail("É¾³ýÊ§°Ü£¡");
		}
		return "";
	}
	
	public String save() {
		bo.setCreateOrg(superId);
		bo.setOrgID(atttype);
		try {
			attAnnualUcc.saveAttAnnualRuleBO(bo);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";

	}
	
	public void changeStatus(ValueChangeEvent event) {
		this.atttype = event.getNewValue().toString();
	}
}
