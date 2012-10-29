package com.hr319wg.eva.web;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.eva.pojo.bo.EvaDefaultLevelBO;
import com.hr319wg.eva.pojo.bo.EvaKeyItemBO;
import com.hr319wg.eva.pojo.bo.EvaLevelPurview;
import com.hr319wg.eva.pojo.bo.EvaMasterBO;
import com.hr319wg.eva.pojo.bo.EvaObjectsBO;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.pojo.bo.EvaScoreBO;
import com.hr319wg.eva.pojo.bo.EvaTemplateBO;
import com.hr319wg.eva.pojo.bo.TemplateItemBO;
import com.hr319wg.eva.pojo.vo.EvaObjectsVO;
import com.hr319wg.eva.ucc.IEvaKeyItemUCC;
import com.hr319wg.eva.ucc.IEvaObjectsUCC;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.eva.ucc.IEvaScoreUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;

public class EvaDeptSetBackBean extends BaseBackingBean {
	private IEvaKeyItemUCC itemkeyUCC;
	private IEvaObjectsUCC objectUCC;
	private IEvaPlanUCC evaplanucc;
	private List templates;
	private String templateId="-1";//默认显示全部模板
	private String pageInit;
	private PageVO pagevo = new PageVO();
	private String planId;
	private List objectList;
	private String planMode;
	private String isPurview;
	private IEvaScoreUCC scoreUCC;
	
	public IEvaScoreUCC getScoreUCC() {
		return scoreUCC;
	}

	public void setScoreUCC(IEvaScoreUCC scoreUCC) {
		this.scoreUCC = scoreUCC;
	}

	public String getIsPurview() {
		return isPurview;
	}

	public void setIsPurview(String isPurview) {
		this.isPurview = isPurview;
	}

	public String getPlanMode() {
		return planMode;
	}

	public void setPlanMode(String planMode) {
		this.planMode = planMode;
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
				objectList=objectUCC.getResultScore(pagevo, planId,null,EvaPlanBO.OBJCT_TYPE_DEPT);
			}else if(planMode.equals(EvaPlanBO.EVA_MODEL_ELECTION)){
				objectList=objectUCC.getResultScore(pagevo, planId,null,EvaPlanBO.OBJCT_TYPE_DEPT);
			}else{
				objectList=objectUCC.getEvaObjectsBOByPlanIdAndTimId(pagevo, planId, templateId);
			}
			if(objectList!=null&&objectList.size()>0){
				for(int i=0;i<objectList.size();i++){
					EvaObjectsBO bo=(EvaObjectsBO)objectList.get(i);
					OrgBO obo=SysCacheTool.findOrgById(bo.getPersonID());
					OrgBO superBo=SysCacheTool.findOrgById(obo.getSuperId());
					bo.setDeptName(obo.getName());
					if(superBo!=null){
						bo.setOrgName(superBo.getName());
					}
					if(bo.getTemplateID()!=null&&!bo.getTemplateID().equals("")){
						bo.setTemplateName(itemkeyUCC.findTemplateBO(bo.getTemplateID()).getTemplateName());
					}
					objectList.set(i, bo);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getPageInit() {
		try{
			if(super.getRequestParameter("planID")!=null){
				planId=super.getRequestParameter("planID");
				EvaPlanBO ebo=this.evaplanucc.findPlanById(planId);
				planMode=ebo.getEvaModel();
				isPurview=ebo.getPruview();
			}
			doQuery();
			getTemplates();
		}catch(Exception e){
			e.printStackTrace();
		}
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
	//增加删除部门
	private String deptIds;
	private String orgId;
	private String objectID;
	

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
			String ids[]=deptIds.split(",");
			if(ids!=null&&ids.length>0){
				for(int i=0;i<ids.length;i++){
					if(ids[i]!=null&&!ids[i].equals("")){
						EvaObjectsBO ebo=objectUCC.getEvaObjectsBOByPlanIdAndPersonId(planId, ids[i]);
						EvaObjectsBO bo=null;
						if(ebo==null){
							if(planMode.equals(EvaPlanBO.EVA_MODEL_TABLE)){
								bo=new EvaObjectsBO();
								bo.setPersonID(ids[i]);
								bo.setPlanID(planId);
								bo.setTemplateID(templateId);
								objectUCC.savaEvaObject(bo);
							}else if(planMode.equals(EvaPlanBO.EVA_MODEL_ELECTION)){
								bo=new EvaObjectsBO();
								bo.setPersonID(ids[i]);
								bo.setPlanID(planId);
								objectUCC.savaEvaObject(bo);
							}
							if(bo!=null&&isPurview.equals(EvaPlanBO.EVA_PRUVIEW_GROUP)){
								List defaultLevelList=objectUCC.getDefaultLevelByPlanId(planId);
								if(defaultLevelList!=null&&defaultLevelList.size()>0){
									for(int j=0;j<defaultLevelList.size();j++){
										EvaDefaultLevelBO dlevelbo=(EvaDefaultLevelBO)defaultLevelList.get(j);
										EvaLevelPurview levelbo=new EvaLevelPurview();
										levelbo.setMasterType(dlevelbo.getMasterType());
										levelbo.setPurview(dlevelbo.getPurview());
										levelbo.setObjectId(bo.getObjectID());
										objectUCC.saveEvaLevelPurview(levelbo);
									}
								}
							}
						}
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	public String getDeptIds() {
		return deptIds;
	}

	public void setDeptIds(String deptIds) {
		this.deptIds = deptIds;
	}
	//设置权重
	private String initmaster;
	private List masterPersonList;
	private String deptName;
	private String addmaster;
	private String personIds;
	private String personName;
	private String purview;
	private String masterType;
	
	public String getMasterType() {
		return masterType;
	}

	public void setMasterType(String masterType) {
		this.masterType = masterType;
	}

	public String getPurview() {
		return purview;
	}

	public void setPurview(String purview) {
		this.purview = purview;
	}

	public String getPersonIds() {
		return personIds;
	}

	public void setPersonIds(String personIds) {
		this.personIds = personIds;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}
	public String savemaster(){
		try{
			String pids[]=personIds.split(",");
			for(int m=0;m<pids.length;m++){
				if(pids[m]!=null&&!pids[m].equals("")){
					List mastierlist=objectUCC.getMasterIdByOIdandPid(this.objectID, pids[m]);
					if(mastierlist==null||mastierlist.size()==0){
						EvaMasterBO msbo=new EvaMasterBO();
						msbo.setObjectID(this.objectID);
						msbo.setPersonID(pids[m]);
						msbo.setMasterType(masterType);
						if(isPurview!=null&&isPurview.equals("1")){
							List result=objectUCC.getMastersByMasterType(objectID, masterType);
							String allpur;
							EvaLevelPurview levelbo=objectUCC.getLevelPurviewByObjectIdAndType(objectID, masterType);
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
								NumberFormat   nf   =   NumberFormat.getInstance(); 
								String pers=evaplanucc.findPlanById(objectUCC.findEvaObjectBOById(objectID).getPlanID()).getLevelPers();
								if(pers!=null&&!pers.equals("")){
									nf.setMaximumFractionDigits(Integer.parseInt(pers));
								}else{
									nf.setMaximumFractionDigits(2);
								}
								msbo.setPurview(new Double(nf.format(allcount/(result.size()+1))).toString());
								for(int i=0;i<result.size();i++){
									EvaMasterBO masterbo1=(EvaMasterBO)result.get(i);
									masterbo1.setPurview(new Double(nf.format(allcount/(result.size()+1))).toString());
									objectUCC.updateMasterbo(masterbo1);
								}
							}else{
								msbo.setPurview(allpur);
							}
							objectUCC.saveEvaMasterBO(msbo);
							
							EvaObjectsVO vo = objectUCC.findEvaObject(objectID);
							String mode=this.evaplanucc.findPlanById(vo.getPlanID()).getEvaModel();
							if(mode.equals("0")){
								List list = this.itemkeyUCC.getAllItemByTemplateID(vo
										.getTemplateID());
								for (int i = 0; i < list.size(); i++) {
									TemplateItemBO itembo = (TemplateItemBO) list.get(i);
									EvaKeyItemBO keybo=itemkeyUCC.getEvaKeyItemBO(itembo.getLinkID());
									if(!keybo.getItemType().equals("2")){
										EvaScoreBO score = new EvaScoreBO();
										score.setMasterID(msbo.getMasterID());
										score.setObjectID(this.objectID);
										score.setItemID(itembo.getItemID());
										this.scoreUCC.saveScore(score);
									}
								}
							}else if(mode.equals("3")){
								EvaScoreBO score = new EvaScoreBO();
								score.setMasterID(msbo.getMasterID());
								score.setObjectID(this.objectID);
								this.scoreUCC.saveScore(score);
							}
						}else{
							msbo.setPurview(purview);
							objectUCC.saveEvaMasterBO(msbo);
							EvaObjectsVO vo = objectUCC.findEvaObject(objectID);
							String mode=this.evaplanucc.findPlanById(vo.getPlanID()).getEvaModel();
							if(mode.equals("0")){
								List list = this.itemkeyUCC.getAllItemByTemplateID(vo
										.getTemplateID());
								for (int i = 0; i < list.size(); i++) {
									TemplateItemBO itembo = (TemplateItemBO) list.get(i);
									EvaKeyItemBO keybo=itemkeyUCC.getEvaKeyItemBO(itembo.getLinkID());
									if(!keybo.getItemType().equals("2")){
										EvaScoreBO score = new EvaScoreBO();
										score.setMasterID(msbo.getMasterID());
										score.setObjectID(this.objectID);
										score.setItemID(itembo.getItemID());
										this.scoreUCC.saveScore(score);
									}
								}
							}else if(mode.equals("3")){
								EvaScoreBO score = new EvaScoreBO();
								score.setMasterID(msbo.getMasterID());
								score.setObjectID(this.objectID);
								this.scoreUCC.saveScore(score);
							}
						}
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	public String selPerson(){
		PersonBO[] pbos=(PersonBO[])super.getHttpSession().getAttribute(Constants.SELPERSON_SESSION);
		if(pbos!=null&&pbos.length>0){
			for(int i=0;i<pbos.length;i++){
				if(personIds.equals("")){
					personIds+=pbos[i].getPersonId();
				}else{
					personIds+=","+pbos[i].getPersonId();
				}
				if(personName.equals("")){
					personName+=pbos[i].getName();
				}else{
					personName+=","+pbos[i].getName();
				}
			}
		}else{
			super.showMessageDetail("请选择考核人员！");
		}
		return "";
	}
	public String getAddmaster() {
		try{
			if(super.getRequestParameter("objectID")!=null){
				objectID=super.getRequestParameter("objectID");
				isPurview=evaplanucc.findPlanById(objectUCC.findEvaObjectBOById(objectID).getPlanID()).getPruview();
				personIds="";
				personName="";
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return addmaster;
	}

	public void setAddmaster(String addmaster) {
		this.addmaster = addmaster;
	}

	public String deleteMaster(){
		try{
			objectUCC.deleteEvaMasterBO(masterID);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getInitmaster() {
		try{
			if(super.getRequestParameter("objectID") != null){
				objectID=super.getRequestParameter("objectID");
				EvaObjectsBO bo=objectUCC.findEvaObjectBOById(objectID);
				deptName=SysCacheTool.findOrgById(bo.getPersonID()).getName();
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
	//打分
	private String initDeptmaster;
	private String masterID;
	private EvaObjectsBO objectbo=new EvaObjectsBO();
	private List masterList;
	
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


	public String getInitDeptmaster() {
		try{
            if (super.getRequestParameter("objectID")!=null){
                objectID=super.getRequestParameter("objectID");
                objectbo=objectUCC.findEvaObjectBOById(objectID);
				deptName=SysCacheTool.findOrgById(objectbo.getPersonID()).getName();
            }
            queryMasterList();
        }
        catch(Exception e){
        	e.printStackTrace();
        }
		return initDeptmaster;
	}
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
	public void setInitDeptmaster(String initDeptmaster) {
		this.initDeptmaster = initDeptmaster;
	}

	public String getMasterID() {
		return masterID;
	}

	public void setMasterID(String masterID) {
		this.masterID = masterID;
	}
	
}
