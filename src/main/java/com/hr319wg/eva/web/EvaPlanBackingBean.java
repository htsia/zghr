package com.hr319wg.eva.web;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.vo.AttFileVO;
import com.hr319wg.sys.pojo.vo.BulletinEditVO;
import com.hr319wg.sys.ucc.IBulletinManageUCC;
import com.hr319wg.user.pojo.bo.SelfLevelBO;
import com.hr319wg.user.ucc.ISelfLevelUCC;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;

import javax.faces.context.FacesContext;
import javax.faces.event.ValueChangeEvent;
import javax.servlet.ServletContext;

import java.io.File;
import java.util.ArrayList;
import java.util.List;


/**
 * 绩效管理BackingBean
 * 负责绩效管理模块后台和展现之间的数据中转处理
 */
public class EvaPlanBackingBean extends BaseBackingBean {
    private IEvaPlanUCC evaplanucc;
    private List planList;
    private String status;
    private String initPlanAudit;
    private String planID;
    private ISelfLevelUCC selflevelUCC;
    private IBulletinManageUCC bulletinmanageucc;

    public IBulletinManageUCC getBulletinmanageucc() {
		return bulletinmanageucc;
	}
	public void setBulletinmanageucc(IBulletinManageUCC bulletinmanageucc) {
		this.bulletinmanageucc = bulletinmanageucc;
	}
	public ISelfLevelUCC getSelflevelUCC() {
		return selflevelUCC;
	}
	public void setSelflevelUCC(ISelfLevelUCC selflevelUCC) {
		this.selflevelUCC = selflevelUCC;
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


    public String executePlan(){
        try{
            EvaPlanBO bo=evaplanucc.findPlanById(this.planID);
            bo.setStatus(EvaPlanBO.EVA_PLANSTATUS_EXECUTE);
            evaplanucc.updatePlan(bo);
        }
        catch(Exception e){

        }
        return "";
    }

    public String setRegWorkSum(){
        try{
            EvaPlanBO bo=evaplanucc.findPlanById(this.planID);
            bo.setShowWorkSum("1");
            evaplanucc.updatePlan(bo);
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return "";
    }

    public String setNoRegWorkSum(){
        try{
            EvaPlanBO bo=evaplanucc.findPlanById(this.planID);
            bo.setShowWorkSum("0");
            evaplanucc.updatePlan(bo);
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return "";
    }
    
    public String ApplyResult(){
        try{
            EvaPlanBO bo=evaplanucc.findPlanById(this.planID);
            bo.setStatus(EvaPlanBO.EVA_PLANSTATUS_AppovResult);
            evaplanucc.updatePlan(bo);
        }
        catch(Exception e){

        }
        return "";
    }
    public String ApplyPlan(){
        try{
            EvaPlanBO bo=evaplanucc.findPlanById(this.planID);
            bo.setStatus(EvaPlanBO.EVA_PLANSTATUS_APPROVING);
            evaplanucc.updatePlan(bo);
        }
        catch(Exception e){

        }
        return "";
    }
    public String publishEvaFile(){
    	try{
    		EvaPlanBO bo=evaplanucc.findPlanById(this.planID);
    		BulletinEditVO vo = new BulletinEditVO();
			vo.setTopic("绩效考核文件");
			if(bo.getDescription()!=null&&!bo.getDescription().equals("")){
				vo.setContent(bo.getDescription());
			}else{
				vo.setContent(bo.getPlanName()+"绩效考核文件");
			}
			vo.setStartDate(bo.getBeginDate());
			vo.setEndDate(bo.getEndDate());
			vo.setNewEndDate(bo.getEndDate());
			String power = "";
			List list = selflevelUCC.getAlllevel();
			for (int i = 0; i < list.size(); i++) {
				SelfLevelBO sb = (SelfLevelBO) list.get(i);
				if ("".equals(power)) {
					power += sb.getItemName();
				} else {
					power += "," + sb.getItemName();
				}
			}
			vo.setInfoLevel(power);
			vo.setReaderType("01");
			vo.setScopeOrgIds(super.getUserInfo().getOrgId());
			ServletContext context = (ServletContext)FacesContext.getCurrentInstance().getExternalContext().getContext();
			String path = context.getRealPath("/") + File.separator + "file" + File.separator + "eva";
			List attList=new ArrayList();
			AttFileVO avo = new AttFileVO();
			avo.setIndex(String.valueOf(1));
			avo.setUpdated(true);
			avo.setPhysicsfile(path+"/file/eva/" + bo.getEvaFile()+".doc");
			avo.setAttFile("/file/eva/" + bo.getEvaFile()+".doc");
			avo.setAttTitle("附件");
			attList.add(avo);
			String id = bulletinmanageucc.createBulletin(vo, attList, super
					.getUserInfo().getUserId());
			bo.setEvaFileBull(id);
			evaplanucc.updatePlan(bo);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return "";
    }
    public String deletePlan(){
        try{
            evaplanucc.deletePlan(this.planID);
        }
        catch(Exception e){
            
        }
        return "";
    }
    public String getPageInit(){
        queryPlanList();
        return "";
    }
    public void queryPlanList(){
        try{
            if (status==null || "".equals(status)) status="-1";
            planList=evaplanucc.findByStatus(status);
            for(int i=0;i<planList.size();i++){
                EvaPlanBO ebo=(EvaPlanBO)planList.get(i);
                PersonBO pbo= SysCacheTool.findPersonById(ebo.getCreatePersonId());
                if(ebo.getShowWorkSum()==null|| ebo.getShowWorkSum().equals("")){
                    ebo.setShowWorkSum("0");
                }
                if(ebo.getAduitContent()!=null&&!ebo.getAduitContent().equals("")){
	                if(ebo.getAduitResult().equals("1")){
	                	ebo.setAduitContent("同意      "+CommonFuns.filterNull(ebo.getAduitContent()));
	                }
	                if(ebo.getAduitResult().equals("0")){
	                	ebo.setAduitContent("不同意    "+CommonFuns.filterNull(ebo.getAduitContent()));
	                }
                }else if(ebo.getAduitResult()!=null&&!ebo.getAduitResult().equals("")){
                	if(ebo.getAduitResult().equals("1")){
	                	ebo.setAduitContent("同意");
	                }
	                if(ebo.getAduitResult().equals("0")){
	                	ebo.setAduitContent("不同意");
	                }
                }
                if(pbo!=null){
                	ebo.setCreatePersonName(pbo.getName());
                }else{
                	ebo.setCreatePersonName("");
                }
                ebo.setOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, ebo.getOrgId()));
            }
        }
        catch(Exception e){
        	e.printStackTrace();
        }
    }
    public void changeStatus(ValueChangeEvent event){
        this.status = event.getNewValue().toString();
    }

    public  List getPlanList(){
        return planList;
    }
    public void setPlanList(List list){
        planList=list;
    }

    public  String getStatus(){
        return status;
    }
    public void setStatus(String s){
        status=s;
    }

    public  IEvaPlanUCC getEvaplanucc(){
        return evaplanucc;
    }
    public void setEvaplanucc(IEvaPlanUCC ucc){
        evaplanucc=ucc;
    }

}
