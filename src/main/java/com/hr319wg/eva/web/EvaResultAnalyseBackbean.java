package com.hr319wg.eva.web;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.eva.ucc.IEvaKeyItemUCC;
import com.hr319wg.eva.ucc.IEvaObjectsUCC;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.eva.ucc.IEvaScoreUCC;
import com.hr319wg.eva.pojo.vo.EvaObjectsVO;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.pojo.bo.EvaTemplateBO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import javax.faces.model.SelectItem;

import java.util.List;
import java.util.ArrayList;


public class EvaResultAnalyseBackbean extends BaseBackingBean {
	private IEvaKeyItemUCC itemkeyUCC;
	private IEvaObjectsUCC objectUCC;
	private IEvaScoreUCC scoreucc;
	private IEvaPlanUCC evaplanucc;
	private String planID;
	private String planOrgId;
	private String templateID;
	private String objectID;
	private EvaObjectsVO objectvo = new EvaObjectsVO();
	private List templateList=new ArrayList();
	private List templates;
	private List scoreList = new ArrayList();
	private String initTemplate;
	private String superId;
	private String superName;
	private PageVO mypage=new PageVO();
    private String showMode="0";

    public String getShowMode() {
        return showMode;
    }

    public void setShowMode(String showMode) {
        this.showMode = showMode;
    }

    public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public IEvaPlanUCC getEvaplanucc() {
		return evaplanucc;
	}

	public void setEvaplanucc(IEvaPlanUCC evaplanucc) {
		this.evaplanucc = evaplanucc;
	}

	public List getTemplates() {
		return templates;
	}

	public void setTemplates(List templates) {
		this.templates = templates;
	}

	public List getScoreList() {
		return scoreList;
	}

	public void setScoreList(List scoreList) {
		this.scoreList = scoreList;
	}

	public String first() {
		mypage.setCurrentPage(1);
		doParameter();
		return "";
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		doParameter();
		return "";
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		doParameter();
		return "";
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		doParameter();
		return "";
	}
	public String getInitTemplate() {
		try {
			if(super.getRequestParameter("planID")!=null){
				planID=super.getRequestParameter("planID");
				super.getHttpSession().setAttribute("planID", planID);
			}
			if(super.getRequestParameter("superId")!=null)
			{
				superId=super.getRequestParameter("superId");
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
		return initTemplate;
	}
	public void setInitTemplate(String initTemplate) {
		this.initTemplate = initTemplate;
	}
	public List getTemplateList() {	
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
	public String doParameter() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			mypage.setPageSize(20);
			String planId=(String)super.getHttpSession().getAttribute("planID");
			super.getHttpSession().setAttribute("templateID", templateID);
			List objectList=objectUCC.getEvaObjectsBOForResutlShow(mypage, planId, templateID, superId);
			super.getHttpSession().setAttribute("superId", superId);
			super.getHttpSession().setAttribute("objectList", objectList);
            super.getHttpSession().setAttribute("showMode",showMode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
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
		if(super.getRequestParameter("planID")!=null)
		{
			planID=super.getRequestParameter("planID");
			super.getHttpSession().setAttribute("planID", planID);
		}	
		
		return planID;
	}
	public void setPlanID(String planID) {
		this.planID = planID;
	}
	
	

	public IEvaObjectsUCC getObjectUCC() {
		return objectUCC;
	}

	public void setObjectUCC(IEvaObjectsUCC objectUCC) {
		this.objectUCC = objectUCC;
	}
	public IEvaKeyItemUCC getItemkeyUCC() {
		return itemkeyUCC;
	}
	public void setItemkeyUCC(IEvaKeyItemUCC ucc) {
		itemkeyUCC = ucc;
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
		OrgBO b= SysCacheTool.findOrgById(this.superId);
        if (b!=null){
            superName=b.getName();
        }
		return superName;
	}
	public void setSuperName(String superName) {
		this.superName = superName;
	}
	
	public String getPlanOrgId() {
		if(super.getRequestParameter("planOrg")!=null)
		{
			planOrgId=super.getRequestParameter("planOrg");
		}	
		
		return planOrgId;
	}

	public void setPlanOrgId(String planOrgId) {
		this.planOrgId = planOrgId;
	}

	public String getClear()
	{
		super.getHttpSession().setAttribute("objectList",null);
		return "";
	}
	//自助部门查看
	private UserAPI userApi;
	private String initTemplateSelf;
	
	public String first1() {
		mypage.setCurrentPage(1);
		doParameterSelf();
		return "";
	}

	public String pre1() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		doParameterSelf();
		return "";
	}

	public String next1() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		doParameterSelf();
		return "";
	}

	public String last1() {
		mypage.setCurrentPage(mypage.getTotalPage());
		doParameterSelf();
		return "";
	}
	public String doParameterSelf() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			String planId=(String)super.getHttpSession().getAttribute("planID");
			super.getHttpSession().setAttribute("templateID", templateID);
			List objectList=objectUCC.getEvaObjectsBOForResutlShow(mypage, planId, templateID, superId);
			super.getHttpSession().setAttribute("objectList", objectList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}		
	public String getInitTemplateSelf() {
		try {
			if(super.getRequestParameter("planID")!=null){
				planID=super.getRequestParameter("planID");
				super.getHttpSession().setAttribute("planID", planID);
			}
			superId=userApi.getScaleConditionByType(super.getUserInfo(), "A001738", "", "", "A", false, false);
			System.out.println("superId="+superId);
			templateList = new ArrayList();
			SelectItem si0 = new SelectItem();
			si0.setLabel("请选择");
			si0.setValue("");
			templateList.add(si0);
			if(planID!=null&&!planID.equals("")&&superId!=null&&!superId.equals("")){
				String ids[]=objectUCC.getTemplateByPlanIdAndOrgId(planID,superId);
					String temIds="";
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
		return initTemplateSelf;
	}

	public void setInitTemplateSelf(String initTemplateSelf) {
		this.initTemplateSelf = initTemplateSelf;
	}

	public UserAPI getUserApi() {
		return userApi;
	}

	public void setUserApi(UserAPI userApi) {
		this.userApi = userApi;
	}
}
