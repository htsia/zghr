package com.hr319wg.eva.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.eva.pojo.bo.EvaJobEstimateBO;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.eva.ucc.IEvaScoreUCC;
import com.hr319wg.eva.ucc.IjobEstimateUCC;
import com.hr319wg.sys.cache.SysCacheTool;
/**
 * 
 * @author qiaolei
 *
 */
public class EvaSelfJobEstimateBackingBean extends BaseBackingBean{
	private IEvaPlanUCC evaplanucc;
	private IjobEstimateUCC jobestimateucc;
    private List planList;
    private String initPlanAudit;
    private String planID;
    private String personID;
	public IjobEstimateUCC getJobestimateucc() {
		return jobestimateucc;
	}
	public void setJobestimateucc(IjobEstimateUCC jobestimateucc) {
		this.jobestimateucc = jobestimateucc;
	}
	public String getPersonID() {
		return personID;
	}
	public void setPersonID(String personID) {
		this.personID = personID;
	}
	public String getPlanID() {
        return planID;
    }
    public void setPlanID(String planID) {
        this.planID = planID;
    }

    public String getInitPlanAudit() {
        queryPlanList();
        return initPlanAudit;
    }
    public void setInitPlanAudit(String initPlanAudit) {
        this.initPlanAudit = initPlanAudit;
    }

    public String getPageInit(){
        queryPlanList();
        return "";
    }
    public void queryPlanList(){
        try{
        	planList=new ArrayList();
        	personID=super.getUserInfo().getUserId();
            List planList1=evaplanucc.findByOrgId(super.getUserInfo().getOrgId(),EvaPlanBO.EVA_PLANSTATUS_EXECUTE,EvaPlanBO.EVA_MODEL_POST);
            for(int i=0;i<planList1.size();i++){
                EvaPlanBO ebo=(EvaPlanBO)planList1.get(i);
                PersonBO pbo= SysCacheTool.findPersonById(ebo.getCreatePersonId());
                ebo.setCreatePersonName(pbo.getName());
                EvaJobEstimateBO bo1=jobestimateucc.findSelfJobEstimateBO(ebo.getPlanId(), personID);
                if(bo1!=null){
                	planList.add(ebo);
                }
            }
        }
        catch(Exception e){

        }
    }

    public  List getPlanList(){
        return planList;
    }
    public void setPlanList(List list){
        planList=list;
    }

    public  IEvaPlanUCC getEvaplanucc(){
        return evaplanucc;
    }
    public void setEvaplanucc(IEvaPlanUCC ucc){
        evaplanucc=ucc;
    }
}
