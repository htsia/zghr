package com.hr319wg.eva.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.pojo.bo.EvaTaskEstimateBO;
import com.hr319wg.eva.pojo.bo.EvaTaskEstimateLogBO;
import com.hr319wg.eva.pojo.bo.EvaTaskMasterBO;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.eva.ucc.IEvaTaskEstimateUcc;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.ShortMessageBO;
import com.hr319wg.sys.ucc.IShortMessageUCC;
import com.hr319wg.util.CommonFuns;

public class EvaLeadTaskEstimateBankBean extends BaseBackingBean {
	private String pageInit;
	private List planList;
	private List queryList;
	private String planID;
	private IEvaPlanUCC evaplanucc;
	private IEvaTaskEstimateUcc taskucc;
	private String masterId;// 考核ID
	private String personName;// 下属人员姓名
	private String postID;// 当前登陆人的岗位ID
	private List resultList;
	private String orgId;
	private String initEdit;
	private List estimateList;
	private EvaTaskMasterBO master=new EvaTaskMasterBO();
	private IShortMessageUCC shortmessageucc;
	private String initApprove;
	private String content;
	private String auditResult;
	
	public String getAuditResult() {
		return auditResult;
	}

	public void setAuditResult(String auditResult) {
		this.auditResult = auditResult;
	}

	public IShortMessageUCC getShortmessageucc() {
		return shortmessageucc;
	}

	public void setShortmessageucc(IShortMessageUCC shortmessageucc) {
		this.shortmessageucc = shortmessageucc;
	}
	public String doApproval(){
		try{
			if("1".equals(auditResult)){
				master.setStatus(EvaTaskMasterBO.EVA_TaskMaster_APPROVED);
				taskucc.saveEvaTaskMasterBO(master);
				EvaTaskEstimateLogBO logbo=new EvaTaskEstimateLogBO();
	            logbo.setMasterId(master.getMasterId());
	            logbo.setOperId(super.getUserInfo().getUserId());
	            logbo.setAction(EvaTaskMasterBO.EVA_TaskMaster_APPROVED);
	            logbo.setActionDate(CommonFuns.getSysDate("yyyy-MM-dd"));
	            logbo.setContent(content);
	            taskucc.saveEvaTaskEstimateLogBO(logbo);
			}else{
				master.setStatus(EvaTaskMasterBO.EVA_TaskMaster_APPROVEDMOD);
				taskucc.saveEvaTaskMasterBO(master);
				EvaTaskEstimateLogBO logbo=new EvaTaskEstimateLogBO();
	            logbo.setMasterId(master.getMasterId());
	            logbo.setOperId(super.getUserInfo().getUserId());
	            logbo.setAction(EvaTaskMasterBO.EVA_TaskMaster_APPROVEDMOD);
	            logbo.setActionDate(CommonFuns.getSysDate("yyyy-MM-dd"));
	            logbo.setContent(content);
	            taskucc.saveEvaTaskEstimateLogBO(logbo);
			}
	        ShortMessageBO sbo=new ShortMessageBO();
	        sbo.setSendID(super.getUserInfo().getUserId());
	        sbo.setSendTime(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
	        sbo.setReceiveID(master.getPersonId());
	        sbo.setContent(content);
	        sbo.setIsPopup("0");
	        shortmessageucc.SaveMessage(sbo);
            
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}

	public String getInitApprove() {
		try{
			if(super.getRequestParameter("masterId")!=null){
				masterId=super.getRequestParameter("masterId");
				master=taskucc.findEvaTaskMasterBO(masterId);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initApprove;
	}

	public void setInitApprove(String initApprove) {
		this.initApprove = initApprove;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String saveScore(){
		try{
			String idScores=super.getRequestParameter("form1:saveStr");
			String idscore[]=idScores.split(",");
			if(idscore!=null&&idscore.length>0){
				for(int i=0;i<idscore.length;i++){
					if(idscore[i]!=null&&!idscore[i].equals("")){
						String ids[]=idscore[i].split(":");
						EvaTaskEstimateBO bo=taskucc.findEvaTaskEstimateBO(ids[0]);
						if(bo!=null){
							bo.setScore(ids[1]);
						}
						taskucc.saveEvaTaskEstimateBO(bo);
					}
				}
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public String modOk(){
		try{
			master.setStatus(EvaTaskMasterBO.EVA_TaskMaster_APPROVEDMOD);
			taskucc.saveEvaTaskMasterBO(master);
			EvaTaskEstimateLogBO logbo=new EvaTaskEstimateLogBO();
            logbo.setMasterId(master.getMasterId());
            logbo.setOperId(super.getUserInfo().getUserId());
            logbo.setAction(EvaTaskMasterBO.EVA_TaskMaster_APPROVEDMOD);
            logbo.setActionDate(CommonFuns.getSysDate("yyyy-MM-dd"));
            logbo.setContent("同意修改任务内容");
            taskucc.saveEvaTaskEstimateLogBO(logbo);
            ShortMessageBO sbo=new ShortMessageBO();
	        sbo.setSendID(super.getUserInfo().getUserId());
	        sbo.setSendTime(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
	        sbo.setReceiveID(master.getPersonId());
	        sbo.setContent("同意修改任务内容");
	        sbo.setIsPopup("0");
	        shortmessageucc.SaveMessage(sbo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	public String modNo(){
		try{
			master.setStatus(EvaTaskMasterBO.EVA_TaskMaster_APPROVED);
			taskucc.saveEvaTaskMasterBO(master);
			EvaTaskEstimateLogBO logbo=new EvaTaskEstimateLogBO();
            logbo.setMasterId(master.getMasterId());
            logbo.setOperId(super.getUserInfo().getUserId());
            logbo.setAction(EvaTaskMasterBO.EVA_TaskMaster_APPROVED);
            logbo.setActionDate(CommonFuns.getSysDate("yyyy-MM-dd"));
            logbo.setContent("不同意修改任务内容");
            taskucc.saveEvaTaskEstimateLogBO(logbo);
            ShortMessageBO sbo=new ShortMessageBO();
	        sbo.setSendID(super.getUserInfo().getUserId());
	        sbo.setSendTime(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
	        sbo.setReceiveID(master.getPersonId());
	        sbo.setContent("不同意修改任务内容");
	        sbo.setIsPopup("0");
	        shortmessageucc.SaveMessage(sbo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	public List getEstimateList() {
		return estimateList;
	}
	public void setEstimateList(List estimateList) {
		this.estimateList = estimateList;
	}
	public EvaTaskMasterBO getMaster() {
		return master;
	}
	public String deleteContent(){
		try{
			String itemId1=super.getRequestParameter("form1:itemId");
			taskucc.deleteEvaTaskEstimateBO(itemId1);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	public void setMaster(EvaTaskMasterBO master) {
		this.master = master;
	}
	public void queryEstimateList(){
		try{
			estimateList=new ArrayList();
			master=taskucc.findEvaTaskMasterBO(masterId);
			estimateList=taskucc.findEvaTaskEstimateBOByMasterId(masterId);
			if(estimateList==null){
				estimateList=new ArrayList();
			}
			super.getHttpSession().setAttribute("resultList", estimateList);
			super.getHttpSession().setAttribute("status", master.getStatus());
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	public String getInitEdit() {
		if (super.getRequestParameter("masterId") != null) {
			masterId = super.getRequestParameter("masterId");
			super.getHttpSession().setAttribute("masterId", masterId);
		} else if (super.getHttpSession().getAttribute("masterId") != null) {
			masterId = (String) super.getHttpSession().getAttribute("masterId");
		}
		queryEstimateList();
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public String getMasterId() {
		return masterId;
	}

	public void setMasterId(String masterId) {
		this.masterId = masterId;
	}

	public IEvaTaskEstimateUcc getTaskucc() {
		return taskucc;
	}

	public void setTaskucc(IEvaTaskEstimateUcc taskucc) {
		this.taskucc = taskucc;
	}

	public String addPerson(){
		try {
			String id = super.getRequestParameter("form1:personStr");
			if (id != null) {
				String[] ids = id.split(",");
				for (int i = 0; i < ids.length; i++) {
					if (ids[i] != null && !ids[i].equals("")) {
						EvaTaskMasterBO bo=new EvaTaskMasterBO();
	                    bo.setPlanId(this.planID);
	                    bo.setPersonId(ids[i]);
	                    bo.setStatus(EvaTaskMasterBO.EVA_TaskMaster_SCRIPT);
	                    taskucc.saveEvaTaskMasterBO(bo);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public List getResultList() {
		return resultList;
	}

	public void setResultList(List resultList) {
		this.resultList = resultList;
	}

	public String getPostID() {
		return postID;
	}

	public void setPostID(String postID) {
		this.postID = postID;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public List getQueryList() {
		return queryList;
	}

	public void setQueryList(List queryList) {
		this.queryList = queryList;
	}

	public String getPlanID() {
		return planID;
	}

	public void setPlanID(String planID) {
		this.planID = planID;
	}

	public IEvaPlanUCC getEvaplanucc() {
		return evaplanucc;
	}

	public void setEvaplanucc(IEvaPlanUCC evaplanucc) {
		this.evaplanucc = evaplanucc;
	}

	public void changeStatus(ValueChangeEvent event) {
		planID = event.getNewValue().toString();
		postID = SysCacheTool.findPersonById(super.getUserInfo().getUserId())
				.getPostId();
		try {
			resultList = taskucc.getManagePersons(planID, postID);
		} catch (SysException e) {
			e.printStackTrace();
		}
	}

	public String getPageInit() {
		try {
			planList = evaplanucc.findByModel(EvaPlanBO.EVA_MODEL_TASK);
			orgId=super.getUserInfo().getDeptId();
			SelectItem si0 = new SelectItem();
			queryList = new ArrayList();
			si0.setLabel("请选择计划名称");
			si0.setValue("-1");
			queryList.add(si0);
			for (int i = 0; i < planList.size(); i++) {
				EvaPlanBO epo = (EvaPlanBO) planList.get(i);
				if(!epo.getStatus().equals(EvaPlanBO.EVA_PLANSTATUS_FINISH)){
					SelectItem si = new SelectItem();
					si.setLabel(epo.getPlanName());
					si.setValue(epo.getPlanId());
					queryList.add(si);
				}
			}
			resultList = taskucc.getManagePersons(planID, postID);
		} catch (Exception e) {

		}
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public void setPlanList(List planList) {
		this.planList = planList;
	}

	public List getPlanList() {

		return planList;
	}
	
}
