package com.hr319wg.eva.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.eva.pojo.bo.EvaJobContentBO;
import com.hr319wg.eva.pojo.bo.EvaJobEstimateBO;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.pojo.bo.JobEstimateLogBO;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.eva.ucc.IjobEstimateUCC;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;

/**
 * 
 * @author qiaolei
 * 
 */
public class EvaLeadJobEstimateBackingBean extends BaseBackingBean {
	private String pageInit;
	private List planList;
	private List queryList;
	private String planID;
	private IEvaPlanUCC evaplanucc;
	private IjobEstimateUCC jobestimateucc;
	private EvaJobContentBO jobContentBo;
	private String itemID;// 考核ID
	private String personName;// 下属人员姓名
	private String postID;// 当前登陆人的岗位ID
	private List personList;
	private List resultList;
	private String orgId;
	

	public String addPerson(){
		try {
			String id = super.getRequestParameter("form1:personStr");
			if (id != null) {
				String[] ids = id.split(",");
				for (int i = 0; i < ids.length; i++) {
					if (ids[i] != null && !ids[i].equals("")) {
						EvaJobEstimateBO bo = new EvaJobEstimateBO();
						bo.setPersonID(ids[i]);
						bo.setPlanID(this.planID);
						PersonBO pbo = SysCacheTool.findPersonById(ids[i]);
						String postID = pbo.getPostId();
						bo.setStatus("0");
						jobestimateucc.saveDuty(bo);
						jobestimateucc.insertDuty(postID, ids[i], planID);
						JobEstimateLogBO bo1 = new JobEstimateLogBO();
						bo1.setAction("0");
						bo1.setItemID(bo.getItemID());
						bo1.setOperateID(ids[i]);
						bo1.setActionDate(CommonFuns.getSysDate("yyyy-MM-dd"));
						jobestimateucc.saveJobEstimateLogBO(bo1);
					}
				}
			}
		} catch (Exception e) {

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

	public List getPersonList() {
		return personList;
	}

	public void setPersonList(List personList) {
		this.personList = personList;
	}

	public IjobEstimateUCC getJobestimateucc() {
		return jobestimateucc;
	}

	public void setJobestimateucc(IjobEstimateUCC jobestimateucc) {
		this.jobestimateucc = jobestimateucc;
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

	public String getItemID() {
		return itemID;
	}

	public void setItemID(String itemID) {
		this.itemID = itemID;
	}

	public EvaJobContentBO getJobContentBo() {
		return jobContentBo;
	}

	public void setJobContentBo(EvaJobContentBO jobContentBo) {
		this.jobContentBo = jobContentBo;
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
				.getPostId();// 当前登陆人岗位ID
		System.out.println(postID);
		try {
			resultList = jobestimateucc.getManagePersons(planID, postID);
		} catch (SysException e) {
			e.printStackTrace();
		}
	}

	public String getPageInit() {
		try {
			postID = SysCacheTool.findPersonById(super.getUserInfo().getUserId())
			.getPostId();// 当前登陆人岗位ID
			planList = evaplanucc.findByModel(EvaPlanBO.EVA_MODEL_POST);
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
			resultList = jobestimateucc.getManagePersons(planID, postID);
		} catch (Exception e) {
			e.printStackTrace();
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
