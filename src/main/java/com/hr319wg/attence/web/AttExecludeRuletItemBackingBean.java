package com.hr319wg.attence.web;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.attence.pojo.bo.AttExecludeRuleBO;
import com.hr319wg.attence.pojo.bo.AttExecludeRuleItemBO;
import com.hr319wg.attence.ucc.IAttAnnualUCC;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;

public class AttExecludeRuletItemBackingBean extends BaseBackingBean {
	private static String ruleids;
	private String contentDesNames;
	private String contentSqlName;
	private AttExecludeRuleItemBO bo=new AttExecludeRuleItemBO();
	private String initEdit;
	private String itemId;
	private List lists=new ArrayList();
	private String ruleId;
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
		try {
			if (super.getRequestParameter("ruleId") != null
					&& !super.getRequestParameter("ruleId").equals("")) {
				ruleId = super.getRequestParameter("ruleId");
				ruleids=ruleId;
				AttExecludeRuleBO attexecluderulebo = attAnnualUcc.findAttExecludeRuleBObyId(ruleId);
				if(attexecluderulebo!=null){
					ruleName=attexecluderulebo.getRuleName();
				}else{
					ruleName="";
				}
			} 
		} catch (SysException e) {
			e.printStackTrace();
		}
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public String getRuleId() {
		return ruleId;
	}

	public void setRuleId(String ruleId) {
		this.ruleId = ruleId;
	}

	public String getRuleName() {
		return ruleName;
	}

	public void setRuleName(String ruleName) {
		this.ruleName = ruleName;
	}
	
	public List getLists() {
		return lists;
	}

	public void setLists(List lists) {
		this.lists = lists;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getInitEdit() {
		try {
			if (super.getRequestParameter("itemID") != null
					&& !super.getRequestParameter("itemID").equals("")) {
				String itemID = super.getRequestParameter("itemID");
				bo = attAnnualUcc.findAttExecludeRuleItemBObyId(itemID);
			} else if (super.getRequestParameter("okID") != null) {
				bo.setItemId(null);
                bo.setContentDes("");
                bo.setContentSql("");
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public AttExecludeRuleItemBO getBo() {
		return bo;
	}

	public void setBo(AttExecludeRuleItemBO bo) {
		this.bo = bo;
	}

	public String getContentDesNames() {
		return contentDesNames;
	}

	public void setContentDesNames(String contentDesNames) {
		this.contentDesNames = contentDesNames;
	}

	public String getContentSqlName() {
		return contentSqlName;
	}

	public void setContentSqlName(String contentSqlName) {
		this.contentSqlName = contentSqlName;
	}

	public void doQuery() {
		try {
			if(lists!=null && lists.size()>0){
				lists=new ArrayList();
			}
			List list = attAnnualUcc.getAttExecludeRuleItemBO(ruleId);
			if (list != null && list.size() > 0) {
				for (int i = 0; i < list.size(); i++) {
					AttExecludeRuleItemBO attexecluderuleitembo=(AttExecludeRuleItemBO)list.get(i);
					lists.add(attexecluderuleitembo);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	public String clear(){
			bo.setContentDes("");
			bo.setContentSql("");
		return "";
	}	
	
	public String delete(){
		try {
			if (itemId != null) {
				attAnnualUcc.deleteAttExecludeRuleItemBO(itemId);
			}
		} catch (Exception e) {
			super.showMessageDetail("É¾³ýÊ§°Ü£¡");
		}
		return "";
	}	
	
	public String save(){
		try {
			if (ruleids != null) {
				bo.setRuleId(ruleids);
				attAnnualUcc.saveAttExecludeRuleItemBO(bo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}
	
}
