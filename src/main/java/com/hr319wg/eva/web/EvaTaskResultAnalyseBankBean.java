package com.hr319wg.eva.web;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.eva.ucc.IEvaGradeUCC;
import com.hr319wg.eva.ucc.IEvaTaskEstimateUcc;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.qry.pojo.vo.StaticResultVO;
import com.hr319wg.sys.cache.SysCacheTool;

public class EvaTaskResultAnalyseBankBean extends BaseBackingBean {
	private String planOrgId;
	private String planID;
	private String gradeID;
	private String superId;
	private String superName;
	private String initPage;
	private IEvaGradeUCC gradeUCC;
	private IEvaTaskEstimateUcc taskucc;
	private String tatalCount;
	private List gradeList = new ArrayList();
	
	public List getGradeList() {
		return gradeList;
	}

	public void setGradeList(List gradeList) {
		this.gradeList = gradeList;
	}

	public String getTatalCount() {
		return tatalCount;
	}

	public void setTatalCount(String tatalCount) {
		this.tatalCount = tatalCount;
	}

	public IEvaGradeUCC getGradeUCC() {
		return gradeUCC;
	}

	public void setGradeUCC(IEvaGradeUCC gradeUCC) {
		this.gradeUCC = gradeUCC;
	}

	public IEvaTaskEstimateUcc getTaskucc() {
		return taskucc;
	}

	public void setTaskucc(IEvaTaskEstimateUcc taskucc) {
		this.taskucc = taskucc;
	}

	public String getSuperId() {
		if (super.getRequestParameter("superId") != null) {
			superId = super.getRequestParameter("superId");
		}
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public String getSuperName() {
		OrgBO b = SysCacheTool.findOrgById(this.superId);
		if (b != null) {
			superName = b.getName();
		}
		return superName;
	}

	public void setSuperName(String superName) {
		this.superName = superName;
	}
	public String doQuery() {
		try {
			
			if (((List) super.getHttpSession().getAttribute("taskEstimateScoreht")) != null) {
				super.getHttpSession().setAttribute("taskEstimateScoreht", null);
			}
			this.tatalCount = "0";
			
			String gradeId = (String) super.getHttpSession().getAttribute(
					"gradeID");
			String planid = (String) super.getHttpSession().getAttribute(
					"planID");
			gradeList = gradeUCC.getAllGradeItem(gradeId);			
			super.getHttpSession().setAttribute("gradeItem", gradeList);
			List taskestimatescore = taskucc.findTaskResultScore(planid, superId);
			super.getHttpSession().setAttribute("taskEstimateScoreht", taskestimatescore);
			this.tatalCount = Integer.toString(taskestimatescore.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	public String getInitPage() {
		if(this.superId!=null && !this.superId.equals("")){
			doQuery();
		}
		return initPage;
	}

	public void setInitPage(String initPage) {
		this.initPage = initPage;
	}

	public String getClear()
	{
		if(((List)super.getHttpSession().getAttribute("jobEstimateScoreht"))!=null)
		 {
			 super.getHttpSession().setAttribute("jobEstimateScoreht",null);
		 }
		if((StaticResultVO[])super.getHttpSession().getAttribute("STATIC_RESULT")!=null)
		{
			super.getHttpSession().setAttribute("STATIC_RESULT",null);
		}
		if(this.superId!=null)
		{
			this.superId=null;
			
		}
		if(this.superName!=null)
		{
			this.superName=null;
		}
		return "";
	}
	
	public String getPlanOrgId() {
		if (super.getRequestParameter("planOrg") != null) {
			planOrgId = super.getRequestParameter("planOrg");
			
		}
		return planOrgId;
	}
	public void setPlanOrgId(String planOrgId) {
		this.planOrgId = planOrgId;
	}
	public String getPlanID() {
		if (super.getRequestParameter("planID") != null) {
			planID = super.getRequestParameter("planID");
			super.getHttpSession().setAttribute("planID", planID);
		}
		return planID;
	}
	public void setPlanID(String planID) {
		this.planID = planID;
	}
	public String getGradeID() {
		if (super.getRequestParameter("gradeID") != null) {
			gradeID = super.getRequestParameter("gradeID");
			super.getHttpSession().setAttribute("gradeID", gradeID);
		}
		return gradeID;
	}
	public void setGradeID(String gradeID) {
		this.gradeID = gradeID;
	}
}
