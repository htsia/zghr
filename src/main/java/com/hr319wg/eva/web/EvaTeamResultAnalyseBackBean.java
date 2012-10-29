package com.hr319wg.eva.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.pojo.bo.EvaTemplateBO;
import com.hr319wg.eva.ucc.IEvaKeyItemUCC;
import com.hr319wg.eva.ucc.IEvaObjectsUCC;
import com.hr319wg.eva.ucc.IEvaPlanUCC;

public class EvaTeamResultAnalyseBackBean extends BaseBackingBean {
	private IEvaKeyItemUCC itemkeyUCC;
	private IEvaObjectsUCC objectUCC;
	private IEvaPlanUCC evaplanucc;
	private List templates;
	private String templateId;
	private String pageInit;
	private PageVO pagevo = new PageVO();
	private String planId;
	private List objectList;
	
	public IEvaPlanUCC getEvaplanucc() {
		return evaplanucc;
	}
	public void setEvaplanucc(IEvaPlanUCC evaplanucc) {
		this.evaplanucc = evaplanucc;
	}
	
	public void changeTemp(ValueChangeEvent evt){
		templateId=evt.getNewValue().toString();
	}
	public String first() {
		pagevo.setCurrentPage(1);
		doQuery();
		return "";
	}

	public String last() {
		pagevo.setCurrentPage(pagevo.getTotalPage());
		doQuery();
		return "";
	}

	public String pre() {
		if (pagevo.getCurrentPage() >= 2) {
			pagevo.setCurrentPage(pagevo.getCurrentPage() - 1);
			doQuery();
		}
		return "";
	}

	public String next() {
		if (pagevo.getCurrentPage() < pagevo.getTotalPage()) {
			pagevo.setCurrentPage(pagevo.getCurrentPage() + 1);
			doQuery();
		}
		return "";
	}
	public void doQuery(){
		try{
			templates = new ArrayList();
			SelectItem si0 = new SelectItem();
			si0.setLabel("ÇëÑ¡Ôñ");
			si0.setValue("");
			templates.add(si0);
			if(planId!=null&&!planId.equals("")){
				EvaPlanBO planbo=evaplanucc.findPlanById(planId);
				if(planbo.getTemplates()!=null&&!planbo.getTemplates().equals("")){
					String ids[]=planbo.getTemplates().split(",");
					for (int i = 0; i < ids.length; i++) {
						if(ids[i]!=null&&!ids[i].equals("")){
							EvaTemplateBO tempbo = itemkeyUCC.findTemplateBO(ids[i]);
							SelectItem si = new SelectItem();
							si.setLabel(tempbo.getTemplateName());
							si.setValue(tempbo.getTemplateID());
							templates.add(si);
						}
					}
				}
			}
			super.getHttpSession().removeAttribute("objectList");
			super.getHttpSession().removeAttribute("templateId");
			super.getHttpSession().removeAttribute("gradeId");
			if (pagevo.getCurrentPage() == 0)
				pagevo.setCurrentPage(1);
			objectList=objectUCC.getEvaObjectsBOByPlanIdAndTimId(pagevo, planId, templateId);
			if(objectList!=null&&objectList.size()>0){
				super.getHttpSession().setAttribute("objectList", objectList);
				super.getHttpSession().setAttribute("templateId", templateId);
				super.getHttpSession().setAttribute("gradeId", evaplanucc.findPlanById(planId).getPlanGrade());
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public IEvaKeyItemUCC getItemkeyUCC() {
		return itemkeyUCC;
	}
	public void setItemkeyUCC(IEvaKeyItemUCC itemkeyUCC) {
		this.itemkeyUCC = itemkeyUCC;
	}
	public IEvaObjectsUCC getObjectUCC() {
		return objectUCC;
	}
	public void setObjectUCC(IEvaObjectsUCC objectUCC) {
		this.objectUCC = objectUCC;
	}
	public List getTemplates() {
		return templates;
	}
	public void setTemplates(List templates) {
		this.templates = templates;
	}
	public String getTemplateId() {
		return templateId;
	}
	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}
	public String getPageInit() {
		if(super.getRequestParameter("planID")!=null){
			planId=super.getRequestParameter("planID");
		}
		doQuery();
		return pageInit;
	}
	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	public PageVO getPagevo() {
		return pagevo;
	}
	public void setPagevo(PageVO pagevo) {
		this.pagevo = pagevo;
	}
	public String getPlanId() {
		return planId;
	}
	public void setPlanId(String planId) {
		this.planId = planId;
	}
	public List getObjectList() {
		return objectList;
	}
	public void setObjectList(List objectList) {
		this.objectList = objectList;
	}
}
