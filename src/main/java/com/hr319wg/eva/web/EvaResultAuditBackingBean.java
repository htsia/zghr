package com.hr319wg.eva.web;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.ucc.teamManagerUcc;
import com.hr319wg.eva.pojo.bo.EvaGradeItemBO;
import com.hr319wg.eva.pojo.bo.EvaJobEstimateBO;
import com.hr319wg.eva.pojo.bo.EvaObjectsBO;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.pojo.bo.EvaPlanMixBO;
import com.hr319wg.eva.pojo.bo.EvaTaskMasterBO;
import com.hr319wg.eva.ucc.IEvaGradeUCC;
import com.hr319wg.eva.ucc.IEvaObjectsUCC;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.eva.ucc.IEvaTaskEstimateUcc;
import com.hr319wg.eva.ucc.IjobEstimateUCC;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.user.pojo.vo.UserRptVO;
import com.hr319wg.user.ucc.IUserReportUCC;
import com.hr319wg.util.CommonFuns;

public class EvaResultAuditBackingBean extends BaseBackingBean {
	private IEvaGradeUCC gradeUCC;
	private IEvaPlanUCC evaplanUCC;
	private IEvaObjectsUCC evaobjectUCC;
	private IjobEstimateUCC jobestimateUCC;
	private PageVO mypage = new PageVO();
	private List planList;
	private String status;
	private String planID;
	private String superId;
	private String initResult;
	private String evaModel;
	private List objectScoreList = new ArrayList();
	private List jobEstimateScoreList = new ArrayList();
	private String initAudit;
	private EvaPlanBO planbo = new EvaPlanBO();
	private List masterList = new ArrayList();
	private IEvaTaskEstimateUcc taskucc;
	private teamManagerUcc teamucc;
	private List regTableList;
	private IUserReportUCC userreportucc;
	private String queryValue;
	private String isVittual;
	

	public String getIsVittual() {
		return isVittual;
	}

	public void setIsVittual(String isVittual) {
		this.isVittual = isVittual;
	}

	public String getQueryValue() {
		return queryValue;
	}

	public void setQueryValue(String queryValue) {
		this.queryValue = queryValue;
	}

	public IEvaGradeUCC getGradeUCC() {
		return gradeUCC;
	}

	public void setGradeUCC(IEvaGradeUCC gradeUCC) {
		this.gradeUCC = gradeUCC;
	}

	public List getRegTableList() {
		try
		{
			regTableList = userreportucc.queryUserRptToWeb(super.getUserInfo().getUserId(), "1533", UserRptVO.TYPE_REG);
			if (regTableList == null)
				regTableList = new ArrayList();
		}
		catch (Exception e)
		{
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

	public teamManagerUcc getTeamucc() {
		return teamucc;
	}

	public void setTeamucc(teamManagerUcc teamucc) {
		this.teamucc = teamucc;
	}

	public IEvaTaskEstimateUcc getTaskucc() {
		return taskucc;
	}

	public void setTaskucc(IEvaTaskEstimateUcc taskucc) {
		this.taskucc = taskucc;
	}

	public List getMasterList() {
		return masterList;
	}

	public void setMasterList(List masterList) {
		this.masterList = masterList;
	}

	public String first() {
		mypage.setCurrentPage(1);
		queryResult();
		return "";
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		queryResult();
		return "";
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		queryResult();
		return "";
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		queryResult();
		return "";
	}

	// 初始化计划
	public String getPageInit() {
		if (super.getRequestParameter("superId") != null) {
			superId = super.getRequestParameter("superId");
		}
		queryPlanList();
		return "";
	}

	public void queryPlanList() {
		try {
			String[] status=new String[]{EvaPlanBO.EVA_PLANSTATUS_EXECUTE,EvaPlanBO.EVA_PLANSTATUS_AppovResult,EvaPlanBO.EVA_PLANSTATUS_AppovResultED,EvaPlanBO.EVA_PLANSTATUS_FINISH};
			planList = evaplanUCC.findByOrgAndStatus(status, superId);
			for (int i = 0; i < planList.size(); i++) {
				EvaPlanBO ebo = (EvaPlanBO) planList.get(i);
				if (ebo.getCreatePersonId() != null
						&& !ebo.getCreatePersonId().equals("")) {
					PersonBO pbo = SysCacheTool.findPersonById(ebo
							.getCreatePersonId());
					ebo.setCreatePersonName(pbo.getName());

				}
				if (ebo.getResultAuditPerson() != null
						&& !ebo.getResultAuditPerson().equals("")) {
					PersonBO pb = SysCacheTool.findPersonById(ebo
							.getResultAuditPerson());
					ebo.setResultAuditPerson(pb.getName());
				}

				planList.set(i, ebo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 初始化结果列表
	public String getInitResult() {
		try{
			if (super.getRequestParameter("evaModle") != null) {
				evaModel = super.getRequestParameter("evaModle");
			}
			if (super.getRequestParameter("planId") != null) {
				planID = super.getRequestParameter("planId");
				EvaPlanBO bo=this.evaplanUCC.findPlanById(planID);
				if(bo.getIsVirtual()!=null&&bo.getIsVirtual().equals("1")){
					isVittual="1";
					EvaPlanMixBO mix=(EvaPlanMixBO)this.evaplanUCC.getAllEvaPlanMixBOByPlanId(planID).get(0);
					EvaPlanBO bo2=this.evaplanUCC.findPlanById(mix.getMixPlan());
					planID=mix.getMixPlan();
					evaModel=bo2.getEvaModel();
				}else{
					isVittual="0";
				}
			}
			queryResult();
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}

	public void setInitResult(String initResult) {
		this.initResult = initResult;
	}

	public void queryResult() {
		try {
			EvaPlanBO planbo=evaplanUCC.findPlanById(planID);
			NumberFormat   nf   =   NumberFormat.getInstance();
			if(planbo.getScorePers()!=null&&!planbo.getScorePers().equals("")){
				int intPers=Integer.parseInt(planbo.getScorePers());
				nf.setMaximumFractionDigits(intPers);
			}else{
				nf.setMaximumFractionDigits(2);
			}
			if (evaModel.equals(EvaPlanBO.EVA_MODEL_TABLE)||evaModel.equals(EvaPlanBO.EVA_MODEL_ELECTION)) {
				if (mypage.getCurrentPage() == 0) {
					mypage.setCurrentPage(1);
				}
				objectScoreList = evaobjectUCC.getResultScore(mypage, planID,queryValue,planbo.getPlanObjectType());
				if (objectScoreList != null && objectScoreList.size() > 0) {
					for (int i = 0; i < objectScoreList.size(); i++) {
						EvaObjectsBO bo = (EvaObjectsBO) objectScoreList.get(i);
						if(planbo.getPlanObjectType().equals(EvaPlanBO.OBJCT_TYPE_PERSON)){//个人
							if (bo.getPersonID() != null
									&& !bo.getPersonID().equals("")) {
								PersonBO pb = SysCacheTool.findPersonById(bo
										.getPersonID());
								bo.setPersonName(pb.getName());
								bo.setDeptName(SysCacheTool.findOrgById(pb.getDeptId()).getName());
								bo.setPersonNum(pb.getPersonCode());
							}
						}else if(planbo.getPlanObjectType().equals(EvaPlanBO.OBJCT_TYPE_DEPT)){//部门
							bo.setPersonName(SysCacheTool.findOrgById(bo.getPersonID()).getName());
						}else if(planbo.getPlanObjectType().equals(EvaPlanBO.OBJCT_TYPE_TEAM)){//团队
							bo.setPersonName(teamucc.findEmpTeamInfoBoById(bo.getPersonID()).getTeamName());
						}
						if(bo.getScore()!=null&&!bo.getScore().equals("")){
							double score=Double.parseDouble(bo.getScore());
							bo.setScore(nf.format(score));
						}
						if(bo.getGradeItem()!=null&&!bo.getGradeItem().equals("")){
							EvaGradeItemBO itembo=gradeUCC.getGradeItem(bo.getGradeItem());
							bo.setGradeName(itembo.getItemName());
						}
						if(bo.getSumGrade()!=null&&!bo.getSumGrade().equals("")){
							EvaGradeItemBO itembo=gradeUCC.getGradeItem(bo.getSumGrade());
							bo.setSumGrade(itembo.getItemName());
						}
						objectScoreList.set(i, bo);
					}
				}
			} else if (evaModel.equals(EvaPlanBO.EVA_MODEL_POST)) {
				if (mypage.getCurrentPage() == 0) {
					mypage.setCurrentPage(1);
				}
				jobEstimateScoreList = jobestimateUCC.findJobEstimateScore(
						mypage, planID);
				if (jobEstimateScoreList != null
						&& jobEstimateScoreList.size() > 0) {
					for (int i = 0; i < jobEstimateScoreList.size(); i++) {
						EvaJobEstimateBO bo = (EvaJobEstimateBO) jobEstimateScoreList
								.get(i);
						PersonBO pb = SysCacheTool.findPersonById(bo
								.getPersonID());
						bo.setPersonName(pb.getName());
						bo.setDeptName(SysCacheTool.findOrgById(pb.getDeptId()).getName());
						bo.setPersonNum(pb.getPersonCode());
						if(bo.getScore()!=null&&!bo.getScore().equals("")){
							double score=Double.parseDouble(bo.getScore());
							bo.setScore(nf.format(score));
						}
						if(bo.getGradeItem()!=null&&!bo.getGradeItem().equals("")){
							EvaGradeItemBO itembo=gradeUCC.getGradeItem(bo.getGradeItem());
							bo.setGradeName(itembo.getItemName());
						}
						if(bo.getSumGrade()!=null&&!bo.getSumGrade().equals("")){
							EvaGradeItemBO itembo=gradeUCC.getGradeItem(bo.getSumGrade());
							bo.setSumGrade(itembo.getItemName());
						}
						bo.setSortId(String.valueOf(mypage.getPageSize()*(mypage.getCurrentPage()-1)+(i+1)));
						jobEstimateScoreList.set(i, bo);
					}
				}
			} else if (evaModel.equals(EvaPlanBO.EVA_MODEL_TASK)) {
				if (mypage.getCurrentPage() == 0) {
					mypage.setCurrentPage(1);
				}
				masterList = taskucc.getAllEvaTaskMasterBOforPage(mypage,
						planID);
				if (masterList != null && masterList.size() > 0) {
					for (int i = 0; i < masterList.size(); i++) {
						EvaTaskMasterBO mbo = (EvaTaskMasterBO) masterList
								.get(i);
						PersonBO pb = SysCacheTool.findPersonById(mbo
								.getPersonId());
						mbo.setDeptName(SysCacheTool.findOrgById(pb.getDeptId()).getName());
						mbo.setPersonNum(pb.getPersonCode());
						mbo.setPersonName(SysCacheTool.findPersonById(
								mbo.getPersonId()).getName());
						mbo.setDeptName(SysCacheTool
								.findOrgById(pb.getDeptId()).getName());
						if(mbo.getScore()!=null&&!mbo.getScore().equals("")){
							double score=Double.parseDouble(mbo.getScore());
							mbo.setScore(nf.format(score));
						}
						if(mbo.getGradeItem()!=null&&!mbo.getGradeItem().equals("")){
							EvaGradeItemBO itembo=gradeUCC.getGradeItem(mbo.getGradeItem());
							mbo.setGradeName(itembo.getItemName());
						}
						if(mbo.getSumGrade()!=null&&!mbo.getSumGrade().equals("")){
							EvaGradeItemBO itembo=gradeUCC.getGradeItem(mbo.getSumGrade());
							mbo.setSumGrade(itembo.getItemName());
						}
						mbo.setSortId(String.valueOf(mypage.getPageSize()*(mypage.getCurrentPage()-1)+(i+1)));
						masterList.set(i, mbo);
					}
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}

	}

	// 结果审批
	public String getInitAudit() {
		try {
			if (super.getRequestParameter("evaModle") != null) {
				this.evaModel = super.getRequestParameter("evaModle");
			}
			if (super.getRequestParameter("planId") != null) {
				this.planID = super.getRequestParameter("planId");
				planbo = evaplanUCC.findPlanById(planID);
				EvaPlanBO bo=this.evaplanUCC.findPlanById(planID);
				if(bo.getIsVirtual()!=null&&bo.getIsVirtual().equals("1")){
					isVittual="1";
					EvaPlanMixBO mix=(EvaPlanMixBO)this.evaplanUCC.getAllEvaPlanMixBOByPlanId(planID).get(0);
					EvaPlanBO bo2=this.evaplanUCC.findPlanById(mix.getMixPlan());
					planID=mix.getMixPlan();
					evaModel=bo2.getEvaModel();
				}else{
					isVittual="0";
				}
			}
			queryResult();
		} catch (SysException e) {
			e.printStackTrace();
		}
		return initAudit;
	}

	public void setInitAudit(String initAudit) {
		this.initAudit = initAudit;
	}

	public String audit() {
		try {
			User user = super.getUserInfo();
			if (planbo.getResultAuditResult().equals("1")) {
				planbo.setStatus(EvaPlanBO.EVA_PLANSTATUS_AppovResultED);
				 List mixlist=evaplanUCC.getAllEvaPlanMixBOByPlanId(planbo.getPlanId());
		            if(mixlist!=null&&mixlist.size()>0){
		            	for(int i=0;i<mixlist.size();i++){
		            		EvaPlanMixBO mix=(EvaPlanMixBO)mixlist.get(i);
		            		EvaPlanBO po=evaplanUCC.findPlanById(mix.getMixPlan());
		            		po.setStatus(EvaPlanBO.EVA_PLANSTATUS_AppovResultED);
		            		po.setAduitPersonId(user.getUserId());
		            		po.setAduitDate(CommonFuns.getSysDate("yyyy-MM-dd"));
		            		po.setAduitContent(planbo.getAduitContent());
		            		po.setAduitResult(planbo.getAduitResult());
		            		evaplanUCC.updatePlan(po);
		            	}
		            }
			}
			if (planbo.getResultAuditResult().equals("0")) {
				planbo.setStatus(EvaPlanBO.EVA_PLANSTATUS_EXECUTE);
				List mixlist=evaplanUCC.getAllEvaPlanMixBOByPlanId(planbo.getPlanId());
	            if(mixlist!=null&&mixlist.size()>0){
	            	for(int i=0;i<mixlist.size();i++){
	            		EvaPlanMixBO mix=(EvaPlanMixBO)mixlist.get(i);
	            		EvaPlanBO po=evaplanUCC.findPlanById(mix.getMixPlan());
	            		po.setStatus(EvaPlanBO.EVA_PLANSTATUS_EXECUTE);
	            		po.setAduitPersonId(user.getUserId());
	            		po.setAduitDate(CommonFuns.getSysDate("yyyy-MM-dd"));
	            		po.setAduitContent(planbo.getAduitContent());
	            		po.setAduitResult(planbo.getAduitResult());
	            		evaplanUCC.updatePlan(po);
	            	}
	            }
			}
			planbo.setResultAuditPerson(user.getUserId());
			planbo.setResultAuditDate(CommonFuns.getSysDate("yyyy-MM-dd"));
			evaplanUCC.updatePlan(planbo);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}

	public List getPlanList() {
		return planList;
	}

	public void setPlanList(List list) {
		planList = list;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String s) {
		status = s;
	}

	public IEvaPlanUCC getEvaplanUCC() {
		return evaplanUCC;
	}

	public void setEvaplanUCC(IEvaPlanUCC evaplanUCC) {
		this.evaplanUCC = evaplanUCC;
	}

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public IEvaObjectsUCC getEvaobjectUCC() {
		return evaobjectUCC;
	}

	public void setEvaobjectUCC(IEvaObjectsUCC evaobjectUCC) {
		this.evaobjectUCC = evaobjectUCC;
	}

	public String getEvaModel() {
		return evaModel;
	}

	public void setEvaModel(String evaModel) {
		this.evaModel = evaModel;
	}

	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public String getPlanID() {
		return planID;
	}

	public void setPlanID(String planID) {
		this.planID = planID;
	}

	public List getObjectScoreList() {
		return objectScoreList;
	}

	public void setObjectScoreList(List objectScoreList) {
		this.objectScoreList = objectScoreList;
	}

	public List getJobEstimateScoreList() {
		return jobEstimateScoreList;
	}

	public void setJobEstimateScoreList(List jobEstimateScoreList) {
		this.jobEstimateScoreList = jobEstimateScoreList;
	}

	public EvaPlanBO getPlanbo() {
		return planbo;
	}

	public void setPlanbo(EvaPlanBO planbo) {
		this.planbo = planbo;
	}

	public IjobEstimateUCC getJobestimateUCC() {
		return jobestimateUCC;
	}

	public void setJobestimateUCC(IjobEstimateUCC jobestimateUCC) {
		this.jobestimateUCC = jobestimateUCC;
	}
	//调整等级
	private String initObject;
	private EvaObjectsBO objectbo=new EvaObjectsBO();
	private List gardeList;
	private String objectId;

	public String getObjectId() {
		return objectId;
	}

	public void setObjectId(String objectId) {
		this.objectId = objectId;
	}

	public String changeGrade(){
		try{
			evaobjectUCC.savaEvaObject(objectbo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	public String getInitObject() {
		try{
			if(super.getRequestParameter("objectId")!=null){
				objectId=super.getRequestParameter("objectId");
			}
			if(super.getRequestParameter("isVittual")!=null){
				isVittual=super.getRequestParameter("isVittual");
			}
			objectbo=evaobjectUCC.findEvaObjectBOById(objectId);
			if(isVittual!=null&&isVittual.equals("0")){
				if(objectbo.getGradeItem()!=null&&!objectbo.getGradeItem().equals("")){
					objectbo.setGradeName(gradeUCC.getGradeItem(objectbo.getGradeItem()).getItemName());
				}
			}else if(isVittual!=null&&isVittual.equals("1")){
				if(objectbo.getSumGrade()!=null&&!objectbo.getSumGrade().equals("")){
					objectbo.setGradeName(gradeUCC.getGradeItem(objectbo.getSumGrade()).getItemName());
				}
			}
			gardeList=new ArrayList();
			String gradeId=evaplanUCC.findPlanById(objectbo.getPlanID()).getPlanGrade();
			if(gradeId!=null&&!gradeId.equals("")){
				List gradeItemList=gradeUCC.getAllGradeItem(gradeId);
				if(gradeItemList!=null&&gradeItemList.size()>0){
					for(int i=0;i<gradeItemList.size();i++){
						EvaGradeItemBO bo=(EvaGradeItemBO)gradeItemList.get(i);
						SelectItem si=new SelectItem();
						si.setLabel(bo.getItemName());
						si.setValue(bo.getItemID());
						gardeList.add(si);
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initObject;
	}

	public void setInitObject(String initObject) {
		this.initObject = initObject;
	}

	public EvaObjectsBO getObjectbo() {
		return objectbo;
	}

	public void setObjectbo(EvaObjectsBO objectbo) {
		this.objectbo = objectbo;
	}

	public List getGardeList() {
		return gardeList;
	}

	public void setGardeList(List gardeList) {
		this.gardeList = gardeList;
	}
	

}
