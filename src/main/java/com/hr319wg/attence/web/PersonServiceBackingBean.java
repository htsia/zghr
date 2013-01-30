package com.hr319wg.attence.web;

import com.hr319wg.attence.pojo.bo.AttClassGroupBO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;

public class PersonServiceBackingBean extends BaseBackingBean {
	private IAttenceSetUCC attenceSetUCC;
    private String pageInit;
    private String groupName;
    private String personName;
    
	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getPageInit() {
		try {
		super.getHttpSession().removeAttribute("flag");
		super.getHttpSession().removeAttribute("groupno");
		super.getHttpSession().removeAttribute("userid");
		String userid=super.getUserInfo().getUserId();
		super.getHttpSession().setAttribute("userid",userid);
		personName=super.getUserInfo().getName();
		String groupno=attenceSetUCC.getA001737(userid);
		if(groupno!=null && !"".equals(groupno)){
			super.getHttpSession().setAttribute("groupno",groupno);
		}
		AttClassGroupBO bo=attenceSetUCC.findAttClassGroupBObyId(groupno);
		if(bo!=null){
			if(bo.getLinkClass()!=null && !"".equals(bo.getLinkClass())){
				super.getHttpSession().setAttribute("flag", "100");
			}else{
				super.getHttpSession().setAttribute("flag", "10000");
			}
			groupName=bo.getGroupName();
		}
		} catch (SysException e) {
		}
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}
	
	
}
