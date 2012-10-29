package com.hr319wg.eva.web;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.eva.pojo.bo.EvaJobEstimateBO;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.pojo.bo.JobEstimateLogBO;
import com.hr319wg.eva.pojo.vo.EvaPersoneEstimateVO;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.eva.ucc.IjobEstimateUCC;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;

public class EvaAimChickBackingBean extends BaseBackingBean {
	private String planID;
	private String orgId;
	private String orgName;
	private String personType;
	private String personTypeDes;
	private PageVO pagevo = new PageVO();
	private List jobEstimatList;
	private List personList;
	private IjobEstimateUCC jobestimateucc;
	private String initAdd;
	private List addPersonList;
	private String condiValue;
	private String planModelDes;
	private String planName;
	private IEvaPlanUCC evaplanucc;
	
	public IEvaPlanUCC getEvaplanucc() {
		return evaplanucc;
	}

	public void setEvaplanucc(IEvaPlanUCC evaplanucc) {
		this.evaplanucc = evaplanucc;
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

	public String getCondiValue() {
		return condiValue;
	}

	public void setCondiValue(String condiValue) {
		this.condiValue = condiValue;
	}

	public String deletePersons(){
		 try{
	            String id=super.getRequestParameter("form1:personStr");
	            if (id!=null){
	                String []ids=id.split(",");
	                for(int i=0;i<ids.length;i++){
	                	if(ids[i]!=null&&!ids[i].equals("")){
	                		EvaJobEstimateBO bo=jobestimateucc.findSelfJobEstimateBO(planID, ids[i]);
	                		if(bo!=null){
	                			jobestimateucc.deleteJobEstimatByID(bo.getItemID());
	                		}
	                	}
	                }
	            }
	        }
	        catch(Exception e){

	        }
	        return "";
	}
	
	public String addPerson(){
	        try{
	            String id=super.getRequestParameter("form1:personStr");
	            if (id!=null){
	                String []ids=id.split(",");
	                for(int i=0;i<ids.length;i++){
	                	if(ids[i]!=null&&!ids[i].equals("")){
	                		EvaJobEstimateBO bo=new EvaJobEstimateBO();
		                    bo.setPersonID(ids[i]);
		                    bo.setPlanID(this.planID);
		                    PersonBO pbo=SysCacheTool.findPersonById(ids[i]);
		                    String postID =pbo.getPostId();
		                    bo.setStatus("0");
		                    jobestimateucc.saveDuty(bo);
		                    jobestimateucc.insertDuty(postID, ids[i], planID);
		                    JobEstimateLogBO bo1=new JobEstimateLogBO();
		                    bo1.setAction("0");
		                    bo1.setItemID(bo.getItemID());
		                    bo1.setOperateID(ids[i]);
		                    bo1.setActionDate(CommonFuns.getSysDate("yyyy-MM-dd"));
		                    jobestimateucc.saveJobEstimateLogBO(bo1);
	                	}
	                }
	            }
	        }
	        catch(Exception e){

	        }
	        return "success";
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
			addPersonList = jobestimateucc.findHaveNotCheckPerson(pagevo,
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

		}
	}

	public String getInitAdd() {
		try {
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
		} catch (Exception e) {

		}
		return initAdd;
	}

	public void setInitAdd(String initAdd) {
		this.initAdd = initAdd;
	}

	public List getAddPersonList() {
		if (addPersonList == null) {
			addPersonList = new ArrayList();
		}
		return addPersonList;
	}

	public void setAddPersonList(List addPersonList) {
		this.addPersonList = addPersonList;
	}

	public IjobEstimateUCC getJobestimateucc() {
		return jobestimateucc;
	}

	public void setJobestimateucc(IjobEstimateUCC jobestimateucc) {
		this.jobestimateucc = jobestimateucc;
	}

	public List getPersonList() {
		return personList;
	}

	public void setPersonList(List personList) {
		this.personList = personList;
	}

	public List getJobEstimatList() {
		return jobEstimatList;
	}

	public void setJobEstimatList(List jobEstimatList) {
		this.jobEstimatList = jobEstimatList;
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
				List personList1 = this.jobestimateucc.findHaveCheckInPerson(
						pagevo, planID,orgId);
				if (personList1 != null && personList1.size() > 0) {
					for (int i = 0; i < personList1.size(); i++) {
						PersonBO bo = (PersonBO) personList1
								.get(i);
						EvaJobEstimateBO estimatebo=jobestimateucc.findSelfJobEstimateBO(planID, bo.getPersonId());
						EvaPersoneEstimateVO vo=new EvaPersoneEstimateVO();
						vo.setPersonName(CodeUtil.interpertCode(CodeUtil.TYPE_PERSON,
								bo.getPersonId()));
						vo.setPersonId(bo.getPersonId());
						vo.setOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG,
								bo.getOrgId()));
						vo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG,
								bo.getDeptId()));
						vo.setPostType(CodeUtil.interpertCode(CodeUtil.TYPE_POST, bo.getPostId()));
						vo.setPostId(bo.getPostId());
						vo.setStatus(estimatebo.getStatus());
						if(condiValue.equals(bo.getShortName())||condiValue.equals(bo.getPersonCode())){
		                	personList.add(vo);
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
				personList = this.jobestimateucc.findHaveCheckInPerson(
						pagevo, planID,orgId);
				if (personList != null && personList.size() > 0) {
					for (int i = 0; i < personList.size(); i++) {
						PersonBO bo = (PersonBO) personList.get(i);
						EvaJobEstimateBO estimatebo=jobestimateucc.findSelfJobEstimateBO(planID, bo.getPersonId());
						EvaPersoneEstimateVO vo=new EvaPersoneEstimateVO();
						vo.setPersonId(bo.getPersonId());
						vo.setPersonName(CodeUtil.interpertCode(CodeUtil.TYPE_PERSON,
								bo.getPersonId()));
						vo.setOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG,
								bo.getOrgId()));
						vo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG,
								bo.getDeptId()));
						vo.setPostType(CodeUtil.interpertCode(CodeUtil.TYPE_POST, bo.getPostId()));
						vo.setPostId(bo.getPostId());
						vo.setStatus(estimatebo.getStatus());
						personList.set(i, vo);
					}
				}
			}
		} catch (Exception e) {

		}
		return "";
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
		if (personType == null || "".equals(personType)) {
			personTypeDes = "全部人员";
		} else {
			personTypeDes = "";
			String[] str = personType.split(",");
			for (int i = 0; i < str.length; i++) {
				personTypeDes += " " + CodeUtil.interpertCode("0135", str[i]);
			}
		}
		return personTypeDes;
	}

	public void setPersonTypeDes(String personTypeDes) {
		this.personTypeDes = personTypeDes;
	}

	public PageVO getPagevo() {
		return pagevo;
	}

	public void setPagevo(PageVO pagevo) {
		this.pagevo = pagevo;
	}

}
