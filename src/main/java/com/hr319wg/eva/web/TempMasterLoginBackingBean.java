package com.hr319wg.eva.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.eva.pojo.bo.EvaMasterBO;
import com.hr319wg.eva.pojo.bo.EvaObjectsBO;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.pojo.bo.EvaTempMasterBO;
import com.hr319wg.eva.ucc.IEvaObjectsUCC;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.sys.cache.SysCacheTool;

public class TempMasterLoginBackingBean extends BaseBackingBean {
	private String username;
	private String password;
	private String repassword;
	private EvaTempMasterBO evaTempMasterBO;
	private IEvaObjectsUCC objectUCC;
	private List evaTempMasterBOList;
	private String objectsInit;
	private List planList = new ArrayList();
	private IEvaPlanUCC evaPlanUCC;
	private List objectsList = new ArrayList();
	private String masterID;
	private String templateID;
	private String objectID;
	private String masterName;

	public EvaTempMasterBO getEvaTempMasterBO() {
		return evaTempMasterBO;
	}

	public void setEvaTempMasterBO(EvaTempMasterBO evaTempMasterBO) {
		this.evaTempMasterBO = evaTempMasterBO;
	}

	public List getEvaTempMasterBOList() {
		return evaTempMasterBOList;
	}

	public void setEvaTempMasterBOList(List evaTempMasterBOList) {
		this.evaTempMasterBOList = evaTempMasterBOList;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRepassword() {
		return repassword;
	}

	public void setRepassword(String repassword) {
		this.repassword = repassword;
	}

	public IEvaObjectsUCC getObjectUCC() {
		return objectUCC;
	}

	public void setObjectUCC(IEvaObjectsUCC objectUCC) {
		this.objectUCC = objectUCC;
	}

	public String getObjectsInit() {
		try {
			objectsList.clear();
			if(super.getHttpSession().getAttribute("evaTempMasterBO")!=null){
				EvaTempMasterBO masterbo=(EvaTempMasterBO)super.getHttpSession().getAttribute("evaTempMasterBO");
				SelectItem si0 = new SelectItem();
				si0.setLabel("请选择考核客体");
				si0.setValue("-1");
				objectsList.add(si0);
				String materId=masterbo.getMasterID();
				String planId=masterbo.getEvaPlanID();
				if(planId!=null && !("").equals(planId))
				{
					 EvaPlanBO planbo=evaPlanUCC.findPlanById(planId);
					 if(planbo!=null && !planbo.equals("")){
						 String planstatus=planbo.getStatus();
						 if(planstatus.equals(EvaPlanBO.EVA_PLANSTATUS_EXECUTE)){
							List objectList=objectUCC.getObjectsByPlanId(null,planId);
							if(objectList!=null && objectList.size()>0){
								for(int i=0;i<objectList.size();i++){
									SelectItem si = new SelectItem();
									EvaObjectsBO objectbo=(EvaObjectsBO)objectList.get(i);
									String objectId=objectbo.getObjectID();
									if(objectId!=null && !("").equals(objectId)){
										String personId=objectbo.getPersonID();
										if(personId!=null && !("").equals(personId)){
											PersonBO personbo=SysCacheTool.findPersonById(personId);
											if(personbo!=null && !("").equals(personbo)){
												si.setLabel(personbo.getName());
												si.setValue(objectId);
												objectsList.add(si);
											}
										}
									}
									
								}
								
							}
						 }
						 else{
							 super.showMessageDetail("打分过程已经结束");
						 }
					 }
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		
		return objectsInit;
	}
	public void setObjectsInit(String objectsInit) {
		this.objectsInit = objectsInit;
	}

	public void doObject(ValueChangeEvent event)
	{
		try {
			String objectId=event.getNewValue().toString();
			if(objectId!=null && !("").equals(objectId)){
				//要根据登录的masterID得到personID，然后再加上这个objectID，两个共同决定一个evaMaster表中的masterID
				if(super.getHttpSession().getAttribute("evaTempMasterBO")!=null){
					EvaTempMasterBO masterbo=(EvaTempMasterBO)super.getHttpSession().getAttribute("evaTempMasterBO");
					String personid=masterbo.getMasterName();
					List masterList=objectUCC.getMasterIdByOIdandPid(objectId, personid);
					if(masterList!=null && masterList.size()>0){
						EvaMasterBO BO=(EvaMasterBO)masterList.get(0);
						String masterId=BO.getMasterID();
						if(masterId!=null && !("").equals(masterId)){
							super.getHttpSession().setAttribute("masterId", masterId);
						}
					}
				    PersonBO pbo=SysCacheTool.findPersonById(masterbo.getMasterName());
				    if(pbo!=null && !pbo.equals("")){
				    	this.masterName=pbo.getName();
				    }
				}
				EvaObjectsBO bo=objectUCC.findEvaObjectBOById(objectId);
					if(bo!=null && !("").equals(bo)){
						String templateid=bo.getTemplateID();
						if(templateid!=null && !("").equals(templateid)){
							super.getHttpSession().setAttribute("templateid", templateid);
						}else{
							super.getHttpSession().setAttribute("templateid", null);
						}
					}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		
	}
	public List getPlanList() {
		return planList;
	}

	public void setPlanList(List planList) {
		this.planList = planList;
	}

	public IEvaPlanUCC getEvaPlanUCC() {
		return evaPlanUCC;
	}

	public void setEvaPlanUCC(IEvaPlanUCC evaPlanUCC) {
		this.evaPlanUCC = evaPlanUCC;
	}

	public String getTemplateID() {
		if (super.getHttpSession().getAttribute("templateid") != null) {
			this.templateID = super.getHttpSession().getAttribute("templateid")
					.toString();
		}
		return templateID;
	}

	public void setTemplateID(String templateID) {
		this.templateID = templateID;
	}

	public List getObjectsList() {
		return objectsList;
	}

	public void setObjectsList(List objectsList) {
		this.objectsList = objectsList;
	}

	public String getObjectID() {
		return objectID;
	}

	public void setObjectID(String objectID) {
		this.objectID = objectID;
	}

	public String getMasterName() {
		
		return masterName;
	}

	public void setMasterName(String masterName) {
		this.masterName = masterName;
	}

	public String getMasterID() {
        if(super.getHttpSession().getAttribute("masterId")!=null){
		   this.masterID=super.getHttpSession().getAttribute("masterId").toString();
		}
		return masterID;
	}

	public void setMasterID(String masterID) {
		this.masterID = masterID;
	}
}
