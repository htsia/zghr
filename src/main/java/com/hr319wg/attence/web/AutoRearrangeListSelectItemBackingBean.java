package com.hr319wg.attence.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.model.SelectItem;

import com.hr319wg.attence.pojo.bo.AttClassBO;
import com.hr319wg.attence.pojo.bo.AttClassGroupBO;
import com.hr319wg.attence.pojo.bo.AttPersonArrangeBO;
import com.hr319wg.attence.pojo.bo.AttPersonArrangeItemBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.web.BaseBackingBean;

public class AutoRearrangeListSelectItemBackingBean extends BaseBackingBean {
	private String orgId=super.getUserInfo().getOrgId();
	private String itemId;
	private String arrangeId;
	private String createDay;
	private List workList=new ArrayList();
	private List restList=new ArrayList();
	private List personArrangeList=new ArrayList();
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
		if (super.getRequestParameter("arrangeId") != null && !super.getRequestParameter("arrangeId").equals("") && super.getRequestParameter("createDay") != null && !super.getRequestParameter("createDay").equals("")) {
			arrangeId = super.getRequestParameter("arrangeId");
			createDay = super.getRequestParameter("createDay");
		}
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
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
	
	public String getArrangeId() {
		return arrangeId;
	}

	public void setArrangeId(String arrangeId) {
		this.arrangeId = arrangeId;
	}

	public String getCreateDay() {
		return createDay;
	}

	public void setCreateDay(String createDay) {
		this.createDay = createDay;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public List getPersonArrangeList() {
		return personArrangeList;
	}

	public void setPersonArrangeList(List personArrangeList) {
		this.personArrangeList = personArrangeList;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String doQuery(){
		try{
			AttPersonArrangeBO attpersonarrangebo=attenceSetUCC.findAttPersonArrangeBObyId(arrangeId);
			if("0".equals(attpersonarrangebo.getStatus().trim())){
				isExist=true;
			}else if("9".equals(attpersonarrangebo.getStatus().trim())){
				isExist=false;
			}else{
				isExist=false;
			}
			if(workList!=null && workList.size()>0){
				workList=new ArrayList();
			}
			List lists=attenceSetUCC.getAllAttPersonArrangeItemBO(arrangeId,createDay);
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
			List lists1=attenceSetUCC.getAllAttPersonArrangeItemBO1(arrangeId,createDay);
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
			AttPersonArrangeBO attpersonarrangebos=attenceSetUCC.findAttPersonArrangeBObyId(arrangeId);
			if(attpersonarrangebos!=null){
				AttClassGroupBO attclassgroupbo=attenceSetUCC.findAttClassGroupBObyId(attpersonarrangebos.getGroupId());
				attpersonarrangebos.setGroupName(attclassgroupbo.getGroupName());
				if("4".equals(attclassgroupbo.getGroupType())){
					attpersonarrangebos.setGroupType("手工排班");
				}else{
					attpersonarrangebos.setGroupType("");
				}
				if(!"1".equals(attpersonarrangebos.getLinkClass().trim())){
					AttClassBO attclassbo=attenceSetUCC.findAttClassBObyId(attpersonarrangebos.getLinkClass());
					attpersonarrangebos.setLinkClassName(attclassbo.getClassName());
				}else{
					attpersonarrangebos.setLinkClassName("休息");
				}
				personArrangeList.add(attpersonarrangebos);	
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
	      //计算存休
	      List daylists=(List)super.getHttpSession().getAttribute("lists");
	      AttPersonArrangeBO attpersonarrangebo=attenceSetUCC.findAttPersonArrangeBObyId(attpersonarrangeitembo.getArrangeId());
			String groupId=attpersonarrangebo.getGroupId();
			List personGroupLists=attenceSetUCC.findPersonsAttClassGroupVO(groupId);//在编人数
	      int sum1=attenceSetUCC.caclFeast(daylists,orgId); //当月节假日天数
			int sum2=Integer.parseInt(attpersonarrangebo.getRestDay()); //当月休息天数
			int sum3=daylists.size(); //当月天数
			int sum=sum3-sum2-sum1;
			attenceSetUCC.caclRest(personGroupLists,attpersonarrangebo,sum);
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
		      AttPersonArrangeBO attpersonarrangebo=attenceSetUCC.findAttPersonArrangeBObyId(attpersonarrangeitembo.getArrangeId());
		      attpersonarrangeitembo.setLinkClass(attpersonarrangebo.getLinkClass());
		      attenceSetUCC.saveorupdateAttPersonArrangeItemBO(attpersonarrangeitembo);
		      //计算存休
		      List daylists=(List)super.getHttpSession().getAttribute("lists");
				String groupId=attpersonarrangebo.getGroupId();
				List personGroupLists=attenceSetUCC.findPersonsAttClassGroupVO(groupId);//在编人数
		      int sum1=attenceSetUCC.caclFeast(daylists,orgId); //当月节假日天数
				int sum2=Integer.parseInt(attpersonarrangebo.getRestDay()); //当月休息天数
				int sum3=daylists.size(); //当月天数
				int sum=sum3-sum2-sum1;
				attenceSetUCC.caclRest(personGroupLists,attpersonarrangebo,sum);
			}
			itemId="";
			}catch(Exception e){
				e.printStackTrace();
			}
		return "";
	}
	
}
