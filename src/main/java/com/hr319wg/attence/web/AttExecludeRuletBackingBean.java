package com.hr319wg.attence.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.attence.pojo.bo.AttExecludeRuleBO;
import com.hr319wg.attence.ucc.IAttAnnualUCC;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;

public class AttExecludeRuletBackingBean extends BaseBackingBean {
	private String atttype;
	private String ruleId;
	private AttExecludeRuleBO bo=new AttExecludeRuleBO();
	private String initEdit;
	private List lists=new ArrayList();
	private String superId = super.getUserInfo().getOrgId();
	private String superName;
	private String pageInit;
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
	
	public String getInitEdit() {
		try {
			if (super.getRequestParameter("ruleId") != null
					&& !super.getRequestParameter("ruleId").equals("")) {
				String ruleId = super.getRequestParameter("ruleId");
				bo = attAnnualUcc.findAttExecludeRuleBObyId(ruleId);
			} else if (super.getRequestParameter("okID") != null) {
				bo.setRuleId(null);
				bo.setRuleName("");
				bo.setCreateOrg("");
				bo.setOrgId("");
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

	public AttExecludeRuleBO getBo() {
		return bo;
	}

	public void setBo(AttExecludeRuleBO bo) {
		this.bo = bo;
	}

	public String getRuleId() {
		return ruleId;
	}

	public void setRuleId(String ruleId) {
		this.ruleId = ruleId;
	}

	public String getAtttype() {
		return atttype;
	}

	public void setAtttype(String atttype) {
		this.atttype = atttype;
	}

	public void doQuery() {
		try {
			if(lists!=null && lists.size()>0){
				lists=new ArrayList();
			}
			List list=attAnnualUcc.getAttExecludeRuleBO(superId);
			if (list != null && list.size() > 0) {
				for (int i = 0; i < list.size(); i++) {
					AttExecludeRuleBO attexecluderulebo=(AttExecludeRuleBO)list.get(i);
					OrgBO b = SysCacheTool.findOrgById(attexecluderulebo.getCreateOrg());
					if (b != null) {
						attexecluderulebo.setCreateName(b.getName());
					}
					if(attexecluderulebo.getOrgId()!=null && !"".equals(attexecluderulebo.getOrgId())){
						if(!"-1".equals(attexecluderulebo.getOrgId())){
							b = SysCacheTool.findOrgById(attexecluderulebo.getOrgId());
							if (b != null) {
								attexecluderulebo.setOrgName(b.getName());
							}
						}else{
							attexecluderulebo.setOrgName("È«¼¯ÍÅ");
						}
					}
					lists.add(attexecluderulebo);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	public String delete() {
		try {
			if (ruleId != null) {
				attAnnualUcc.deleteAttExecludeRuleBO(ruleId);
			}
		} catch (Exception e) {
			super.showMessageDetail("É¾³ýÊ§°Ü£¡");
		}
		return "";
	}
	
	public String save() {
		bo.setCreateOrg(superId);
		bo.setOrgId(atttype);
		try {
			attAnnualUcc.saveAttExecludeRuleBO(bo);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}
	
	public void changeStatus(ValueChangeEvent event) {
		this.atttype = event.getNewValue().toString();
	}
	
}
