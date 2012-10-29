package com.hr319wg.eva.web;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.eva.pojo.bo.EvaJobEstimateBO;
import com.hr319wg.eva.pojo.bo.EvaTempMasterBO;
import com.hr319wg.eva.ucc.IEvaObjectsUCC;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.SequenceGenerator;

public class EvaTemMasterManagerBackingBean extends BaseBackingBean {
	private IEvaObjectsUCC objectUCC;
	private String orgId;
	private String orgName;
	private String needCount;
	private String pageInit;
	private String planID;
	private List evaTempMasterList;
	private IEvaPlanUCC evaplanucc;
	private String initAdd;
	private PageVO pagevo = new PageVO();
	private List addPersonList;
	private String masterID;
	private EvaTempMasterBO masterbo;
	private String paswordEditInit;
	
	public String modifyPawword(){
		try {
			objectUCC.updateTempMasterBO(masterbo);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}
	
	public String getPaswordEditInit() {
		
			try {
				if(super.getRequestParameter("masterid")!=null){
					masterbo=objectUCC.findEvaTempMasterBOById(super.getRequestParameter("masterid"));
					masterbo.setMasterPName(SysCacheTool.findPersonById(masterbo.getMasterName()).getName());
					masterbo.setPlanName(evaplanucc.findPlanById(masterbo.getEvaPlanID()).getPlanName());
				}
			} catch (SysException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return paswordEditInit;
	}
	public void setPaswordEditInit(String paswordEditInit) {
		this.paswordEditInit = paswordEditInit;
	}
	public EvaTempMasterBO getMasterbo() {
		return masterbo;
	}
	public void setMasterbo(EvaTempMasterBO masterbo) {
		this.masterbo = masterbo;
	}
	public String getMasterID() {
		return masterID;
	}
	public void setMasterID(String masterID) {
		this.masterID = masterID;
	}
	public String deleteMaster(){
		try{
            if (masterID!=null){
                this.objectUCC.deleteTempMasterBO(masterID);
            }
        }
        catch(Exception e){
            super.showMessageDetail("删除失败!");
        }
        return "";
	}
	public String addPerson(){
        try{
        	String id=super.getRequestParameter("form1:personStr");
            if (id!=null){
                String []ids=id.split(",");
                if(ids[0].equals("")||ids[0]==null){
                	String[]ids2=new String[ids.length-1];
                	for(int i=0;i<ids2.length;i++){
                		ids2[i]=ids[i+1];
                	}
                	ids=new String[ids2.length];
                	ids=ids2;
                }
                int count=Integer.parseInt(needCount);
                if(ids.length<=count){
	                for(int i=0;i<count;i++){
	                	if(ids[i]!=null&&!ids[i].equals("")){
	                		EvaTempMasterBO bo=new EvaTempMasterBO();
	                		bo.setMasterID(SequenceGenerator.getKeyId("EVA_TEPMASTER"));
	                		bo.setEvaPlanID(planID);
	                		bo.setMasterName(ids[i]);
	                		bo.setIs_use("0");
	                		bo.setPassword("1");
	                		objectUCC.saveTempMasterBO(bo);
		              }
	                }
                }else{
                	super.showMessageDetail("选择人数超过录入人数限制!");
                }
                
            }
        }
        catch(Exception e){

        }
        return "";
 }

	public PageVO getPagevo() {
		return pagevo;
	}

	public void setPagevo(PageVO pagevo) {
		this.pagevo = pagevo;
	}

	public List getAddPersonList() {
		return addPersonList;
	}

	public void setAddPersonList(List addPersonList) {
		this.addPersonList = addPersonList;
	}

	public void setInitAdd(String initAdd) {
		this.initAdd = initAdd;
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
			addPersonList = objectUCC.AddTeamMasterPerson(pagevo,
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
			orgId=super.getUserInfo().getOrgId();
			orgName=CodeUtil.interpertCode(CodeUtil.TYPE_ORG, orgId);
			QueryAddPerson();
		} catch (Exception e) {

		}
		return initAdd;
	}
	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public IEvaPlanUCC getEvaplanucc() {
		return evaplanucc;
	}

	public void setEvaplanucc(IEvaPlanUCC evaplanucc) {
		this.evaplanucc = evaplanucc;
	}

	public List getEvaTempMasterList() {
		return evaTempMasterList;
	}

	public void setEvaTempMasterList(List evaTempMasterList) {
		this.evaTempMasterList = evaTempMasterList;
	}

	public String getPlanID() {
		return planID;
	}

	public void setPlanID(String planID) {
		this.planID = planID;
	}

	public String getPageInit() {
		
		try {
			if(super.getRequestParameter("planID")!=null){
				planID=super.getRequestParameter("planID");
				super.getHttpSession().setAttribute("planId", planID);
			}else{
				planID=(String)super.getHttpSession().getAttribute("planId");
			}
			needCount="";
			evaTempMasterList=objectUCC.getTemMasterBOList(planID);
			if(evaTempMasterList!=null&&evaTempMasterList.size()>0){
				for(int i=0;i<evaTempMasterList.size();i++){
					EvaTempMasterBO bo=(EvaTempMasterBO)evaTempMasterList.get(i);
					bo.setMasterPName(SysCacheTool.findPersonById(bo.getMasterName()).getName());
					bo.setPlanName(evaplanucc.findPlanById(bo.getEvaPlanID()).getPlanName());
				}
			}else{
				evaTempMasterList=new ArrayList();
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public String getNeedCount() {
		return needCount;
	}

	public void setNeedCount(String needCount) {
		this.needCount = needCount;
	}

	public IEvaObjectsUCC getObjectUCC() {
		return objectUCC;
	}

	public void setObjectUCC(IEvaObjectsUCC objectUCC) {
		this.objectUCC = objectUCC;
	}
}
