package com.hr319wg.eva.web;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.eva.pojo.bo.EvaGradeItemBO;
import com.hr319wg.eva.pojo.bo.EvaInfoBO;
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
import com.hr319wg.util.CommonFuns;

public class EvaResultPublishBackingBean extends BaseBackingBean {
	private IEvaPlanUCC evaplanUCC;
	private IEvaObjectsUCC evaobjectUCC;
	private IjobEstimateUCC jobestimateUCC;
	private IEvaGradeUCC gradeUCC;
	private IEvaTaskEstimateUcc taskucc;
	private PageVO mypage = new PageVO();
	private List planList;
	private String status;
	private String planID;
	private String superId;
	private String evaModel;
	private EvaPlanBO planbo = new EvaPlanBO();

	public IEvaTaskEstimateUcc getTaskucc() {
		return taskucc;
	}

	public void setTaskucc(IEvaTaskEstimateUcc taskucc) {
		this.taskucc = taskucc;
	}


	public String first() {
		mypage.setCurrentPage(1);
		queryPublishPlanList();
		return "";
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		queryPublishPlanList();
		return "";
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		queryPublishPlanList();
		return "";
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		queryPublishPlanList();
		return "";
	}

	// 初始化计划
	public String getPageInit() {
		if (super.getRequestParameter("superId") != null) {
			superId = super.getRequestParameter("superId");
			super.getHttpSession().setAttribute("superid", superId);
		}else{
            super.getHttpSession().setAttribute("superid",super.getUserInfo().getOrgId());
        }
		queryPublishPlanList();
		return "";
	}

	public String queryPublishPlanList() {
		try {
			String[] status={EvaPlanBO.EVA_PLANSTATUS_EXECUTE,EvaPlanBO.EVA_PLANSTATUS_AppovResult,EvaPlanBO.EVA_PLANSTATUS_AppovResultED,EvaPlanBO.EVA_PLANSTATUS_FINISH};
			planList = evaplanUCC.findByOrgAndStatus(status, super.getHttpSession()
							.getAttribute("superid").toString());
			for (int i = 0; i < planList.size(); i++) {
				EvaPlanBO ebo = (EvaPlanBO) planList.get(i);
				PersonBO pbo = SysCacheTool.findPersonById(ebo
						.getCreatePersonId());
				ebo.setCreatePersonName(pbo.getName());
				if(ebo.getResultAuditPerson()!=null&&!ebo.getResultAuditPerson().equals("")){
				PersonBO pb = SysCacheTool.findPersonById(ebo
						.getResultAuditPerson());
					ebo.setResultAuditPerson(pb.getName());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public String publish() {
		try {
			planbo = evaplanUCC.findPlanById(planID);
			planbo.setStatus(EvaPlanBO.EVA_PLANSTATUS_FINISH);
			evaplanUCC.updatePlan(planbo);
			String isVirtual="0";
			String planName=planbo.getPlanName();
			String virtualPlanId=planID;
			if(planbo.getIsVirtual()!=null&&planbo.getIsVirtual().equals("1")){
				List mixlist=evaplanUCC.getAllEvaPlanMixBOByPlanId(planbo.getPlanId());
				EvaPlanMixBO mix1=(EvaPlanMixBO)mixlist.get(0);
				planbo= evaplanUCC.findPlanById(mix1.getMixPlan());
				isVirtual="1";
				planID=planbo.getPlanId();
				if(mixlist!=null&&mixlist.size()>0){
		            for(int i=0;i<mixlist.size();i++){
		            	EvaPlanMixBO mix=(EvaPlanMixBO)mixlist.get(i);
		            	EvaPlanBO po=evaplanUCC.findPlanById(mix.getMixPlan());
		            	po.setStatus(EvaPlanBO.EVA_PLANSTATUS_FINISH);
		            	evaplanUCC.updatePlan(po);
		            }
		        }
			}
			if(planbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_TABLE)||planbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_ELECTION)){//量表
				List list = evaobjectUCC.getResultScore(null, planID,null,planbo.getPlanObjectType());
				if(list!=null&&list.size()>0){
					for(int i=0;i<list.size();i++){
						EvaObjectsBO bo=(EvaObjectsBO)list.get(i);
						EvaInfoBO evainfo = new EvaInfoBO();
						evainfo.setBeginDate(planbo.getBeginDate());
						evainfo.setEndDate(planbo.getEndDate());
						evainfo.setOrgID(SysCacheTool.findOrgById(planbo.getOrgId()).getName());
						evainfo.setId(bo.getPersonID());
						
						evainfo.setPlanId(virtualPlanId);
						evainfo.setPlanName(planName);
						evainfo.setPlanType(planbo.getPlanType());
						String gradeType="";
						if(isVirtual.equals("0")){
							if(bo.getGradeItem()!=null&&!bo.getGradeItem().equals("")){
								gradeType=gradeUCC.getGradeItem(bo.getGradeItem()).getItemName();
							}
							evainfo.setPlanGradeName(gradeType);
							evainfo.setResultAuditExplain(bo.getScore());
							evainfo.setScoreIndex(bo.getSortId());
						}else{
							if(bo.getSumGrade()!=null&&!bo.getSumGrade().equals("")){
								gradeType=gradeUCC.getGradeItem(bo.getSumGrade()).getItemName();
							}
							evainfo.setPlanGradeName(gradeType);
							evainfo.setResultAuditExplain(bo.getSumScore());
							evainfo.setScoreIndex(bo.getSumSort());
						}
						evaplanUCC.saveEvaInfo(evainfo,super.getUserInfo());
					}
				}
			}else if(planbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_POST)){//岗位
				List list = jobestimateUCC.findJobEstimateScore(
						null, planID);
				if(list!=null&&list.size()>0){
					for(int i=0;i<list.size();i++){
						EvaJobEstimateBO bo=(EvaJobEstimateBO)list.get(i);
						EvaInfoBO evainfo = new EvaInfoBO();
						evainfo.setBeginDate(planbo.getBeginDate());
						evainfo.setEndDate(planbo.getEndDate());
						evainfo.setOrgID(SysCacheTool.findOrgById(planbo.getOrgId()).getName());
						evainfo.setId(bo.getPersonID());
						evainfo.setPlanId(virtualPlanId);
						evainfo.setPlanName(planName);
						evainfo.setPlanType(planbo.getPlanType());
						String gradeType="";
						if(isVirtual.equals("0")){
							if(bo.getGradeItem()!=null&&!bo.getGradeItem().equals("")){
								gradeType=gradeUCC.getGradeItem(bo.getGradeItem()).getItemName();
							}
							evainfo.setPlanGradeName(gradeType);
							evainfo.setResultAuditExplain(bo.getScore());
							evainfo.setScoreIndex(bo.getSortId());
						}else{
							if(bo.getSumGrade()!=null&&!bo.getSumGrade().equals("")){
								gradeType=gradeUCC.getGradeItem(bo.getSumGrade()).getItemName();
							}
							evainfo.setPlanGradeName(gradeType);
							evainfo.setResultAuditExplain(bo.getSumScore());
							evainfo.setScoreIndex(bo.getSumSort());
						}
						evaplanUCC.saveEvaInfo(evainfo,super.getUserInfo());
					}
				}
				
			}else if(planbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_TASK)){//任务
				List list=taskucc.getAllEvaTaskMasterBO(planID);
				if(list!=null&&list.size()>0){
					for(int i=0;i<list.size();i++){
						EvaTaskMasterBO bo=(EvaTaskMasterBO)list.get(i);
						EvaInfoBO evainfo = new EvaInfoBO();
						evainfo.setBeginDate(planbo.getBeginDate());
						evainfo.setEndDate(planbo.getEndDate());
						evainfo.setOrgID(SysCacheTool.findOrgById(planbo.getOrgId()).getName());
						evainfo.setId(bo.getPersonId());
						evainfo.setPlanId(virtualPlanId);
						evainfo.setPlanName(planName);
						evainfo.setPlanType(planbo.getPlanType());
						String gradeType="";
						if(isVirtual.equals("0")){
							if(bo.getGradeItem()!=null&&!bo.getGradeItem().equals("")){
								gradeType=gradeUCC.getGradeItem(bo.getGradeItem()).getItemName();
							}
							evainfo.setPlanGradeName(gradeType);
							evainfo.setResultAuditExplain(bo.getScore());
							evainfo.setScoreIndex(bo.getSortId());
						}else{
							if(bo.getSumGrade()!=null&&!bo.getSumGrade().equals("")){
								gradeType=gradeUCC.getGradeItem(bo.getSumGrade()).getItemName();
							}
							evainfo.setPlanGradeName(gradeType);
							evainfo.setResultAuditExplain(bo.getSumScore());
							evainfo.setScoreIndex(bo.getSumSort());
						}
						evaplanUCC.saveEvaInfo(evainfo,super.getUserInfo());
					}
				}
			}
			planbo.setStatus(planbo.EVA_PLANSTATUS_FINISH);
			evaplanUCC.updatePlan(planbo);
			queryPublishPlanList();
		} catch (SysException e) {
			super.showMessageDetail("结果发布失败!");
		}
		return "";
	}

	

	public IEvaPlanUCC getEvaplanUCC() {
		return evaplanUCC;
	}

	public void setEvaplanUCC(IEvaPlanUCC evaplanUCC) {
		this.evaplanUCC = evaplanUCC;
	}

	public IEvaObjectsUCC getEvaobjectUCC() {
		return evaobjectUCC;
	}

	public void setEvaobjectUCC(IEvaObjectsUCC evaobjectUCC) {
		this.evaobjectUCC = evaobjectUCC;
	}

	public IjobEstimateUCC getJobestimateUCC() {
		return jobestimateUCC;
	}

	public void setJobestimateUCC(IjobEstimateUCC jobestimateUCC) {
		this.jobestimateUCC = jobestimateUCC;
	}

	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public List getPlanList() {
		return planList;
	}

	public void setPlanList(List planList) {
		this.planList = planList;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPlanID() {
		return planID;
	}

	public void setPlanID(String planID) {
		this.planID = planID;
	}

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public String getEvaModel() {
		return evaModel;
	}

	public void setEvaModel(String evaModel) {
		this.evaModel = evaModel;
	}

	public IEvaGradeUCC getGradeUCC() {
		return gradeUCC;
	}

	public void setGradeUCC(IEvaGradeUCC gradeUCC) {
		this.gradeUCC = gradeUCC;
	}

	public EvaPlanBO getPlanbo() {
		return planbo;
	}

	public void setPlanbo(EvaPlanBO planbo) {
		this.planbo = planbo;
	}

}
