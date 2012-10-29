package com.hr319wg.eva.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.faces.model.SelectItem;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.eva.pojo.bo.EvaJobEstimateBO;
import com.hr319wg.eva.pojo.bo.EvaMasterBO;
import com.hr319wg.eva.pojo.bo.EvaTemplateBO;
import com.hr319wg.eva.pojo.vo.EvaObjectsVO;
import com.hr319wg.eva.ucc.IEvaGradeUCC;
import com.hr319wg.eva.ucc.IEvaKeyItemUCC;
import com.hr319wg.eva.ucc.IEvaObjectsUCC;
import com.hr319wg.eva.ucc.IEvaScoreUCC;
import com.hr319wg.eva.ucc.IjobEstimateUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.qry.pojo.vo.StaticResultVO;
import com.hr319wg.sys.cache.SysCacheTool;

public class EvaPostResultAnalyseBackingBean extends BaseBackingBean{
	
	private IEvaGradeUCC gradeUCC;
	private IjobEstimateUCC jobestimateUCC;
	private String planID;
	private String planOrgId;
	private PageVO mypage = new PageVO();
	private String objectID;
	private EvaObjectsVO objectvo = new EvaObjectsVO();
	private String initPage;	
	private List scoreList = new ArrayList();
	private String superId;
	private String superName;
	private String gradeID;
	private List gradeList = new ArrayList();
	private String tatalCount;
	

	public String first() {
		mypage.setCurrentPage(1);
		doQuery();
		return "";
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		doQuery();
		return "";
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		doQuery();
		return "";
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		doQuery();
		return "";
	}

	public String doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			if (((List) super.getHttpSession().getAttribute("jobEstimateScoreht")) != null) {
				super.getHttpSession().setAttribute("jobEstimateScoreht", null);
			}
			this.tatalCount = "0";
			
			String gradeId = (String) super.getHttpSession().getAttribute(
					"gradeID");
			String planid = (String) super.getHttpSession().getAttribute(
					"planID");
			gradeList = gradeUCC.getAllGradeItem(gradeId);			
			super.getHttpSession().setAttribute("gradeItem", gradeList);
			List jobestimatescore = jobestimateUCC.findResultScore(mypage, planid, superId);
			
				super.getHttpSession().setAttribute("jobEstimateScoreht", jobestimatescore);
				this.tatalCount = Integer.toString(jobestimatescore.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public String getInitPage() {
		if(this.superId!=null && !this.superId.equals(""))
		{
		this.doQuery();
		}
		return initPage;
	}

	public void setInitPage(String initPage) {
		this.initPage = initPage;
	}

	public EvaObjectsVO getObjectvo() {
		return objectvo;
	}

	public void setObjectvo(EvaObjectsVO objectbo) {
		this.objectvo = objectbo;
	}

	public String getObjectID() {
		return objectID;
	}

	public void setObjectID(String objectID) {
		this.objectID = objectID;
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
    
	public String getPlanOrgId() {
		if (super.getRequestParameter("planOrg") != null) {
			planOrgId = super.getRequestParameter("planOrg");
			
		}
		return planOrgId;
	}

	public void setPlanOrgId(String planOrgId) {
		this.planOrgId = planOrgId;
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

	

	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public IEvaGradeUCC getGradeUCC() {
		return gradeUCC;
	}

	public void setGradeUCC(IEvaGradeUCC gradeUCC) {
		this.gradeUCC = gradeUCC;
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




	public String getTatalCount() {
		return tatalCount;
	}

	public void setTatalCount(String tatalCount) {
		this.tatalCount = tatalCount;
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

	public IjobEstimateUCC getJobestimateUCC() {
		return jobestimateUCC;
	}

	public void setJobestimateUCC(IjobEstimateUCC jobestimateUCC) {
		this.jobestimateUCC = jobestimateUCC;
	}
	
}



