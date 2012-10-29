package com.hr319wg.attence.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.model.SelectItem;

import com.hr319wg.attence.pojo.bo.AttClassBO;
import com.hr319wg.attence.pojo.bo.AttClassGroupBO;
import com.hr319wg.attence.pojo.bo.AttManagerArgumentBO;
import com.hr319wg.attence.pojo.bo.AttManagerArrangeBO;
import com.hr319wg.attence.pojo.bo.AttPersonArrangeItemBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.web.BaseBackingBean;

public class AutoClassManagerListSelectItemBackingBean extends BaseBackingBean {
	private String orgValue;
	private String orgId=super.getUserInfo().getOrgId();
	private String itemId;
	private List workList=new ArrayList();
	private List restList=new ArrayList();
	private List personArrangeList=new ArrayList();
	private String createDay;
	private String amaId;
	private String pageInit;
	private IAttenceSetUCC attenceSetUCC;
	private boolean isExist;
	
	public boolean getIsExist() {
		return isExist;
	}

	public void setIsExist(boolean isExist) {
		this.isExist = isExist;
	}
	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}

	public String getPageInit() {
		if (super.getRequestParameter("amaId") != null && !super.getRequestParameter("amaId").equals("") && super.getRequestParameter("createDay") != null && !super.getRequestParameter("createDay").equals("") && super.getRequestParameter("orgValue") != null && !super.getRequestParameter("orgValue").equals("")) {
			amaId = super.getRequestParameter("amaId");
			createDay = super.getRequestParameter("createDay");
			orgValue = super.getRequestParameter("orgValue");
		}
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public String getCreateDay() {
		return createDay;
	}

	public void setCreateDay(String createDay) {
		this.createDay = createDay;
	}

	public String getAmaId() {
		return amaId;
	}

	public void setAmaId(String amaId) {
		this.amaId = amaId;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public List getWorkList() {
		return workList;
	}

	public void setWorkList(List workList) {
		this.workList = workList;
	}

	public List getRestList() {
		return restList;
	}

	public void setRestList(List restList) {
		this.restList = restList;
	}

	public List getPersonArrangeList() {
		return personArrangeList;
	}

	public void setPersonArrangeList(List personArrangeList) {
		this.personArrangeList = personArrangeList;
	}
	
	public String getOrgValue() {
		return orgValue;
	}

	public void setOrgValue(String orgValue) {
		this.orgValue = orgValue;
	}

	public String doQuery(){
		try{
			AttManagerArrangeBO attmanagerarrangebo=attenceSetUCC.findAttManagerArrangeBObyId(amaId);
			if("0".equals(attmanagerarrangebo.getStatus().trim())){
				isExist=true;
			}else if("9".equals(attmanagerarrangebo.getStatus().trim())){
				isExist=false;
			}else{
				isExist=false;
			}
			if(workList!=null && workList.size()>0){
				workList=new ArrayList();
			}
			List lists=attenceSetUCC.getAllAttPersonArrangeItemBO(amaId,createDay,orgValue);
			if(lists!=null && lists.size()>0){
				for(int i=0;i<lists.size();i++){
					AttPersonArrangeItemBO attpersonarrangeitembo=(AttPersonArrangeItemBO)lists.get(i);
					AttClassGroupVO attclassgroupvo=attenceSetUCC.findAttClassGroupVObyId(attpersonarrangeitembo.getPersonId());
					SelectItem item = new SelectItem();
					item.setLabel(attclassgroupvo.getName());
					item.setValue(attpersonarrangeitembo.getItemId());
					workList.add(item);
				}
			}
			
			if(restList!=null && restList.size()>0){
				restList=new ArrayList();
			}
			List lists1=attenceSetUCC.getAllAttPersonArrangeItemBO1(amaId,createDay,orgValue);
			if(lists1!=null && lists1.size()>0){
				for(int i=0;i<lists1.size();i++){
					AttPersonArrangeItemBO attpersonarrangeitembo=(AttPersonArrangeItemBO)lists1.get(i);
					AttClassGroupVO attclassgroupvo=attenceSetUCC.findAttClassGroupVObyId(attpersonarrangeitembo.getPersonId());
					SelectItem item = new SelectItem();
					item.setLabel(attclassgroupvo.getName());
					item.setValue(attpersonarrangeitembo.getItemId());
					restList.add(item);
				}
			}
			
			if(personArrangeList!=null && personArrangeList.size()>0){
				personArrangeList=new ArrayList();
			}
			List orgValuelists=attenceSetUCC.getAllAttManagerArgumentBO1(orgValue);
			if(orgValuelists!=null && orgValuelists.size()>0){
			   AttManagerArgumentBO attmanagerargumentbo=(AttManagerArgumentBO)orgValuelists.get(0);
			   List classgrouplists=attenceSetUCC.getAllAttClassGroupBOType1(orgId);
			   if(classgrouplists!=null && classgrouplists.size()>0){
				   AttClassGroupBO attclassgroupbo=(AttClassGroupBO)classgrouplists.get(0);
				   attmanagerargumentbo.setGroupName(attclassgroupbo.getGroupName());
					if("4".equals(attclassgroupbo.getGroupType())){
						attmanagerargumentbo.setGroupType(" ÷π§≈≈∞‡");
					}else{
						attmanagerargumentbo.setGroupType("");
					}
			   }else{
				   attmanagerargumentbo.setGroupName("");
				   attmanagerargumentbo.setGroupType("");
			   }
				if(!"1".equals(attmanagerargumentbo.getLinkClass().trim())){
				 AttClassBO attclassbo=attenceSetUCC.findAttClassBObyId(attmanagerargumentbo.getLinkClass());
				 attmanagerargumentbo.setLinkClassName(attclassbo.getClassName());
			    }else{
			     attmanagerargumentbo.setLinkClassName("–›œ¢");
			    }
				personArrangeList.add(attmanagerargumentbo);	
			}
			}catch(Exception e){
				e.printStackTrace();
			}
		return "";
	}
	
	public String add(){
		try{
		String[] itemIds=itemId.split(",");
		for(int i=1;i<itemIds.length;i++){
	      AttPersonArrangeItemBO attpersonarrangeitembo=attenceSetUCC.findAttPersonArrangeItemBObyId(itemIds[i]);
	      attpersonarrangeitembo.setLinkClass("1");
	      attenceSetUCC.saveorupdateAttPersonArrangeItemBO(attpersonarrangeitembo);
		}
		itemId="";
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public String delete(){
		try{
			String[] itemIds=itemId.split(",");
			for(int i=1;i<itemIds.length;i++){
		      AttPersonArrangeItemBO attpersonarrangeitembo=attenceSetUCC.findAttPersonArrangeItemBObyId(itemIds[i]);
		      List orgValuelists=attenceSetUCC.getAllAttManagerArgumentBO1(orgValue);
		      if(orgValuelists!=null && orgValuelists.size()>0){
		    	  AttManagerArgumentBO attmanagerargumentbo=(AttManagerArgumentBO)orgValuelists.get(0);
		    	  attpersonarrangeitembo.setLinkClass(attmanagerargumentbo.getLinkClass());
		      }else{
		    	  attpersonarrangeitembo.setLinkClass("1");
		      }
		      attenceSetUCC.saveorupdateAttPersonArrangeItemBO(attpersonarrangeitembo);
			}
			itemId="";
			}catch(Exception e){
				e.printStackTrace();
			}
		return "";
	}
}
