package com.hr319wg.eva.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.EmpTeamInfoBo;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.ucc.teamManagerUcc;
import com.hr319wg.eva.pojo.bo.EvaMasterBO;
import com.hr319wg.eva.pojo.bo.EvaObjectsBO;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.pojo.bo.EvaTemplateBO;
import com.hr319wg.eva.ucc.IEvaKeyItemUCC;
import com.hr319wg.eva.ucc.IEvaObjectsUCC;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;

public class EvaTeamSetBackBean extends BaseBackingBean {
	private IEvaKeyItemUCC itemkeyUCC;
	private IEvaObjectsUCC objectUCC;
	private IEvaPlanUCC evaplanucc;
	private List templates;
	private String templateId="-1";//默认显示全部模板
	private String pageInit;
	private PageVO pagevo = new PageVO();
	private String planId;
	private List objectList;
	private teamManagerUcc teamucc;
	
	public teamManagerUcc getTeamucc() {
		return teamucc;
	}

	public void setTeamucc(teamManagerUcc teamucc) {
		this.teamucc = teamucc;
	}

	public void changeTemp(ValueChangeEvent evt){
		templateId=evt.getNewValue().toString();
		doQuery();
	}
	
	public IEvaPlanUCC getEvaplanucc() {
		return evaplanucc;
	}

	public void setEvaplanucc(IEvaPlanUCC evaplanucc) {
		this.evaplanucc = evaplanucc;
	}

	public List getObjectList() {
		return objectList;
	}

	public void setObjectList(List objectList) {
		this.objectList = objectList;
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
	public String getTemplateId() {
		return templateId;
	}
	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}
	public void doQuery(){
		try{
			if (pagevo.getCurrentPage() == 0)
				pagevo.setCurrentPage(1);
			if(templateId.equals("-1")){
				objectList=objectUCC.getResultScore(pagevo, planId,null,EvaPlanBO.OBJCT_TYPE_TEAM);
			}else{
				objectList=objectUCC.getEvaObjectsBOByPlanIdAndTimId(pagevo, planId, templateId);
			}
			if(objectList!=null&&objectList.size()>0){
				for(int i=0;i<objectList.size();i++){
					EvaObjectsBO bo=(EvaObjectsBO)objectList.get(i);
					EmpTeamInfoBo tbo=teamucc.findEmpTeamInfoBoById(bo.getPersonID());
					bo.setTeamName(tbo.getTeamName());
					bo.setTeamCreateDate(tbo.getCreateTime());
					bo.setOrgName(SysCacheTool.findOrgById(tbo.getCreateOrg()).getName());
					bo.setTemplateName(itemkeyUCC.findTemplateBO(bo.getTemplateID()).getTemplateName());
					objectList.set(i, bo);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getPageInit() {
		if(super.getRequestParameter("planID")!=null){
			planId=super.getRequestParameter("planID");
		}
		doQuery();
		getTemplates();
		return pageInit;
	}
	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	public List getTemplates() {
		try{
			templates = new ArrayList();
			SelectItem si0 = new SelectItem();
			si0.setLabel("请选择");
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
		}catch(Exception e){
			e.printStackTrace();
		}
		return templates;
	}
	public void setTemplates(List templates) {
		this.templates = templates;
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
	//增加删除团队
	private String teamIds;
	private String orgId;
	private String objectID;
	private String itemAddInite;
	private List teamList;

	public String getItemAddInite() {
		try{
			if(super.getRequestParameter("planId")!=null){
				planId=super.getRequestParameter("planId");
			}
			teamList=new ArrayList();
			List teamList1=teamucc.getAllEmpTeamInfoBo(super.getUserInfo().getOrgId());
			if(teamList1!=null&&teamList1.size()>0){
				for(int i=0;i<teamList1.size();i++){
					EmpTeamInfoBo tbo=(EmpTeamInfoBo)teamList1.get(i);
					EvaObjectsBO bo=objectUCC.getEvaObjectsBOByPlanIdAndPersonId(planId, tbo.getTeamId());
					if(bo==null){
						tbo.setCreateOrg(SysCacheTool.findOrgById(tbo.getCreateOrg()).getName());
						teamList.add(tbo);
					}
					
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return itemAddInite;
	}

	public void setItemAddInite(String itemAddInite) {
		this.itemAddInite = itemAddInite;
	}

	public List getTeamList() {
		return teamList;
	}

	public void setTeamList(List teamList) {
		this.teamList = teamList;
	}

	public String getTeamIds() {
		return teamIds;
	}

	public void setTeamIds(String teamIds) {
		this.teamIds = teamIds;
	}

	public String getObjectID() {
		return objectID;
	}

	public void setObjectID(String objectID) {
		this.objectID = objectID;
	}

	public String delete(){
		try{
			objectUCC.deleteEvaObject(objectID);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public String getOrgId() {
		return super.getUserInfo().getOrgId();
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String addObject(){
		try{
			String ids[]=teamIds.split(",");
			if(ids!=null&&ids.length>0){
				for(int i=0;i<ids.length;i++){
					if(ids[i]!=null&&!ids[i].equals("")){
						EvaObjectsBO ebo=objectUCC.getEvaObjectsBOByPlanIdAndPersonId(planId, ids[i]);
						if(ebo==null){
							EvaObjectsBO bo=new EvaObjectsBO();
							bo.setPersonID(ids[i]);
							bo.setPlanID(planId);
							bo.setTemplateID(templateId);
							objectUCC.savaEvaObject(bo);
						}
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	//设置权重
	private String initmaster;
	private List masterPersonList;
	private String teamName;

	public String getInitmaster() {
		try{
			if(super.getRequestParameter("objectID") != null){
				objectID=super.getRequestParameter("objectID");
				EvaObjectsBO bo=objectUCC.findEvaObjectBOById(objectID);
				teamName=teamucc.findEmpTeamInfoBoById(bo.getPersonID()).getTeamName();
			}
			queryMaster();
		}catch(Exception e){
			e.printStackTrace();
		}
		return initmaster;
	}
	private void queryMaster() {
		try {
			masterPersonList = objectUCC.getMasters(objectID,null);
			for (int i = 0; i < masterPersonList.size(); i++) {
				EvaMasterBO ebo = (EvaMasterBO) masterPersonList.get(i);
				PersonBO pb = SysCacheTool.findPersonById(ebo.getPersonID());
				if (pb != null) {
					ebo.setPersonName(pb.getName());
					ebo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG,
							pb.getDeptId()));
				}
			}
		} catch (Exception e) {

		}
	}
	public void setInitmaster(String initmaster) {
		this.initmaster = initmaster;
	}

	public List getMasterPersonList() {
		return masterPersonList;
	}

	public void setMasterPersonList(List masterPersonList) {
		this.masterPersonList = masterPersonList;
	}

	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	//打分 
	private String initTeamMaster;
	private String masterID;
	private EvaObjectsBO objectbo=new EvaObjectsBO();
	private List masterList;
	
	public void queryMasterList(){
		try {
			masterList=new ArrayList();
			 SelectItem si0=new SelectItem();
             si0.setLabel("--请选择主体--");
             si0.setValue("-1");
             masterList.add(si0);
             List list = objectUCC.getMasters(objectID,null);
             for (int i = 0; i < list.size(); i++) {
				EvaMasterBO ebo = (EvaMasterBO) list.get(i);
				PersonBO pb = SysCacheTool.findPersonById(ebo.getPersonID());
				SelectItem si=new SelectItem();
                si.setLabel(pb.getName());
                si.setValue(ebo.getMasterID());
                masterList.add(si);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public String getInitTeamMaster() {
		try{
            if (super.getRequestParameter("objectID")!=null){
                objectID=super.getRequestParameter("objectID");
                objectbo=objectUCC.findEvaObjectBOById(objectID);
                teamName=teamucc.findEmpTeamInfoBoById(objectbo.getPersonID()).getTeamName();
            }
            queryMasterList();
        }
        catch(Exception e){
        	e.printStackTrace();
        }
		return initTeamMaster;
	}

	public void setInitTeamMaster(String initTeamMaster) {
		this.initTeamMaster = initTeamMaster;
	}

	public String getMasterID() {
		return masterID;
	}

	public void setMasterID(String masterID) {
		this.masterID = masterID;
	}

	public EvaObjectsBO getObjectbo() {
		return objectbo;
	}

	public void setObjectbo(EvaObjectsBO objectbo) {
		this.objectbo = objectbo;
	}

	public List getMasterList() {
		return masterList;
	}

	public void setMasterList(List masterList) {
		this.masterList = masterList;
	}
	
}
