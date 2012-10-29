package com.hr319wg.attence.web;



import java.util.List;

import com.hr319wg.attence.pojo.bo.AttCaclRuleBO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;

public class AttCaclRuleBackingBean extends BaseBackingBean {
	private IAttenceSetUCC attenceSetUCC;
	private String superID=super.getUserInfo().getOrgId();
	private String superName;
	private String caclLaterStatuss;
	private String caclEarlyStatuss;
	private String initEdit;
	private AttCaclRuleBO attcaclrulebo;
	
	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}
	
	public String getSuperID() {
		return superID;
	}

	public void setSuperID(String superID) {
		this.superID = superID;
	}

	public String getSuperName() {
		OrgBO b = SysCacheTool.findOrgById(superID);
		superName=b.getName();
		return superName;
	}

	public void setSuperName(String superName) {
		this.superName = superName;
	}

	public String getCaclLaterStatuss() {
		return caclLaterStatuss;
	}

	public void setCaclLaterStatuss(String caclLaterStatuss) {
		this.caclLaterStatuss = caclLaterStatuss;
	}

	public String getCaclEarlyStatuss() {
		return caclEarlyStatuss;
	}

	public void setCaclEarlyStatuss(String caclEarlyStatuss) {
		this.caclEarlyStatuss = caclEarlyStatuss;
	}

	public String getInitEdit() {
		doQuery();
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}
	
	
public AttCaclRuleBO getAttcaclrulebo() {
		return attcaclrulebo;
	}

	public void setAttcaclrulebo(AttCaclRuleBO attcaclrulebo) {
		this.attcaclrulebo = attcaclrulebo;
	}

public String doQuery(){
	try{
		List lists=attenceSetUCC.getAttCaclRuleBO(this.superID);
		if(lists!=null && lists.size()>0){
			attcaclrulebo=(AttCaclRuleBO)lists.get(0);
			caclLaterStatuss=attcaclrulebo.getCaclLater();
			caclEarlyStatuss=attcaclrulebo.getCaclEarly();
		}else{
			attcaclrulebo=new AttCaclRuleBO();
		}
	}catch(Exception e){

	}
	return "";
}
	public String save() {
		try{
			attcaclrulebo.setOrgID(superID);
			attcaclrulebo.setCaclLater(caclLaterStatuss);
			attcaclrulebo.setCaclEarly(caclEarlyStatuss);
			attenceSetUCC.saveorupdateAttCaclRuleBO(attcaclrulebo);
		}catch(Exception e){
			
		}
		return "success";
	}
	
}
