package com.hr319wg.eva.web;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.pojo.bo.EvaTaskEstimateBO;
import com.hr319wg.eva.pojo.bo.EvaTaskEstimateLogBO;
import com.hr319wg.eva.pojo.bo.EvaTaskMasterBO;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.eva.ucc.IEvaTaskEstimateUcc;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.ShortMessageBO;
import com.hr319wg.sys.service.WorkFlowService;
import com.hr319wg.sys.ucc.IShortMessageUCC;
import com.hr319wg.util.CommonFuns;

public class EvaSelfTaskEstimateBankBean extends BaseBackingBean {
	private IEvaPlanUCC evaplanucc;
	private IEvaTaskEstimateUcc taskucc;
	private IShortMessageUCC shortmessageucc;
	private List planList;
	private String personId;
	private String initEdit;
	private String planID;
	private List estimateList;
	private String personID;
	private EvaTaskMasterBO master=new EvaTaskMasterBO();
	private String masterId;
	private String initTaskEdit;
	private String itemId;
	private EvaTaskEstimateBO estimatebo=new EvaTaskEstimateBO();
	private boolean canEdit=true;
	private String initApprove;
	private String content;
	private WorkFlowService wfservice;
	
	public boolean getCanEdit() {
		return canEdit;
	}
	public void setCanEdit(boolean canEdit) {
		this.canEdit = canEdit;
	}
	public WorkFlowService getWfservice() {
		return wfservice;
	}
	public void setWfservice(WorkFlowService wfservice) {
		this.wfservice = wfservice;
	}
	public IShortMessageUCC getShortmessageucc() {
		return shortmessageucc;
	}
	public void setShortmessageucc(IShortMessageUCC shortmessageucc) {
		this.shortmessageucc = shortmessageucc;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getInitApprove() {
		try{
			if(super.getRequestParameter("masterId")!=null){
				masterId=super.getRequestParameter("masterId");
				master=taskucc.findEvaTaskMasterBO(masterId);
				content="请您审批我的任务";
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initApprove;
	}
	public void setInitApprove(String initApprove) {
		this.initApprove = initApprove;
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
	public String doApproval(){
		try{
			master.setStatus(EvaTaskMasterBO.EVA_TaskMaster_APPROVING);
			taskucc.saveEvaTaskMasterBO(master);
			EvaTaskEstimateLogBO logbo=new EvaTaskEstimateLogBO();
            logbo.setMasterId(master.getMasterId());
            logbo.setOperId(super.getUserInfo().getUserId());
            logbo.setAction(EvaTaskMasterBO.EVA_TaskMaster_APPROVING);
            logbo.setActionDate(CommonFuns.getSysDate("yyyy-MM-dd"));
            logbo.setContent(content);
            taskucc.saveEvaTaskEstimateLogBO(logbo);
            String id=wfservice.getLeaderID(master.getPersonId());
            if(id!=null&&!id.equals("")){
	            ShortMessageBO sbo=new ShortMessageBO();
	            sbo.setSendID(super.getUserInfo().getUserId());
	            sbo.setSendTime(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
	            sbo.setReceiveID(id);
	            sbo.setContent(content);
	            sbo.setIsPopup("0");
	            shortmessageucc.SaveMessage(sbo);
            }
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	public String doModify(){
		try{
			master.setStatus(EvaTaskMasterBO.EVA_TaskMaster_APPLAYMOD);
			taskucc.saveEvaTaskMasterBO(master);
			EvaTaskEstimateLogBO logbo=new EvaTaskEstimateLogBO();
            logbo.setMasterId(master.getMasterId());
            logbo.setOperId(super.getUserInfo().getUserId());
            logbo.setAction(EvaTaskMasterBO.EVA_TaskMaster_APPLAYMOD);
            logbo.setActionDate(CommonFuns.getSysDate("yyyy-MM-dd"));
            logbo.setContent(content);
            taskucc.saveEvaTaskEstimateLogBO(logbo);
            String id=wfservice.getLeaderID(master.getPersonId());
            if(id!=null&&!id.equals("")){
	            ShortMessageBO sbo=new ShortMessageBO();
	            sbo.setSendID(super.getUserInfo().getUserId());
	            sbo.setSendTime(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
	            sbo.setReceiveID(id);
	            sbo.setContent("申请修改我的任务");
	            sbo.setIsPopup("0");
	            shortmessageucc.SaveMessage(sbo);
            }
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	public String saveContent(){
		try{
			if(estimatebo.getMasterId()==null || estimatebo.getMasterId().equals("")){
				estimatebo.setMasterId(masterId);
			}
			taskucc.saveEvaTaskEstimateBO(estimatebo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	
	public EvaTaskEstimateBO getEstimatebo() {
		return estimatebo;
	}
	public void setEstimatebo(EvaTaskEstimateBO estimatebo) {
		this.estimatebo = estimatebo;
	}
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public String getInitTaskEdit() {
		try{
			if(super.getRequestParameter("masterId")!=null){
				masterId=super.getRequestParameter("masterId");
				estimatebo.initrow();
				canEdit=true;
			}else if(super.getRequestParameter("itemId")!=null){
				itemId=super.getRequestParameter("itemId");
				estimatebo=taskucc.findEvaTaskEstimateBO(itemId);
				master=taskucc.findEvaTaskMasterBO(estimatebo.getMasterId());
				String id=super.getUserInfo().getUserId();
				String id2=wfservice.getLeaderID(master.getPersonId());
				if(id2!=null&&!"".equals(id2)&&id.equals(id2)){
					canEdit=false;
				}else{
					canEdit=true;
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initTaskEdit;
	}
	public void setInitTaskEdit(String initTaskEdit) {
		this.initTaskEdit = initTaskEdit;
	}
	public String getMasterId() {
		return masterId;
	}
	public void setMasterId(String masterId) {
		this.masterId = masterId;
	}
	public EvaTaskMasterBO getMaster() {
		return master;
	}
	public void setMaster(EvaTaskMasterBO master) {
		this.master = master;
	}
	public String getPersonID() {
		return personID;
	}
	public void setPersonID(String personID) {
		this.personID = personID;
	}
	public List getEstimateList() {
		return estimateList;
	}
	public void setEstimateList(List estimateList) {
		this.estimateList = estimateList;
	}
	public String getPlanID() {
		return planID;
	}
	public void setPlanID(String planID) {
		this.planID = planID;
	}
	public void queryEstimateList(){
		try{
			estimateList=new ArrayList();
			master=taskucc.findEvaTaskMasterBOByPid(planID, personID);
			masterId=master.getMasterId();
			estimateList=taskucc.findEvaTaskEstimateBOByMasterId(master.getMasterId());
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
		if (super.getRequestParameter("planID") != null) {
			planID = super.getRequestParameter("planID");
			super.getHttpSession().setAttribute("planID", planID);
		} else if (super.getHttpSession().getAttribute("planID") != null) {
			planID = (String) super.getHttpSession().getAttribute("planID");
		}
		if (super.getRequestParameter("PersonID") != null) {
			personID = super.getRequestParameter("PersonID");
			super.getHttpSession().setAttribute("personID", personID);
		} else {
			personID = (String) super.getHttpSession().getAttribute("personID");
		}
		queryEstimateList();
		return initEdit;
	}
	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}
	public IEvaTaskEstimateUcc getTaskucc() {
		return taskucc;
	}
	public void setTaskucc(IEvaTaskEstimateUcc taskucc) {
		this.taskucc = taskucc;
	}
	public String getPageInit(){
	   queryPlanList();
	   return this.pageInit;
	}
	 public void queryPlanList(){
	        try{
	        	planList=new ArrayList();
	        	personId=super.getUserInfo().getUserId();
	            List planList1=evaplanucc.findByOrgId(super.getUserInfo().getOrgId(),EvaPlanBO.EVA_PLANSTATUS_EXECUTE,EvaPlanBO.EVA_MODEL_TASK);
	            for(int i=0;i<planList1.size();i++){
	                EvaPlanBO ebo=(EvaPlanBO)planList1.get(i);
	                PersonBO pbo= SysCacheTool.findPersonById(ebo.getCreatePersonId());
	                ebo.setCreatePersonName(pbo.getName());
	                EvaTaskMasterBO bo1=taskucc.findEvaTaskMasterBOByPid(ebo.getPlanId(), personId);
	                if(bo1!=null){
	                	planList.add(ebo);
	                }
	            }
	        }
	        catch(Exception e){
	        	e.printStackTrace();
	        }
	    }
	public IEvaPlanUCC getEvaplanucc() {
		return evaplanucc;
	}
	public void setEvaplanucc(IEvaPlanUCC evaplanucc) {
		this.evaplanucc = evaplanucc;
	}
	public List getPlanList() {
		return planList;
	}
	public void setPlanList(List planList) {
		this.planList = planList;
	}
	public String getPersonId() {
		return personId;
	}
	public void setPersonId(String personId) {
		this.personId = personId;
	}
}
