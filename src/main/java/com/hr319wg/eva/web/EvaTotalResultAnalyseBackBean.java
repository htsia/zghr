package com.hr319wg.eva.web;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import javax.faces.model.SelectItem;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.pojo.bo.EvaPlanMixBO;
import com.hr319wg.eva.ucc.IEvaKeyItemUCC;
import com.hr319wg.eva.ucc.IEvaObjectsUCC;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.eva.ucc.IEvaScoreUCC;
import com.hr319wg.eva.ucc.IEvaTaskEstimateUcc;
import com.hr319wg.eva.ucc.IjobEstimateUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;

public class EvaTotalResultAnalyseBackBean extends BaseBackingBean {
	private IEvaObjectsUCC objectUCC;
	private IEvaPlanUCC evaplanucc;
	private IEvaKeyItemUCC itemkeyUCC;
	private IEvaTaskEstimateUcc taskucc;
	private IjobEstimateUCC jobestimateucc;
	private IEvaScoreUCC scoreucc;
	private String planID;
	private String planOrgId;
	private String initPlanList;
	private String superId;
	private String superName;
	private PageVO mypage=new PageVO();
	private List childePlanList;
	private String firstMode;
	private String firstPlanId;
    private String objType;

    public String getObjType() {
        return objType;
    }

    public void setObjType(String objType) {
        this.objType = objType;
    }

    public IEvaScoreUCC getScoreucc() {
		return scoreucc;
	}
	public void setScoreucc(IEvaScoreUCC scoreucc) {
		this.scoreucc = scoreucc;
	}
	public IEvaTaskEstimateUcc getTaskucc() {
		return taskucc;
	}
	public void setTaskucc(IEvaTaskEstimateUcc taskucc) {
		this.taskucc = taskucc;
	}
	public IjobEstimateUCC getJobestimateucc() {
		return jobestimateucc;
	}
	public void setJobestimateucc(IjobEstimateUCC jobestimateucc) {
		this.jobestimateucc = jobestimateucc;
	}
	public String getFirstPlanId() {
		return firstPlanId;
	}
	public void setFirstPlanId(String firstPlanId) {
		this.firstPlanId = firstPlanId;
	}
	public String getFirstMode() {
		return firstMode;
	}
	public void setFirstMode(String firstMode) {
		this.firstMode = firstMode;
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
	public String doParameter() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			List objectList=new ArrayList();
			if(firstMode!=null&&!firstMode.equals("")){
				if(firstMode.equals(EvaPlanBO.EVA_MODEL_TABLE)||firstMode.equals(EvaPlanBO.EVA_MODEL_ELECTION)){
                    if(objType.equals(EvaPlanBO.OBJCT_TYPE_PERSON)){
					    objectList=objectUCC.getObjectsByPlanIdAndOrgId(mypage,firstPlanId,superId);
                    }else{
                        objectList=objectUCC.getObjectsByPlanId(null,firstPlanId);
                    }
				}else if(firstMode.equals(EvaPlanBO.EVA_MODEL_POST)){
					objectList=jobestimateucc.findResultScore(mypage,firstPlanId,superId);
				}else if(firstMode.equals(EvaPlanBO.EVA_MODEL_TASK)){
					objectList=taskucc.getTaskResultScore(mypage,firstPlanId,superId);
				}
			}
			super.getHttpSession().setAttribute("firstPlanId", firstPlanId);
			super.getHttpSession().setAttribute("firstMode", firstMode);
			super.getHttpSession().setAttribute("objectList", objectList);
			super.getHttpSession().setAttribute("superId", superId);
            super.getHttpSession().setAttribute("objType", objType);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}		
	public String getInitPlanList() {
		try{
			if(super.getRequestParameter("planID")!=null){
				planID=super.getRequestParameter("planID");
				List planList=new ArrayList();
				List list=evaplanucc.getAllEvaPlanMixBOByPlanId(planID);
				Hashtable ht=new Hashtable();
				Hashtable htType=new Hashtable();
				if(list!=null&&list.size()>0){
					for(int i=0;i<list.size();i++){
						EvaPlanMixBO bo=(EvaPlanMixBO)list.get(i);
						EvaPlanBO pbo=evaplanucc.findPlanById(bo.getMixPlan());
						if(i==0){
							firstMode=pbo.getEvaModel();
							firstPlanId=pbo.getPlanId();
                            objType=pbo.getPlanObjectType();
							super.getHttpSession().setAttribute("firstPlan", pbo);
						}
						if(pbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_ELECTION)||pbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_TABLE)){
							List typelist=scoreucc.getThePersonTypeByPlanId(pbo.getPlanId());
							htType.put(pbo.getPlanId(), typelist);
						}
						ht.put(pbo.getPlanId(), bo);
						planList.add(pbo);
					}
				}
				super.getHttpSession().setAttribute("planList", planList);
				super.getHttpSession().setAttribute("planHash", ht);
				super.getHttpSession().setAttribute("typeHash", htType);
			}
			if(super.getRequestParameter("superId")!=null){
				superId=super.getRequestParameter("superId");
			}
			doParameter();
		}catch(Exception e){
			e.printStackTrace();
		}
		return initPlanList;
	}
	public void setInitPlanList(String initPlanList) {
		this.initPlanList = initPlanList;
	}
	public List getChildePlanList() {
		return childePlanList;
	}
	public void setChildePlanList(List childePlanList) {
		this.childePlanList = childePlanList;
	}
	public IEvaKeyItemUCC getItemkeyUCC() {
		return itemkeyUCC;
	}
	public void setItemkeyUCC(IEvaKeyItemUCC itemkeyUCC) {
		this.itemkeyUCC = itemkeyUCC;
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
	public PageVO getMypage() {
		return mypage;
	}
	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}
	public String getSuperId() {
		return superId;
	}
	public void setSuperId(String superId) {
		this.superId = superId;
	}
	public IEvaObjectsUCC getObjectUCC() {
		return objectUCC;
	}
	public void setObjectUCC(IEvaObjectsUCC objectUCC) {
		this.objectUCC = objectUCC;
	}
	public IEvaPlanUCC getEvaplanucc() {
		return evaplanucc;
	}
	public void setEvaplanucc(IEvaPlanUCC evaplanucc) {
		this.evaplanucc = evaplanucc;
	}
	public String getPlanID() {
		if(super.getRequestParameter("planID")!=null){
			planID=super.getRequestParameter("planID");
			super.getHttpSession().setAttribute("planID", planID);
		}	
		return planID;
	}
	public void setPlanID(String planID) {
		this.planID = planID;
	}
	public String getPlanOrgId() {
		if(super.getRequestParameter("planOrg")!=null){
			planOrgId=super.getRequestParameter("planOrg");
		}	
		return planOrgId;
	}
	public void setPlanOrgId(String planOrgId) {
		this.planOrgId = planOrgId;
	}
	public String getClear(){
		super.getHttpSession().setAttribute("objectList",null);
		return "";
	}
}
