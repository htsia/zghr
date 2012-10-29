package com.hr319wg.attence.web;

import java.util.List;

import com.hr319wg.attence.pojo.bo.AttAnnualRuleItemBO;
import com.hr319wg.attence.ucc.IAttAnnualUCC;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;

public class AnnualRuleItemBackingBean extends BaseBackingBean {
	private AttAnnualRuleItemBO bo=new AttAnnualRuleItemBO();
	private String initEdit;
	private List lists;
	private String itemID;
	private static String ruleid;
	private String ruleID;
	private String ruleName;
	private String pageInit;
	private IAttAnnualUCC attAnnualUcc;

    public IAttAnnualUCC getAttAnnualUcc() {
        return attAnnualUcc;
    }

    public void setAttAnnualUcc(IAttAnnualUCC attAnnualUcc) {
        this.attAnnualUcc = attAnnualUcc;
    }

    public String getPageInit() {
		if (super.getRequestParameter("ruleID") != null
				&& !super.getRequestParameter("ruleID").equals("")
				&& super.getRequestParameter("oid") != null
				&& !super.getRequestParameter("oid").equals("")) {
			ruleID = super.getRequestParameter("ruleID");
			ruleid=ruleID;
			ruleName = super.getRequestParameter("oid");
		}
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

	public String getRuleName() {
		return ruleName;
	}

	public void setRuleName(String ruleName) {
		this.ruleName = ruleName;
	}
	
	public String getItemID() {
		return itemID;
	}

	public void setItemID(String itemID) {
		this.itemID = itemID;
	}

	public List getLists() {
		return lists;
	}

	public void setLists(List lists) {
		this.lists = lists;
	}

	public AttAnnualRuleItemBO getBo() {
		return bo;
	}

	public void setBo(AttAnnualRuleItemBO bo) {
		this.bo = bo;
	}

	public String getInitEdit() {
		try {
			if (super.getRequestParameter("itemID") != null
					&& !super.getRequestParameter("itemID").equals("")){
				String itemID = super.getRequestParameter("itemID");
				bo=attAnnualUcc.findAttAnnualRuleItemBObyId(itemID);
			}
		} catch (SysException e) {
		  e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public void doQuery() {
		try {
			lists = attAnnualUcc.getAttAnnualRuleItemBO(ruleID);
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					AttAnnualRuleItemBO attannualruleitembo=(AttAnnualRuleItemBO)lists.get(i);
					lists.set(i, attannualruleitembo);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	public String delete(){
		try {
			if (itemID != null) {
				attAnnualUcc.deleteAttAnnualRuleItemBO(itemID);
			}
		} catch (Exception e) {
			super.showMessageDetail("É¾³ýÊ§°Ü£¡");
		}
		return "";
	}	
	
	public String save(){
         bo.setRuleID(ruleid);
		try {
			attAnnualUcc.saveAttAnnualRuleItemBO(bo);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}
	
}
