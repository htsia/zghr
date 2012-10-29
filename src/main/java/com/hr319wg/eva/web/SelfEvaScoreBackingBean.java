package com.hr319wg.eva.web;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.EmpTeamInfoBo;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.ucc.teamManagerUcc;
import com.hr319wg.eva.pojo.bo.EvaGradeItemBO;
import com.hr319wg.eva.pojo.bo.EvaKeyItemBO;
import com.hr319wg.eva.pojo.bo.EvaMasterBO;
import com.hr319wg.eva.pojo.bo.EvaObjectsBO;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.pojo.bo.EvaPlanElectionControlBO;
import com.hr319wg.eva.pojo.bo.EvaScoreBO;
import com.hr319wg.eva.pojo.bo.EvaTemplateBO;
import com.hr319wg.eva.pojo.bo.TemplateItemBO;
import com.hr319wg.eva.pojo.bo.TemplateItemSetBO;
import com.hr319wg.eva.pojo.vo.EvaObjectsVO;
import com.hr319wg.eva.ucc.IEvaGradeUCC;
import com.hr319wg.eva.ucc.IEvaKeyItemUCC;
import com.hr319wg.eva.ucc.IEvaObjectsUCC;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.eva.ucc.IEvaScoreUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.user.pojo.vo.UserRptVO;
import com.hr319wg.user.ucc.IUserReportUCC;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;

public class SelfEvaScoreBackingBean extends BaseBackingBean {
	private IEvaPlanUCC evaplanucc;// 获取计划的接口
	private IEvaObjectsUCC objectUCC;// 获取需要打分的客体
	private IEvaKeyItemUCC itemkeyUCC;
	private IEvaScoreUCC scoreucc;
	private EvaPlanBO planbo;// 计划对象
	private List planList = new ArrayList();// 装在计划集合
	private List objectList = new ArrayList();
	private EvaObjectsBO objectbo;// 客体对象
	private String init;
	private String objectID;
	private String planID;
	private EvaMasterBO masterbo = new EvaMasterBO();
	private String templateId;
	private List templateList;
	private List regTableList;
	private IUserReportUCC userreportucc;
	private String personId;
	private String objectType;
	private teamManagerUcc teamucc;
	private IEvaGradeUCC gradeUCC;
	private String allowMark;
	private String gradeDes;
	private String showMode=Constants.MARK_MODE;// 0普通视图1指标视图
	private String pageInit;
	private String queryValue;
	private List gradeList;
	private PageVO pagevo=new PageVO();
    private String ifSeeReport="1"; //是否显示报表按钮接口

    public String getIfSeeReport() {
        return ifSeeReport;
    }

    public void setIfSeeReport(String ifSeeReport) {
        this.ifSeeReport = ifSeeReport;
    }

    public String first() {
		pagevo.setCurrentPage(1);
		refreshObject();
		return "";
	}

	public String pre() {
		if (pagevo.getCurrentPage() > 1) {
			pagevo.setCurrentPage(pagevo.getCurrentPage() - 1);
		}
		refreshObject();
		return "";
	}

	public String next() {
		if (pagevo.getCurrentPage() < pagevo.getTotalPage()) {
			pagevo.setCurrentPage(pagevo.getCurrentPage() + 1);
		}
		refreshObject();
		return "";
	}

	public String last() {
		pagevo.setCurrentPage(pagevo.getTotalPage());
		refreshObject();
		return "";
	}

	public PageVO getPagevo() {
		return pagevo;
	}

	public void setPagevo(PageVO pagevo) {
		this.pagevo = pagevo;
	}

	public List getGradeList() {
		return gradeList;
	}

	public void setGradeList(List gradeList) {
		this.gradeList = gradeList;
	}

	public String getQueryValue() {
		return queryValue;
	}

	public void setQueryValue(String queryValue) {
		this.queryValue = queryValue;
	}

	public IEvaScoreUCC getScoreucc() {
		return scoreucc;
	}

	public void setScoreucc(IEvaScoreUCC scoreucc) {
		this.scoreucc = scoreucc;
	}

	public String getPageInit() {
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public void changeMode(ValueChangeEvent event) {
		this.showMode = event.getNewValue().toString();
	}

	public String getShowMode() {
		return showMode;
	}

	public void setShowMode(String showMode) {
		this.showMode = showMode;
	}

	public String getGradeDes() {
		return gradeDes;
	}

	public void setGradeDes(String gradeDes) {
		this.gradeDes = gradeDes;
	}

	public String getAllowMark() {
		return allowMark;
	}

	public void setAllowMark(String allowMark) {
		this.allowMark = allowMark;
	}

	public IEvaGradeUCC getGradeUCC() {
		return gradeUCC;
	}

	public void setGradeUCC(IEvaGradeUCC gradeUCC) {
		this.gradeUCC = gradeUCC;
	}

	public teamManagerUcc getTeamucc() {
		return teamucc;
	}

	public void setTeamucc(teamManagerUcc teamucc) {
		this.teamucc = teamucc;
	}

	public String getObjectType() {
		return objectType;
	}

	public void setObjectType(String objectType) {
		this.objectType = objectType;
	}

	public String getPersonId() {
		return super.getUserInfo().getUserId();
	}

	public void setPersonId(String personId) {
		this.personId = personId;
	}

	public List getRegTableList() {
		try {
			regTableList = userreportucc.queryUserRptToWeb(super.getUserInfo()
					.getUserId(), "1524", UserRptVO.TYPE_REG);
			if (regTableList == null)
				regTableList = new ArrayList();
		} catch (Exception e) {
			regTableList = new ArrayList();
		}
		return regTableList;
	}

	public void setRegTableList(List regTableList) {
		this.regTableList = regTableList;
	}

	public IUserReportUCC getUserreportucc() {
		return userreportucc;
	}

	public void setUserreportucc(IUserReportUCC userreportucc) {
		this.userreportucc = userreportucc;
	}

	public IEvaKeyItemUCC getItemkeyUCC() {
		return itemkeyUCC;
	}

	public void setItemkeyUCC(IEvaKeyItemUCC itemkeyUCC) {
		this.itemkeyUCC = itemkeyUCC;
	}

	public List getTemplateList() {
		return templateList;
	}

	public void setTemplateList(List templateList) {
		this.templateList = templateList;
	}

	public String getTemplateId() {
		return templateId;
	}

	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}
	
	private void queryTemplateList(){
		try {
			templateList = new ArrayList();
			SelectItem si0 = new SelectItem();
			si0.setLabel("请选择");
			si0.setValue("-1");
			templateList.add(si0);
			String temIds="";
			List objlist = objectUCC.getEvaObjectsBOByPlanIdAndMasterPid(planID,super.getUserInfo().getUserId());
			if (objlist != null && objlist.size() > 0) {
				for (int i = 0; i < objlist.size(); i++) {
					EvaObjectsBO bo = (EvaObjectsBO) objlist.get(i);
					if(temIds.indexOf(bo.getTemplateID())==-1){
						if(temIds.equals("")){
							temIds+="'"+bo.getTemplateID()+"'";
						}else{
							temIds+=",'"+bo.getTemplateID()+"'";
						}
					}
				}
			}
			if(temIds!=null&&!temIds.equals("")){
				List list=itemkeyUCC.getAllTemplateByTemplateIds(temIds);
				if(list!=null&&list.size()>0){
					for(int i=0;i<list.size();i++){
						EvaTemplateBO bo=(EvaTemplateBO)list.get(i);
						SelectItem si=new SelectItem();
						si.setLabel(bo.getTemplateName());
						si.setValue(bo.getTemplateID());
						templateList.add(si);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public String getInit() {
		try{
			if(super.getRequestParameter("planID")!=null){
				planID=super.getRequestParameter("planID");
				super.getHttpSession().setAttribute("planID", planID);
				super.getHttpSession().setAttribute("masterPid", super.getUserInfo().getUserId());
				EvaPlanBO bo = evaplanucc.findPlanById(planID);
				if (bo.getPlanGrade() != null && !bo.getPlanGrade().equals("")){
					gradeList=gradeUCC.getAllGradeItem(bo.getPlanGrade());
				}
				if (bo.getAllowMark() != null && !bo.getAllowMark().equals("")) {
					allowMark = bo.getAllowMark();
				} else {
					allowMark = "0";
				}
				objectType=bo.getPlanObjectType();
				super.getHttpSession().setAttribute("objectType", objectType);
				queryTemplateList();
			}
			refreshObject();
			super.getHttpSession().setAttribute("showMode",  showMode);
		}catch(Exception e){
			e.printStackTrace();
		}
		return init;
	}

	public void setInit(String init) {
		this.init = init;
	}

	public List getPlanList() {
		try {
			planList = new ArrayList();
			List list = evaplanucc.getAllEvaPlanBObyMaster(super.getUserInfo().getUserId());
			if (list != null && list.size() > 0) {
				for (int i = 0; i < list.size(); i++) {
					EvaPlanBO evaplanbo = (EvaPlanBO) list.get(i);
					if (evaplanbo.getEvaModel().equals(
							EvaPlanBO.EVA_MODEL_TABLE)||evaplanbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_ELECTION)) {
						planList.add(evaplanbo);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return planList;
	}

	public String refreshObject() {
		try {
			super.getHttpSession().removeAttribute("objList");
			if (planID != null && !planID.equals("")&&templateId!=null&&!templateId.equals("")) {
				EvaPlanBO bo = evaplanucc.findPlanById(planID);
				gradeDes = "";
				if (gradeList != null && gradeList.size() > 0) {
					for (int i = 0; i < gradeList.size(); i++) {
						EvaGradeItemBO ibo = (EvaGradeItemBO) gradeList.get(i);
						List list = objectUCC.getEvaObjectsBOByMasterAndGardeItem(planID, super.getUserInfo().getUserId(), templateId,ibo.getItemID(),queryValue);
						if (gradeDes.equals("")) {
							gradeDes += ibo.getItemName() + ":"
										+ CommonFuns.filterNull(ibo.getFlagChar()) + "(" + list.size()
										+ ")";
						} else {
							gradeDes += "  " + ibo.getItemName() + ":"
										+ CommonFuns.filterNull(ibo.getFlagChar()) + "(" + list.size()
										+ ")";
						}
					}
						
				}
				if (pagevo.getCurrentPage() == 0)
					pagevo.setCurrentPage(1);
				objectList = objectUCC.getEvaObjectsVOByPlanIdPersonIdAndTemId(pagevo,
						planID, super.getUserInfo().getUserId(), templateId,queryValue);
				String[] objIds=new String[objectList.size()]; 
				if(objectList!=null&&objectList.size()>0){
					for(int i=0;i<objectList.size();i++){
						EvaObjectsVO obo = (EvaObjectsVO) objectList.get(i);
						objIds[i]=obo.getObjectID();
					}
					super.getHttpSession().setAttribute("objIds", objIds);
				}
				Hashtable ht=objectUCC.getMasterByPersonIdAndObjIds( super.getUserInfo().getUserId(), objIds);
				Hashtable ht2=gradeUCC.getAllGradeItemForHash(bo.getPlanGrade());
				super.getHttpSession().setAttribute("ht", ht);
				super.getHttpSession().setAttribute("ht2", ht2);
				gradeDes="共"+pagevo.getTotalRecord()+"人    "+gradeDes;
				if(showMode.equals("0")){
					if (objectList != null && objectList.size() > 0) {
						for (int j = 0; j < objectList.size(); j++) {
							EvaObjectsVO obo = (EvaObjectsVO) objectList.get(j);
							if (objectType.equals(EvaPlanBO.OBJCT_TYPE_PERSON)) {
								PersonBO pbo = SysCacheTool.findPersonById(obo
										.getPersonID());
								obo.setOrgName(SysCacheTool.findOrgById(
										pbo.getOrgId()).getName());
								obo.setDeptName(SysCacheTool.findOrgById(
										pbo.getDeptId()).getName());
								obo.setPersonName(pbo.getName());
							} else if (objectType.equals(EvaPlanBO.OBJCT_TYPE_DEPT)) {
								OrgBO orgbo = SysCacheTool.findOrgById(obo
										.getPersonID());
								OrgBO superBo = SysCacheTool.findOrgById(orgbo
										.getSuperId());
								obo.setDeptName(orgbo.getName());
								if (superBo != null) {
									obo.setOrgName(superBo.getName());
								}
							} else if (objectType.equals(EvaPlanBO.OBJCT_TYPE_TEAM)) {
								EmpTeamInfoBo tbo = teamucc
										.findEmpTeamInfoBoById(obo.getPersonID());
								obo.setOrgName(SysCacheTool.findOrgById(
										tbo.getCreateOrg()).getName());
								obo.setTeamName(tbo.getTeamName());
							}
							EvaMasterBO master =(EvaMasterBO)ht.get(obo.getObjectID());
							obo.setScore(master.getScore());
							if (master != null) {
								obo.setMasterId(master.getMasterID());
								if (master.getGradeId() != null
										&& !"".equals(master.getGradeId())) {
									obo.setGradeName(((EvaGradeItemBO)ht2.get(master.getGradeId())).getFlagChar());
								}
							}
							objectList.set(j, obo);
						}
					}
				}
				super.getHttpSession().setAttribute("objList", objectList);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public List getObjectList() {
		return objectList;
	}

	public void changeTem(ValueChangeEvent evt) {
		templateId = evt.getNewValue().toString();
		super.getHttpSession().setAttribute("templateId", templateId);
		refreshObject();
	}

	public void setPlanList(List planList) {
		this.planList = planList;
	}

	public IEvaPlanUCC getEvaplanucc() {
		return evaplanucc;
	}

	public void setEvaplanucc(IEvaPlanUCC evaplanucc) {
		this.evaplanucc = evaplanucc;
	}

	public String getPlanID() {
		return planID;
	}

	public void setPlanID(String planID) {
		this.planID = planID;
	}

	public String getObjectID() {
		return objectID;
	}

	public void setObjectID(String objectID) {
		this.objectID = objectID;
	}

	public EvaMasterBO getMasterbo() {
		return masterbo;
	}

	public void setMasterbo(EvaMasterBO masterbo) {
		this.masterbo = masterbo;
	}

	public IEvaObjectsUCC getObjectUCC() {
		return objectUCC;
	}

	public void setObjectUCC(IEvaObjectsUCC objectUCC) {
		this.objectUCC = objectUCC;
	}

	public EvaPlanBO getPlanbo() {
		return planbo;
	}

	public void setPlanbo(EvaPlanBO planbo) {
		this.planbo = planbo;
	}

	public void setObjectList(List objectList) {
		this.objectList = objectList;
	}

	public EvaObjectsBO getObjectbo() {
		return objectbo;
	}

	public void setObjectbo(EvaObjectsBO objectbo) {
		this.objectbo = objectbo;
	}
	//投票模式
	private String initElection;
	
	public String saveElection(){
		try{
			List list=objectUCC.getMasterByMasterPlanId(planID,super.getUserInfo().getUserId());
			if(list!=null&&list.size()>0){
				for(int i=0;i<list.size();i++){
					EvaMasterBO mbo = (EvaMasterBO) list.get(i);
					EvaObjectsBO obo=objectUCC.findEvaObjectBOById(mbo.getObjectID());
					EvaScoreBO scorebo=(EvaScoreBO)scoreucc.getAllEvaScoreBOByObjIdAndMasterId(obo.getObjectID(),mbo.getMasterID()).get(0);
					String value=super.getRequestParameter(scorebo.getScoreID());
					scorebo.setScore(value);
					scoreucc.saveScore(scorebo);
					mbo.setIsMark("1");
					mbo.setGradeId(value);
					objectUCC.saveEvaMasterBO(mbo);
				}
			}
			List contrlList=evaplanucc.getAllEvaPlanElectionControlBOByPlanId(planID);
			if(contrlList!=null&&contrlList.size()>0){
				for(int i=0;i<contrlList.size();i++){
					EvaPlanElectionControlBO bo=(EvaPlanElectionControlBO)contrlList.get(i);
					List mlist=objectUCC.getMasterByMasterPlanIdAndMasterType(planID,super.getUserInfo().getUserId(),bo.getMasterType());
					double count=0;
					if(mlist!=null&&mlist.size()>0){
						for(int m=0;m<mlist.size();m++){
							EvaMasterBO mbo = (EvaMasterBO) list.get(m);
							if(mbo.getGradeId()!=null&&mbo.getGradeId().equals(bo.getGradeItem())){
								count++;
							}
						}
					}
					EvaPlanBO planbo=evaplanucc.findPlanById(planID);
					String objectType=planbo.getPlanObjectType();
					if(bo.getDeptCount()!=null&&!bo.getDeptCount().equals("")&&objectType!=null&&objectType.equals(EvaPlanBO.OBJCT_TYPE_PERSON)){
						double deptCount=Double.parseDouble(bo.getDeptCount());
						List objList=objectUCC.getEvaObjectsBOByPlanIdAndMasterPid(planID, super.getUserInfo().getUserId(),bo.getMasterType(), bo.getGradeItem(), null);
						boolean flag=false;
						if(objList!=null&&objList.size()>0){
							for(int n=0;n<objList.size();n++){
								EvaObjectsBO object=(EvaObjectsBO)objList.get(n);
								PersonBO pbo=SysCacheTool.findPersonById(object.getPersonID());
								List objlist2=objectUCC.getEvaObjectsBOByPlanIdAndMasterPid(planID, super.getUserInfo().getUserId(),bo.getMasterType(), bo.getGradeItem(), pbo.getDeptId());
								if(objlist2!=null&&objlist2.size()>0&&deptCount<objlist2.size()){
									flag=true;
									EvaMasterBO mmbo=objectUCC.getEvaMasterBOBymasterId(object.getObjectID(), super.getUserInfo().getUserId());
									mmbo.setGradeId("");
									objectUCC.saveEvaMasterBO(mmbo);
									EvaScoreBO scorebo=(EvaScoreBO)scoreucc.getAllEvaScoreBOByObjIdAndMasterId(mmbo.getObjectID(),mmbo.getMasterID()).get(0);
									scorebo.setScore("");
									scoreucc.saveScore(scorebo);
								}
							}
						}
						if(flag==true){
							super.showMessageDetail(CodeUtil.interpertCode("超过部门控制人数("+bo.getDeptCount()+")"));
							return "";
						}
					}
					if(bo.getGradeCount()!=null&&!bo.getGradeCount().equals("")){
						double percent=Double.parseDouble(bo.getGradeCount());
						double rper=count/mlist.size();
						if(rper*100>percent){
							for(int m=0;m<mlist.size();m++){
								EvaMasterBO mbo = (EvaMasterBO) list.get(m);
								EvaScoreBO scorebo=(EvaScoreBO)scoreucc.getAllEvaScoreBOByObjIdAndMasterId(mbo.getObjectID(),mbo.getMasterID()).get(0);
								mbo.setGradeId("");
								objectUCC.saveEvaMasterBO(mbo);
								scorebo.setScore("");
								scoreucc.saveScore(scorebo);
							}
							super.showMessageDetail(CodeUtil.interpertCode("超过等级控制比例("+bo.getGradeCount()+"%)"));
							return "";
						}
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	public String getInitElection() {
		try{
			if(super.getRequestParameter("planID")!=null){
				planID=super.getRequestParameter("planID");
				super.getHttpSession().setAttribute("planID", planID);
				super.getHttpSession().setAttribute("personId", super.getUserInfo().getUserId());
			}
			String des="";
			String gradeId=this.evaplanucc.findPlanById(planID).getPlanGrade();
			if(gradeId!=null&&!gradeId.equals("")){
				List gradeList=gradeUCC.getAllGradeItem(gradeId);
				for(int m=0;m<gradeList.size();m++){
					EvaGradeItemBO itembo=(EvaGradeItemBO)gradeList.get(m);
					int count=0;
					List list=objectUCC.getMasterByMasterPlanId(planID,super.getUserInfo().getUserId());
					if(list!=null&&list.size()>0){
						for(int i=0;i<list.size();i++){
							EvaMasterBO mbo = (EvaMasterBO) list.get(i);
							if(mbo.getGradeId()!=null&&mbo.getGradeId().equals(itembo.getItemID())){
								count++;
							}
						}
					}
					des+=itembo.getItemName()+"("+String.valueOf(count)+")"+" ";
				}
			}
			super.getHttpSession().setAttribute("des", des);
		}catch(Exception e){
			e.printStackTrace();
		}
		return initElection;
	}

	public void setInitElection(String initElection) {
		this.initElection = initElection;
	}


}
