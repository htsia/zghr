package com.hr319wg.eva.web;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.pojo.bo.EvaTaskEstimateLogBO;
import com.hr319wg.eva.pojo.bo.EvaTaskMasterBO;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.eva.ucc.IEvaTaskEstimateUcc;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;

public class EvaTaskEstimateListBackBean extends BaseBackingBean {
	private IEvaTaskEstimateUcc taskucc;
	private PageVO pagevo = new PageVO();
	private String planID;
	private String orgId;
	private String orgName;
	private String personType;
	private String personTypeDes;
	private List personList;
	private String condiValue;
	private IEvaPlanUCC evaplanucc;
	private String planModelDes;
	private String planName;
	private String initAdd;
	private List addPersonList;
	
	public String addPerson(){
        try{
            String id=super.getRequestParameter("form1:personStr");
            if (id!=null){
                String []ids=id.split(",");
                for(int i=0;i<ids.length;i++){
                	if(ids[i]!=null&&!ids[i].equals("")){
                		EvaTaskMasterBO bo=new EvaTaskMasterBO();
	                    bo.setPlanId(this.planID);
	                    bo.setPersonId(ids[i]);
	                    bo.setStatus(EvaTaskMasterBO.EVA_TaskMaster_SCRIPT);
	                    taskucc.saveEvaTaskMasterBO(bo);
	                    EvaTaskEstimateLogBO logbo=new EvaTaskEstimateLogBO();
	                    logbo.setMasterId(bo.getMasterId());
	                    logbo.setOperId(super.getUserInfo().getUserId());
	                    logbo.setAction(EvaTaskMasterBO.EVA_TaskMaster_SCRIPT);
	                    logbo.setActionDate(CommonFuns.getSysDate("yyyy-MM-dd"));
	                    logbo.setContent("增加考核客体");
	                    taskucc.saveEvaTaskEstimateLogBO(logbo);
                	}
                }
            }
        }
        catch(Exception e){
        	e.printStackTrace();
        }
        return "success";
   }
	public String deletePersons(){
		 try{
	            String id=super.getRequestParameter("form1:personStr");
	            if (id!=null){
	                String []ids=id.split(",");
	                for(int i=0;i<ids.length;i++){
	                	if(ids[i]!=null&&!ids[i].equals("")){
	                		taskucc.deleteEvaTaskMasterBO(ids[i]);
	                	}
	                }
	            }
	        }
	        catch(Exception e){
	        	e.printStackTrace();
	        }
	        return "";
	}
	public String addfirst() {
		pagevo.setCurrentPage(1);
		QueryAddPerson();
		return "";
	}

	public String addlast() {
		pagevo.setCurrentPage(pagevo.getTotalPage());
		QueryAddPerson();
		return "";
	}

	public String addpre() {
		if (pagevo.getCurrentPage() >= 2) {
			pagevo.setCurrentPage(pagevo.getCurrentPage() - 1);
			QueryAddPerson();
		}
		return "";
	}

	public String addnext() {
		if (pagevo.getCurrentPage() < pagevo.getTotalPage()) {
			pagevo.setCurrentPage(pagevo.getCurrentPage() + 1);
			QueryAddPerson();
		}
		return "";
	}

	private void QueryAddPerson() {
		try {

			if (pagevo.getCurrentPage() == 0) {
				pagevo.setCurrentPage(1);
			}
			addPersonList=new ArrayList();
			addPersonList = taskucc.getNotEvaTaskMasterBOPeson(pagevo,
					planID,orgId);
			for (int i = 0; i < addPersonList.size(); i++) {
				PersonBO pb = (PersonBO) addPersonList.get(i);
				pb.setOrgId(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, pb
						.getOrgId()));
				pb.setDeptId(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, pb
						.getDeptId()));
				pb.setPostType(CodeUtil.interpertCode(CodeUtil.TYPE_POST, pb.getPostId()));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public String getInitAdd() {
		if (super.getRequestParameter("planID") != null) {
			planID = super.getRequestParameter("planID");
		}
		if (super.getRequestParameter("orgId") != null) {
			orgId = super.getRequestParameter("orgId");
			super.getHttpSession().setAttribute("orgId", orgId);
		}else{
			orgId=(String)super.getHttpSession().getAttribute("orgId");
		}
		QueryAddPerson();
		return initAdd;
	}
	public void setInitAdd(String initAdd) {
		this.initAdd = initAdd;
	}
	public List getAddPersonList() {
		return addPersonList;
	}
	public void setAddPersonList(List addPersonList) {
		this.addPersonList = addPersonList;
	}
	public String getPlanModelDes() {
		return planModelDes;
	}
	public void setPlanModelDes(String planModelDes) {
		this.planModelDes = planModelDes;
	}
	public String getPlanName() {
		return planName;
	}
	public void setPlanName(String planName) {
		this.planName = planName;
	}
	public String getPageInit() {
		if (super.getRequestParameter("orgId") != null) {
			orgId = super.getRequestParameter("orgId");
		}
		if (super.getRequestParameter("personType") != null) {
			personType = super.getRequestParameter("personType");
		}
		if (super.getRequestParameter("planID") != null) {
			planID = super.getRequestParameter("planID");
		}
		if(super.getRequestParameter("condiValue1")!=null){
        	condiValue=super.getRequestParameter("condiValue1");
        	super.getHttpSession().setAttribute("condiValued", condiValue);
        }else{
        	if(super.getHttpSession().getAttribute("condiValued")!=null){
        		condiValue=(String)super.getHttpSession().getAttribute("condiValued");
        	}else{
        		condiValue=null;
        	}
        }
		this.doQuery();
		return pageInit;
	}
	public String doQuery() {
		try {
			if(condiValue!=null&&!condiValue.equals("")){
				personList = new ArrayList();
				if (pagevo.getCurrentPage() == 0)
					pagevo.setCurrentPage(1);
				planID=(String)super.getHttpSession().getAttribute("planId");
				orgId=super.getUserInfo().getOrgId();
				EvaPlanBO planbo=evaplanucc.findPlanById(planID);
				planName=planbo.getPlanName();
				planModelDes=planbo.getEvaModelDes();
				List personList1 = this.taskucc.getEvaTaskMasterBOByOrgId(
						pagevo, planID,orgId);
				if (personList1 != null && personList1.size() > 0) {
					for (int i = 0; i < personList1.size(); i++) {
						PersonBO bo = (PersonBO) personList1
								.get(i);
						EvaTaskMasterBO mastorbo=taskucc.findEvaTaskMasterBOByPid(planID, bo.getPersonId());
						
						mastorbo.setPersonName(CodeUtil.interpertCode(CodeUtil.TYPE_PERSON,
								bo.getPersonId()));
						mastorbo.setPersonId(bo.getPersonId());
						mastorbo.setOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG,
								bo.getOrgId()));
						mastorbo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG,
								bo.getDeptId()));
						mastorbo.setPostName(CodeUtil.interpertCode(CodeUtil.TYPE_POST, bo.getPostId()));
						mastorbo.setPostId(bo.getPostId());
						if(condiValue.equals(bo.getShortName())||condiValue.equals(bo.getPersonCode())){
		                	personList.add(mastorbo);
		                }
					}
				}
				super.getHttpSession().removeAttribute("condiValued");
			}else{
				personList = new ArrayList();
				if (pagevo.getCurrentPage() == 0)
					pagevo.setCurrentPage(1);
				if(planID!=null && !planID.equals("")){
					EvaPlanBO planbo=evaplanucc.findPlanById(planID);
					planName=planbo.getPlanName();
					planModelDes=planbo.getEvaModelDes();
				}
				if(orgId==null || orgId.equals("")){
					orgId=super.getUserInfo().getOrgId();
				}
				List personList1 = this.taskucc.getEvaTaskMasterBOByOrgId(
						pagevo, planID,orgId);
				if (personList1 != null && personList1.size() > 0) {
					for (int i = 0; i < personList1.size(); i++) {
						PersonBO bo = (PersonBO) personList1.get(i);
						EvaTaskMasterBO masterbo=taskucc.findEvaTaskMasterBOByPid(planID, bo.getPersonId());
						masterbo.setPersonName(CodeUtil.interpertCode(CodeUtil.TYPE_PERSON,
								bo.getPersonId()));
						masterbo.setPersonId(bo.getPersonId());
						masterbo.setOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG,
								bo.getOrgId()));
						masterbo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG,
								bo.getDeptId()));
						masterbo.setPostName(CodeUtil.interpertCode(CodeUtil.TYPE_POST, bo.getPostId()));
						masterbo.setPostId(bo.getPostId());
						personList.add(masterbo);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
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
	public IEvaPlanUCC getEvaplanucc() {
		return evaplanucc;
	}
	public void setEvaplanucc(IEvaPlanUCC evaplanucc) {
		this.evaplanucc = evaplanucc;
	}
	public IEvaTaskEstimateUcc getTaskucc() {
		return taskucc;
	}
	public void setTaskucc(IEvaTaskEstimateUcc taskucc) {
		this.taskucc = taskucc;
	}
	public PageVO getPagevo() {
		return pagevo;
	}
	public void setPagevo(PageVO pagevo) {
		this.pagevo = pagevo;
	}
	public String getPlanID() {
		return planID;
	}
	public void setPlanID(String planID) {
		this.planID = planID;
	}
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	public String getOrgName() {
		orgName = CodeUtil.interpertCode(CodeUtil.TYPE_ORG, this.orgId);
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getPersonType() {
		return personType;
	}
	public void setPersonType(String personType) {
		this.personType = personType;
	}
	public String getPersonTypeDes() {
		return personTypeDes;
	}
	public void setPersonTypeDes(String personTypeDes) {
		this.personTypeDes = personTypeDes;
	}
	public List getPersonList() {
		return personList;
	}
	public void setPersonList(List personList) {
		this.personList = personList;
	}
	public String getCondiValue() {
		return condiValue;
	}
	public void setCondiValue(String condiValue) {
		this.condiValue = condiValue;
	}
}
