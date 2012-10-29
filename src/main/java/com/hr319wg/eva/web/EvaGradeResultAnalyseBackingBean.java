package com.hr319wg.eva.web;

import java.util.ArrayList;
import java.util.HashMap;

import java.util.List;

import javax.faces.model.SelectItem;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;

import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.pojo.bo.EvaTemplateBO;
import com.hr319wg.eva.pojo.vo.EvaObjectsVO;
import com.hr319wg.eva.ucc.IEvaGradeUCC;
import com.hr319wg.eva.ucc.IEvaKeyItemUCC;
import com.hr319wg.eva.ucc.IEvaObjectsUCC;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.eva.ucc.IEvaScoreUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.cache.SysCacheTool;


public class EvaGradeResultAnalyseBackingBean extends BaseBackingBean {
	private IEvaKeyItemUCC itemkeyUCC;
	private IEvaGradeUCC gradeUCC;
	private IEvaObjectsUCC objectUCC;
	private IEvaScoreUCC scoreucc;
	private IEvaPlanUCC evaplanucc;
	private String planID;
	private String planOrgId;
	private PageVO mypage = new PageVO();
	private String objectID;
	private EvaObjectsVO objectvo = new EvaObjectsVO();
	private String initPage;
	private List masterTypeList = new ArrayList();
	private List scoreList = new ArrayList();
	private String superId;
	private String superName;
	private String gradeID;
	private List gradeList = new ArrayList();
	private List templateList = new ArrayList();
	private List templates;
	private String templateID;
	private String showMode="1";
	private String indexValue="0";
	private String initTemplat;

	public String getInitTemplat() {
		if (super.getRequestParameter("planID") != null) {
			planID = super.getRequestParameter("planID");
			super.getHttpSession().setAttribute("planID", planID);
		}
		if (super.getRequestParameter("gradeID") != null) {
			gradeID = super.getRequestParameter("gradeID");
			super.getHttpSession().setAttribute("gradeID", gradeID);
		}
		if (super.getRequestParameter("superId") != null) {
			superId = super.getRequestParameter("superId");
		}
		return initTemplat;
	}

	public void setInitTemplat(String initTemplat) {
		this.initTemplat = initTemplat;
	}

	public String getIndexValue() {
		return indexValue;
	}

	public void setIndexValue(String indexValue) {
		this.indexValue = indexValue;
	}

	public String getShowMode() {
		return showMode;
	}

	public void setShowMode(String showMode) {
		this.showMode = showMode;
	}

	public IEvaPlanUCC getEvaplanucc() {
		return evaplanucc;
	}

	public void setEvaplanucc(IEvaPlanUCC evaplanucc) {
		this.evaplanucc = evaplanucc;
	}

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
			mypage.setPageSize(100);
			String planid = (String) super.getHttpSession().getAttribute(
			"planID");
			EvaPlanBO planbo=evaplanucc.findPlanById(planid);
			String masterType[]=planbo.getGradeString().split(",");
			if(showMode.equals("1")){
				HashMap ht = new HashMap();
				masterTypeList = scoreucc.getPersonType();
				String gradeId = (String) super.getHttpSession().getAttribute(
						"gradeID");
				gradeList = gradeUCC.getAllGradeItem(gradeId);
				super.getHttpSession().setAttribute("gradeItem", gradeList);
				List objectList=objectUCC.getEvaObjectsBOForResutlShow(mypage, planid, templateID, superId);
				super.getHttpSession().setAttribute("objectList", objectList);
			}else if(showMode.equals("2")){
				List objectList=objectUCC.getAllEvaGradersBOByPlanIdAndOrgId(mypage, templateID, superId, planid,indexValue);
				super.getHttpSession().setAttribute("objectList", objectList);
			}
			super.getHttpSession().setAttribute("masterType", masterType);
			super.getHttpSession().setAttribute("showMode", showMode);
			super.getHttpSession().setAttribute("superId",superId );
			super.getHttpSession().setAttribute("indexValue", indexValue);
			super.getHttpSession().setAttribute("templateID", templateID);
			super.getHttpSession().setAttribute("mypage", mypage);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
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
	

	public String getPlanOrgId() {
		if (super.getRequestParameter("planOrg") != null) {
			planOrgId = super.getRequestParameter("planOrg");
			
		}
		return planOrgId;
	}

	public void setPlanOrgId(String planOrgId) {
		this.planOrgId = planOrgId;
	}

	public IEvaObjectsUCC getObjectUCC() {
		return objectUCC;
	}

	public void setObjectUCC(IEvaObjectsUCC objectUCC) {
		this.objectUCC = objectUCC;
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

	public IEvaScoreUCC getScoreucc() {
		return scoreucc;
	}

	public void setScoreucc(IEvaScoreUCC scoreucc) {
		this.scoreucc = scoreucc;
	}

	public String getSuperId() {
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

	public List getMasterTypeList() {
		return masterTypeList;
	}

	public void setMasterTypeList(List masterTypeList) {
		this.masterTypeList = masterTypeList;
	}

	public IEvaKeyItemUCC getItemkeyUCC() {
		return itemkeyUCC;
	}

	public void setItemkeyUCC(IEvaKeyItemUCC itemkeyUCC) {
		this.itemkeyUCC = itemkeyUCC;
	}

	public List getTemplateList() {
		try {
			if(super.getRequestParameter("planID")!=null){
				planID=super.getRequestParameter("planID");
			}
			templateList = new ArrayList();
			SelectItem si0 = new SelectItem();
			si0.setLabel("请选择");
			si0.setValue("");
			templateList.add(si0);
			if(planID!=null&&!planID.equals("")&&superId!=null&&!superId.equals("")){
				String ids[]=objectUCC.getTemplateByPlanIdAndOrgId(planID,superId);
					String temIds="'1'";
					for (int i = 0; i < ids.length; i++) {
						if(ids[i]!=null&&!ids[i].equals("")){
							if(temIds.equals("")){
								temIds+="'"+ids[i]+"'";
							}else{
								temIds+=",'"+ids[i]+"'";
							}
						}
					}
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
		} catch (SysException e) {
			e.printStackTrace();
		}
		return templateList;
	}

	public void setTemplateList(List templateList) {
		this.templateList = templateList;
	}

	public String getTemplateID() {
		return templateID;
	}

	public void setTemplateID(String templateID) {
		this.templateID = templateID;
	}

	public String getClear()
	{
		super.getHttpSession().setAttribute("objectList",null);
		return "";
	}
	
	//自助部门查看
	private String initTemplatSelf;
	private UserAPI userApi;
	
	public String first1() {
		mypage.setCurrentPage(1);
		doQuerySelf();
		return "";
	}

	public String pre1() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		doQuerySelf();
		return "";
	}

	public String next1() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		doQuerySelf();
		return "";
	}

	public String last1() {
		mypage.setCurrentPage(mypage.getTotalPage());
		doQuerySelf();
		return "";
	}
	public String doQuerySelf() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			String planid = (String) super.getHttpSession().getAttribute(
			"planID");
			EvaPlanBO planbo=evaplanucc.findPlanById(planid);
			String masterType[]=planbo.getGradeString().split(",");
			if(showMode.equals("1")){
				HashMap ht = new HashMap();
				masterTypeList = scoreucc.getPersonType();
				String gradeId = (String) super.getHttpSession().getAttribute(
						"gradeID");
				gradeList = gradeUCC.getAllGradeItem(gradeId);
				super.getHttpSession().setAttribute("gradeItem", gradeList);
				List objectList=objectUCC.getEvaObjectsBOForResutlShow(mypage, planid, templateID, superId);
				super.getHttpSession().setAttribute("objectList", objectList);
			}else if(showMode.equals("2")){
				List objectList=objectUCC.getAllEvaGradersBOByPlanIdAndOrgId(mypage, templateID, superId, planid,indexValue);
				super.getHttpSession().setAttribute("objectList", objectList);
			}
			super.getHttpSession().setAttribute("masterType", masterType);
			super.getHttpSession().setAttribute("showMode", showMode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	public String getInitTemplatSelf() {
		if (super.getRequestParameter("planID") != null) {
			planID = super.getRequestParameter("planID");
			super.getHttpSession().setAttribute("planID", planID);
		}
		if (super.getRequestParameter("gradeID") != null) {
			gradeID = super.getRequestParameter("gradeID");
			super.getHttpSession().setAttribute("gradeID", gradeID);
		}
		superId=userApi.getScaleConditionByType(super.getUserInfo(), "A001738", "", "", "A", false, false);
		System.out.println("superId="+superId);
		return initTemplatSelf;
	}

	public void setInitTemplatSelf(String initTemplatSelf) {
		this.initTemplatSelf = initTemplatSelf;
	}

	public UserAPI getUserApi() {
		return userApi;
	}

	public void setUserApi(UserAPI userApi) {
		this.userApi = userApi;
	}
}
