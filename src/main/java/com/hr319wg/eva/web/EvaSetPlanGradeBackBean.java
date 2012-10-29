package com.hr319wg.eva.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.model.SelectItem;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.eva.pojo.bo.EvaGradeItemBO;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.pojo.bo.EvaPlanControlBO;
import com.hr319wg.eva.pojo.bo.EvaTemplateBO;
import com.hr319wg.eva.ucc.IEvaGradeUCC;
import com.hr319wg.eva.ucc.IEvaKeyItemUCC;
import com.hr319wg.eva.ucc.IEvaPlanUCC;

public class EvaSetPlanGradeBackBean extends BaseBackingBean {
	private IEvaGradeUCC gradeUCC;
	private IEvaPlanUCC evaplanucc;
	private IEvaKeyItemUCC itemkeyUCC;
	private String planId;
	private List itemList;
	private String initItem;
	private String templateIds;
	private String inintTemplateList;
	private List templateList;
	
	public List getTemplateList() {
		return templateList;
	}

	public void setTemplateList(List templateList) {
		this.templateList = templateList;
	}

	public String getInintTemplateList() {
		try{
			if(super.getRequestParameter("planId")!=null){
				planId=super.getRequestParameter("planId");
			}
			templateList=new ArrayList();
			EvaPlanBO planbo=evaplanucc.findPlanById(planId);
			String ids=planbo.getTemplates();
			if(ids!=null&&!ids.equals("")){
				String temIds[]=ids.split(",");
				List list=itemkeyUCC.getAllTemplate(null,super.getUserInfo().getOrgId());
				if(list!=null&&list.size()>0){
					for(int i=0;i<list.size();i++){
						EvaTemplateBO bo=(EvaTemplateBO)list.get(i);
						boolean isexist=false;
						for(int j=0;j<temIds.length;j++){
							if(temIds[j]!=null&&temIds[j].equals(bo.getTemplateID())){
								isexist=true;
								break;
							}
						}
						if(isexist==false){
							templateList.add(bo);
						}
					}
				}
			}else{
				templateList=itemkeyUCC.getAllTemplate(null,super.getUserInfo().getOrgId());
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return inintTemplateList;
	}

	public void setInintTemplateList(String inintTemplateList) {
		this.inintTemplateList = inintTemplateList;
	}

	public String saveTemplates(){
		try{
			EvaPlanBO planbo=evaplanucc.findPlanById(planId);
			String ids=planbo.getTemplates();
			if(templateIds!=null&&!templateIds.equals("")){
				String templateIds1="";
				String ids1[]=templateIds.split(",");
				for(int i=0;i<ids1.length;i++){
					if(templateIds1.equals("")){
						if(ids1[i]!=null&&!ids1[i].equals("")){
							if(ids!=null&&!ids.equals("")){
								if(ids.indexOf(ids1[i])<0){
									templateIds1+=ids1[i];
								}
							}else{
								templateIds1+=ids1[i];
							}
						}
					}else{
						if(ids1[i]!=null&&!ids1[i].equals("")){
							if(ids!=null&&!ids.equals("")){
								if(ids.indexOf(ids1[i])<0){
									templateIds1+=","+ids1[i];
								}
							}else{
								templateIds1+=","+ids1[i];
							}
						}
					}
				}
				if(templateIds1!=null&&!templateIds1.equals("")){
					if(ids!=null&&!ids.equals("")){
						ids+=","+templateIds1;
					}else{
						ids=templateIds1;
					}
				}
				planbo.setTemplates(ids);
				evaplanucc.updatePlan(planbo);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	public String deleteTemplate(){
		try{
			EvaPlanBO planbo=evaplanucc.findPlanById(planId);
			if(planbo.getTemplates()!=null&&!planbo.getTemplates().equals("")){
				String tempIds="";
				String ids[]=planbo.getTemplates().split(",");
				for(int i=0;i<ids.length;i++){
					if(tempIds.equals("")){
						if(!templateId.equals(ids[i])){
							tempIds+=ids[i];
						}
					}else{
						if(!templateId.equals(ids[i])){
							tempIds+=","+ids[i];
						}
					}
				}
				planbo.setTemplates(tempIds);
				evaplanucc.updatePlan(planbo);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public String getTemplateIds() {
		return templateIds;
	}
	public void setTemplateIds(String templateIds) {
		this.templateIds = templateIds;
	}
	public IEvaKeyItemUCC getItemkeyUCC() {
		return itemkeyUCC;
	}
	public void setItemkeyUCC(IEvaKeyItemUCC itemkeyUCC) {
		this.itemkeyUCC = itemkeyUCC;
	}
	public IEvaGradeUCC getGradeUCC() {
		return gradeUCC;
	}
	public void setGradeUCC(IEvaGradeUCC gradeUCC) {
		this.gradeUCC = gradeUCC;
	}
	public IEvaPlanUCC getEvaplanucc() {
		return evaplanucc;
	}
	public void setEvaplanucc(IEvaPlanUCC evaplanucc) {
		this.evaplanucc = evaplanucc;
	}
	public String getPlanId() {
		return planId;
	}
	public void setPlanId(String planId) {
		this.planId = planId;
	}
	public List getItemList() {
		return itemList;
	}
	public void setItemList(List itemList) {
		this.itemList = itemList;
	}
	public void doQuery(){
		try{
			itemList=new ArrayList();
			EvaPlanBO planbo=evaplanucc.findPlanById(planId);
			if(planbo.getTemplates()!=null&&!planbo.getTemplates().equals("")){
				String ids[]=planbo.getTemplates().split(",");
				for(int i=0;i<ids.length;i++){
					EvaTemplateBO bo=itemkeyUCC.findTemplateBO(ids[i]);
					itemList.add(bo);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getInitItem() {
		if(super.getRequestParameter("planId")!=null){
			planId=super.getRequestParameter("planId");
		}
		doQuery();
		return initItem;
	}
	public void setInitItem(String initItem) {
		this.initItem = initItem;
	}
	//ÉèÖÃÄ£°å±ÈÀý
	private String templateId;
	private String initGradeItem;
	private List gradeList;
	private String itemId;
	private String initItemEdit;
	private EvaPlanControlBO controlbo=new EvaPlanControlBO();
	private List gradeItemList;
	
	public List getGradeItemList() {
		try{
			gradeItemList=new ArrayList();
			EvaPlanBO planbo=evaplanucc.findPlanById(planId);
			if(planbo.getPlanGrade()!=null&&!planbo.getPlanGrade().equals("")){
				List itemList=gradeUCC.getAllGradeItem(planbo.getPlanGrade());
				if(itemList!=null&&itemList.size()>0){
					for(int i=0;i<itemList.size();i++){
						EvaGradeItemBO bo=(EvaGradeItemBO)itemList.get(i);
						SelectItem si=new SelectItem();
						si.setLabel(bo.getItemName());
						si.setValue(bo.getItemID());
						gradeItemList.add(si);
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return gradeItemList;
	}

	public void setGradeItemList(List gradeItemList) {
		this.gradeItemList = gradeItemList;
	}

	public String saveControlbo(){
		try{
			controlbo.setTemplateId(templateId);
			controlbo.setPlanId(planId);
			evaplanucc.saveEvaPlanControlBO(controlbo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}

	public String getInitItemEdit() {
		try{
			if(super.getRequestParameter("planId")!=null){
				planId=super.getRequestParameter("planId");
				templateId=super.getRequestParameter("templateId");
				controlbo=new EvaPlanControlBO();
			}else if(super.getRequestParameter("itemId")!=null){
				itemId=super.getRequestParameter("itemId");
				controlbo=evaplanucc.findEvaPlanControlBOById(itemId);
				planId=controlbo.getPlanId();
				templateId=controlbo.getTemplateId();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initItemEdit;
	}

	public void setInitItemEdit(String initItemEdit) {
		this.initItemEdit = initItemEdit;
	}

	public EvaPlanControlBO getControlbo() {
		return controlbo;
	}

	public void setControlbo(EvaPlanControlBO controlbo) {
		this.controlbo = controlbo;
	}

	public String deleteGrade(){
		try{
			evaplanucc.deleteEvaPlanControlBO(itemId);
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
	public List getGradeList() {
		return gradeList;
	}

	public void setGradeList(List gradeList) {
		this.gradeList = gradeList;
	}

	public String getTemplateId() {
		return templateId;
	}
	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}
	public void queryGradeList(){
		try{
			gradeList=evaplanucc.getAllEvaPlanControlBOByPlanIdAndTemId(planId, templateId);
			if(gradeList!=null&&gradeList.size()>0){
				for(int i=0;i<gradeList.size();i++){
					EvaPlanControlBO bo=(EvaPlanControlBO)gradeList.get(i);
					EvaGradeItemBO itembo=gradeUCC.getGradeItem(bo.getGradeItem());
					bo.setGradeItem(itembo.getItemName());
					bo.setLowValue(itembo.getLowValue());
					bo.setHighValue(itembo.getHighValue());
					gradeList.set(i, bo);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getInitGradeItem() {
		if(super.getRequestParameter("templateId")!=null){
			templateId=super.getRequestParameter("templateId");
		}
		if(super.getRequestParameter("planId")!=null){
			planId=super.getRequestParameter("planId");
		}
		queryGradeList();
		return initGradeItem;
	}
	public void setInitGradeItem(String initGradeItem) {
		this.initGradeItem = initGradeItem;
	}
	
	
}
