package com.hr319wg.eva.web;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.hr319wg.common.Constants;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.eva.pojo.bo.EvaAGItemBO;
import com.hr319wg.eva.pojo.bo.EvaAuditGroupBO;
import com.hr319wg.eva.pojo.bo.EvaKeyItemBO;
import com.hr319wg.eva.pojo.bo.EvaLevelPurview;
import com.hr319wg.eva.pojo.bo.EvaMasterBO;
import com.hr319wg.eva.pojo.bo.EvaObjectsBO;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.pojo.bo.EvaScoreBO;
import com.hr319wg.eva.pojo.bo.EvaTemplateBO;
import com.hr319wg.eva.pojo.bo.TemplateItemBO;
import com.hr319wg.eva.ucc.IEvaKeyItemUCC;
import com.hr319wg.eva.ucc.IEvaObjectsUCC;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.eva.ucc.IEvaScoreUCC;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;

public class EvaAuditGroupMgrBackBean extends BaseBackingBean {
	private IEvaObjectsUCC objectUCC;
	private IEvaKeyItemUCC itemkeyUCC;
	private IEvaScoreUCC scoreUCC;
	private String pageInit;
	private String planId;
	private List groupList;
	private String groupId;
	private String initEdit;
	private EvaAuditGroupBO groupbo=new EvaAuditGroupBO();
	
	public IEvaScoreUCC getScoreUCC() {
		return scoreUCC;
	}

	public void setScoreUCC(IEvaScoreUCC scoreUCC) {
		this.scoreUCC = scoreUCC;
	}

	public IEvaKeyItemUCC getItemkeyUCC() {
		return itemkeyUCC;
	}

	public void setItemkeyUCC(IEvaKeyItemUCC itemkeyUCC) {
		this.itemkeyUCC = itemkeyUCC;
	}

	public String saveGroup(){
		try{
			groupbo.setPlanId(planId);
			objectUCC.saveEvaAuditGroupBO(groupbo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	
	public String getInitEdit() {
		try{
			if(super.getRequestParameter("planId")!=null){
				planId=super.getRequestParameter("planId");
				groupbo=new EvaAuditGroupBO();
			}else if(super.getRequestParameter("groupId")!=null){
				groupId=super.getRequestParameter("groupId");
				groupbo=objectUCC.findEvaAuditGroupBO(groupId);
				planId=groupbo.getPlanId();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public EvaAuditGroupBO getGroupbo() {
		return groupbo;
	}

	public void setGroupbo(EvaAuditGroupBO groupbo) {
		this.groupbo = groupbo;
	}

	public String deleteGroup(){
		try{
			objectUCC.deleteEvaAuditGroupBO(groupId);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public IEvaObjectsUCC getObjectUCC() {
		return objectUCC;
	}
	public void setObjectUCC(IEvaObjectsUCC objectUCC) {
		this.objectUCC = objectUCC;
	}
	public void doQuery(){
		try{
			groupList=objectUCC.getAllEvaAuditGroupBOByPlanId(planId);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getPageInit() {
		if(super.getRequestParameter("planId")!=null){
			planId=super.getRequestParameter("planId");
		}
		doQuery();
		return pageInit;
	}
	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	public String getPlanId() {
		return planId;
	}
	public void setPlanId(String planId) {
		this.planId = planId;
	}
	public List getGroupList() {
		return groupList;
	}
	public void setGroupList(List groupList) {
		this.groupList = groupList;
	}
	public String getGroupId() {
		return groupId;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	//设置评审团
	private String initGroup;
	private List personList;
	private String itemId;
	private String initPersonEidt;
	private EvaAGItemBO itembo=new EvaAGItemBO();
	private String isPurview;
	private String queryValue;
	
	public String getQueryValue() {
		return queryValue;
	}

	public void setQueryValue(String queryValue) {
		this.queryValue = queryValue;
	}

	public String getIsPurview() {
		return isPurview;
	}

	public void setIsPurview(String isPurview) {
		this.isPurview = isPurview;
	}

	public String selPerson(){
		PersonBO[] pbos=(PersonBO[])super.getHttpSession().getAttribute(Constants.SELPERSON_SESSION);
		String personId="";
		String personName="";
		if(pbos!=null&&pbos.length>0){
			for(int i=0;i<pbos.length;i++){
				if(personId.equals("")){
					personId+=pbos[i].getPersonId();
				}else{
					personId+=","+pbos[i].getPersonId();
				}
				if(personName.equals("")){
					personName+=pbos[i].getName();
				}else{
					personName+=","+pbos[i].getName();
				}
			}
			itembo.setPersonId(personId);
			itembo.setPersonName(personName);
		}else{
			super.showMessageDetail("请选择考核人员！");
		}
		return "";
	}

	
	public String savePerson(){
		try{
			String pids[]=itembo.getPersonId().split(",");
			for(int i=0;i<pids.length;i++){
				if(pids[i]!=null&&!pids[i].equals("")){
					EvaAGItemBO ebo=objectUCC.findEvaAGItemBOByPersonIdAndGroupId(groupId, pids[i]);
					if(null==ebo){
						EvaAGItemBO bo=new EvaAGItemBO();
						bo.setGroupId(groupId);
						bo.setMasterType(itembo.getMasterType());
						bo.setPersonId(pids[i]);
						if(isPurview.equals(EvaPlanBO.EVA_PRUVIEW_PERSON)){
							bo.setPurview(itembo.getPurview());
						}
						objectUCC.saveEvaAGItemBO(bo);
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	
	public String getInitPersonEidt() {
		try{
			if(super.getRequestParameter("groupId")!=null){
				groupId=super.getRequestParameter("groupId");
				itembo=new EvaAGItemBO();
				isPurview=evaplanucc.findPlanById(objectUCC.findEvaAuditGroupBO(groupId).getPlanId()).getPruview();
				itembo.setPersonId("");
				itembo.setPersonName("");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initPersonEidt;
	}

	public void setInitPersonEidt(String initPersonEidt) {
		this.initPersonEidt = initPersonEidt;
	}

	public EvaAGItemBO getItembo() {
		return itembo;
	}

	public void setItembo(EvaAGItemBO itembo) {
		this.itembo = itembo;
	}
	public String deletePersons(){
		try{
			String ids=super.getRequestParameter("form1:personStr");
			if(ids!=null&&!ids.equals("")){
				String id[]=ids.split(",");
				for(int i=0;i<id.length;i++){
					if(id[i]!=null&&!id[i].equals("")){
						objectUCC.deleteEvaAGItemBO(id[i]);
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}

	public String deletePerson(){
		try{
			objectUCC.deleteEvaAGItemBO(itemId);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public void queryPerson(){
		try{
			personList=objectUCC.getAllEvaAGItemBOByGroupId(groupId,queryValue);
			if(personList!=null&&personList.size()>0){
				for(int i=0;i<personList.size();i++){
					EvaAGItemBO bo=(EvaAGItemBO)personList.get(i);
					bo.setPersonId(SysCacheTool.findPersonById(bo.getPersonId()).getName());
					bo.setMasterType(CodeUtil.interpertCode(bo.getMasterType()));
					personList.set(i, bo);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getInitGroup() {
		try{
			if(super.getRequestParameter("groupId")!=null){
				groupId=super.getRequestParameter("groupId");
				isPurview=evaplanucc.findPlanById(objectUCC.findEvaAuditGroupBO(groupId).getPlanId()).getPruview();
			}
			queryPerson();
		}catch(Exception e){
			e.printStackTrace();
		}
		return initGroup;
	}

	public void setInitGroup(String initGroup) {
		this.initGroup = initGroup;
	}

	public List getPersonList() {
		return personList;
	}

	public void setPersonList(List personList) {
		this.personList = personList;
	}
	//批量增加考核主体
	private String pageInit2;
	private String objectIDs;
	 private IEvaPlanUCC evaplanucc;
	
	public IEvaPlanUCC getEvaplanucc() {
		return evaplanucc;
	}

	public void setEvaplanucc(IEvaPlanUCC evaplanucc) {
		this.evaplanucc = evaplanucc;
	}

	public String setGroupMaster(){
		try{
			EvaPlanBO plbo=evaplanucc.findPlanById(planId);
			String planPurview=plbo.getPruview();
			String mode=plbo.getEvaModel();
			NumberFormat   nf   =   NumberFormat.getInstance(); 
			String pers=plbo.getLevelPers();
			if(pers!=null&&!pers.equals("")){
				nf.setMaximumFractionDigits(Integer.parseInt(pers));
			}else{
				nf.setMaximumFractionDigits(2);
			}
			Hashtable tempItemList=new Hashtable();
			Hashtable tempItem=new Hashtable();
			String tempIds="'1'";
			if(plbo.getTemplates()!=null&&!plbo.getTemplates().equals("")){
				String ids[]=plbo.getTemplates().split(",");
				for(int i=0;i<ids.length;i++){
					if(ids[i]!=null&&!ids[i].equals("")){
						tempIds+=",'"+ids[i]+"'";
					}
				}
			}
			List tempList=itemkeyUCC.getAllTemplateByTemplateIds(tempIds);
			if(tempList!=null&&tempList.size()>0){
				for(int i=0;i<tempList.size();i++){
	    			EvaTemplateBO bo=(EvaTemplateBO)tempList.get(i);
	    			List itemList=itemkeyUCC.getAllItemByTemplateID(bo.getTemplateID());
	    			if(itemList!=null&&itemList.size()>0){
	    				tempItemList.put(bo.getTemplateID(), itemList);
	    				for(int j=0;j<itemList.size();j++){
	    					TemplateItemBO itbo=(TemplateItemBO)itemList.get(j);
	    					EvaKeyItemBO keybo=itemkeyUCC.getEvaKeyItemBO(itbo.getLinkID());
	    					tempItem.put(bo.getTemplateID()+itbo.getItemID()+itbo.getLinkID(), keybo);
	    				}
	    			}
	    		}
			}
			List masterList=objectUCC.getAllEvaAGItemBOByGroupId(groupId,null);
			if(objectIDs!=null&&!objectIDs.equals("")){
				String objIds[]=objectIDs.split(",");
				Hashtable masterHash=objectUCC.getEvaMasterBOByObjectIdsForHash(objIds);
				Hashtable objectHash=objectUCC.getEvaObjectBOByObjectIds(objIds);
				for(int i=0;i<objIds.length;i++){
					if(objIds[i]!=null&&!objIds[i].equals("")){
						EvaObjectsBO obj=(EvaObjectsBO)objectHash.get(objIds[i]);
						if(masterList!=null&&masterList.size()>0){
							for(int j=0;j<masterList.size();j++){
								EvaAGItemBO bo=(EvaAGItemBO)masterList.get(j);
								EvaMasterBO mbo=(EvaMasterBO)masterHash.get(obj.getObjectID()+bo.getPersonId());
								if(null==mbo){
									EvaMasterBO masterbo=new EvaMasterBO();
									masterbo.setMasterType(bo.getMasterType());
									masterbo.setPersonID(bo.getPersonId());
									masterbo.setObjectID(obj.getObjectID());
									if(planPurview.equals(EvaPlanBO.EVA_PRUVIEW_PERSON)){
										masterbo.setPurview(bo.getPurview());
									}else{
										List result=objectUCC.getMastersByMasterType(obj.getObjectID(),bo.getMasterType());
										String allpur;
										EvaLevelPurview levelbo=objectUCC.getLevelPurviewByObjectIdAndType(obj.getObjectID(), masterbo.getMasterType());
										if(levelbo!=null){
											if(levelbo.getPurview()!=null&&!levelbo.getPurview().equals("")){
												allpur=levelbo.getPurview();
											}else{
												allpur="0";
											}
										}else{
											allpur="0";
										}
										double allcount=Double.parseDouble(allpur);
										if(result!=null&&result.size()>0){
											masterbo.setPurview(new Double(nf.format(allcount/(result.size()+1))).toString());
											for(int n=0;n<result.size();n++){
												EvaMasterBO masterbo1=(EvaMasterBO)result.get(n);
												masterbo1.setPurview(new Double(nf.format(allcount/(result.size()+1))).toString());
												objectUCC.updateMasterbo(masterbo1);
											}
										}else{
											masterbo.setPurview(allpur);
										}
									}
									objectUCC.saveEvaMasterBO(masterbo);
									if(mode.equals("0")){
										List list =(ArrayList)tempItemList.get(obj.getTemplateID());
										for (int m = 0;m < list.size(); m++) {
											TemplateItemBO itembo = (TemplateItemBO) list.get(m);
											EvaKeyItemBO keybo=(EvaKeyItemBO)tempItem.get(obj.getTemplateID()+itembo.getItemID()+itembo.getLinkID());
											if(!keybo.getItemType().equals("2")){
												EvaScoreBO score = new EvaScoreBO();
												score.setMasterID(masterbo.getMasterID());
												score.setObjectID(obj.getObjectID());
												score.setItemID(itembo.getItemID());
												this.scoreUCC.saveScore(score);
											}
										}
									}else{
										EvaScoreBO score = new EvaScoreBO();
										score.setMasterID(masterbo.getMasterID());
										score.setObjectID(obj.getObjectID());
										this.scoreUCC.saveScore(score);
									}
								}
							}
						}
					}
				}
			}
			super.showMessageDetail("加入成功！");
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}

	public String getPageInit2() {
		if(super.getRequestParameter("objectIDs")!=null){
			objectIDs=super.getRequestParameter("objectIDs");
		}
		if(super.getRequestParameter("planId")!=null){
			planId=super.getRequestParameter("planId");
		}
		doQuery();
		return pageInit2;
	}

	public void setPageInit2(String pageInit2) {
		this.pageInit2 = pageInit2;
	}

	public String getObjectIDs() {
		return objectIDs;
	}

	public void setObjectIDs(String objectIDs) {
		this.objectIDs = objectIDs;
	}
}
