package com.hr319wg.attence.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.attence.pojo.bo.AttChangeWorkBO;
import com.hr319wg.attence.pojo.bo.AttClassBO;
import com.hr319wg.attence.pojo.bo.AttClassGroupBO;
import com.hr319wg.attence.pojo.bo.AttEvcctionRecBO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.WFNodeBO;
import com.hr319wg.sys.pojo.vo.WFTransaction;
import com.hr319wg.util.CommonFuns;

public class PersonChangeWorkBackingBean extends BaseBackingBean {
	private String status;
	private String initEdit1;
	private String superID = super.getUserInfo().getOrgId();
	private List persBos1;
	private List persBos2 = new ArrayList();
	private String operID;
	private String initEdit;
	private static String KQGL_CHANGE_WORK_VALUE="KQGL_004";
	private String changeID;
	private String className;
	private AttChangeWorkBO bo=new AttChangeWorkBO();
	private AttChangeWorkBO bo1=new AttChangeWorkBO();
	private String initset;
	private String groupName;
	private String personName = super.getUserInfo().getName();
	private boolean isExist = false;
	private boolean isExist1 = false;
	private String userid = super.getUserInfo().getUserId();
	private List persBos;
	private PageVO mypage = new PageVO();
	private String pageInit;
	private IAttenceSetUCC attenceSetUCC;

	public String first() {
		mypage.setCurrentPage(1);
		seePersonChangeWorkMessage();
		return "";
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		seePersonChangeWorkMessage();
		return "";
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		seePersonChangeWorkMessage();
		return "";
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		seePersonChangeWorkMessage();
		return "";
	}
	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	
	public boolean getIsExist() {
		return isExist;
	}

	public void setIsExist(boolean isExist) {
		this.isExist = isExist;
	}

	public boolean getIsExist1() {
		return isExist1;
	}

	public void setIsExist1(boolean isExist1) {
		this.isExist1 = isExist1;
	}
	
	public String getPageInit() {
		try {
		groupName=attenceSetUCC.getA001737(userid);
		} catch (Exception e) {

		}
		seePersonChangeWorkMessage();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public String seePersonChangeWorkMessage() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			persBos = attenceSetUCC.getAttChangeWorkBO(userid,mypage,isExist);
			if (persBos != null && persBos.size() > 0) {
				for (int i = 0; i < persBos.size(); i++) {
					AttChangeWorkBO attchangeworkbo = (AttChangeWorkBO) persBos
							.get(i);
					if(attchangeworkbo.getDeptAuditResult()!=null && !"".equals(attchangeworkbo.getDeptAuditResult())){
						if("1".equals(attchangeworkbo.getDeptAuditResult())){
							attchangeworkbo.setDeptAuditCausevalue("同意");
						}else{
							attchangeworkbo.setDeptAuditCausevalue("不同意");
						}						
					}
					if(attchangeworkbo.getHrAuditResult()!=null && !"".equals(attchangeworkbo.getHrAuditResult())){
						if("1".equals(attchangeworkbo.getHrAuditResult())){
							attchangeworkbo.setHrAuditResultvalue("同意");
						}else{
							attchangeworkbo.setHrAuditResultvalue("不同意");
						}
					}
					if(attchangeworkbo.getOldClass()!=null && !"".equals(attchangeworkbo.getOldClass())){
						if("1".equals(attchangeworkbo.getOldClass())){
							attchangeworkbo.setOldClassName("休息");
						}else if("2".equals(attchangeworkbo.getOldClass())){
							attchangeworkbo.setOldClassName("节假日");
						}else if("3".equals(attchangeworkbo.getOldClass())){
							attchangeworkbo.setOldClassName("公休日");
						}else{
							AttClassBO attclassbo=attenceSetUCC.findAttClassBObyId(attchangeworkbo.getOldClass());
							attchangeworkbo.setOldClassName(attclassbo.getClassName());
						}
					}else{
						attchangeworkbo.setOldClassName("未设");
					}
					if(attchangeworkbo.getNewClass()!=null && !"".equals(attchangeworkbo.getNewClass())){
						if("1".equals(attchangeworkbo.getNewClass())){
							attchangeworkbo.setNewClassName("休息");
						}else if("2".equals(attchangeworkbo.getNewClass())){
							attchangeworkbo.setNewClassName("节假日");
						}else if("3".equals(attchangeworkbo.getNewClass())){
							attchangeworkbo.setNewClassName("公休日");
						}else{
							AttClassBO attclassbo=attenceSetUCC.findAttClassBObyId(attchangeworkbo.getNewClass());
							attchangeworkbo.setNewClassName(attclassbo.getClassName());
						}
					}else{
						attchangeworkbo.setNewClassName("未设");
					}
					persBos.set(i, attchangeworkbo);
				}
			}
		} catch (Exception e) {

		}
		return "";
	}
	
	
	public String getInitset() {
		return initset;
	}

	public void setInitset(String initset) {
		this.initset = initset;
	}

	public String getInitset1() {
		try {
			String oldClassValue=attenceSetUCC.getA001737(userid);
			AttClassGroupBO attclassgroupbos=attenceSetUCC.findAttClassGroupBObyId(oldClassValue);
			AttClassBO attclassbo=attenceSetUCC.changeWork1(userid,superID,oldClassValue,bo.getApplyDate());
			if(attclassbo!=null){
				bo.setOldClass(attclassbo.getClassID());
				bo.setOldClassName(attclassbo.getClassName());	
			}else{
				bo.setOldClass("");
				bo.setOldClassName("未设");
			}
			} catch (Exception e) {

			}
		return "";
	}
	
	public String SaveSet(){
		bo.setPersonID(userid);
		bo.setStatusValue("-1");
		try {
			attenceSetUCC.deleteAttChangeWorkBO(userid,bo.getApplyDate());
			attenceSetUCC.saveorupdateAttChangeWorkBO(bo);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}
	
    /*
     * 报批
     */
	public String personChangeWorkMessageAudit() {
		try {
			if (changeID != null) {
				AttChangeWorkBO attchangeworkbo=attenceSetUCC.findAttChangeWorkBObyId(changeID);
				attchangeworkbo.setStatusValue("0");
				attenceSetUCC.saveorupdateAttChangeWorkBO(attchangeworkbo);
				WFTransaction wt = new WFTransaction();
				wt.setLinkID(changeID);
				wt.setOperID("0525");
				wt.setUser(super.getUserInfo());
				wt.setWfType(KQGL_CHANGE_WORK_VALUE);
				wt.setStatusValue("0"); //审批状态
				wt.setWffunction("att_WorkFlowChangeWorkService");
				attenceSetUCC.processTrans(wt);
			}
		} catch (Exception e) {

		}
		return "";
	}
	
	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}

	public List getPersBos() {
		return persBos;
	}

	public void setPersBos(List persBos) {
		this.persBos = persBos;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public AttChangeWorkBO getBo() {
		return bo;
	}

	public void setBo(AttChangeWorkBO bo) {
		this.bo = bo;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getChangeID() {
		return changeID;
	}

	public void setChangeID(String changeID) {
		this.changeID = changeID;
	}

	public String getOperID() {
		return operID;
	}

	public void setOperID(String operID) {
		this.operID = operID;
	}

	public String getInitEdit() {
		if (super.getRequestParameter("OperID") != null
				&& !super.getRequestParameter("OperID").equals("")) {
			operID = super.getRequestParameter("OperID");
		}
		if (persBos2 != null) {
			persBos2 = new ArrayList();
		}
		personChangeWorkAudit();
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	/*
	 *审批 
	 */
	public String personChangeWorkAudit() {
		 PersonBO person=null;
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
						persBos1 = attenceSetUCC.getAttChangeWorkBO1(this.superID,mypage,isExist1);
						if (persBos1 != null && persBos1.size() > 0) {
							for (int j = 0; j < persBos1.size(); j++) {
								AttChangeWorkBO attchangeworkbo1 = (AttChangeWorkBO) persBos1
										.get(j);
								person =SysCacheTool.findPersonById(attchangeworkbo1.getPersonID());
								attchangeworkbo1.setPersonName(person.getName());
								if(attchangeworkbo1.getOldClass()!=null && !"".equals(attchangeworkbo1.getOldClass())){
									if("1".equals(attchangeworkbo1.getOldClass())){
										attchangeworkbo1.setOldClassName("休息");
									}else if("2".equals(attchangeworkbo1.getOldClass())){
										attchangeworkbo1.setOldClassName("节假日");
									}else if("3".equals(attchangeworkbo1.getOldClass())){
										attchangeworkbo1.setOldClassName("公休日");
									}else{
										AttClassBO attclassbo=attenceSetUCC.findAttClassBObyId(attchangeworkbo1.getOldClass());
										attchangeworkbo1.setOldClassName(attclassbo.getClassName());
									}
								}else{
									attchangeworkbo1.setOldClassName("未设");
								}
								if(attchangeworkbo1.getNewClass()!=null && !"".equals(attchangeworkbo1.getNewClass())){
									if("1".equals(attchangeworkbo1.getNewClass())){
										attchangeworkbo1.setNewClassName("休息");
									}else if("2".equals(attchangeworkbo1.getNewClass())){
										attchangeworkbo1.setNewClassName("节假日");
									}else if("3".equals(attchangeworkbo1.getNewClass())){
										attchangeworkbo1.setNewClassName("公休日");
									}else{
										AttClassBO attclassbo=attenceSetUCC.findAttClassBObyId(attchangeworkbo1.getNewClass());
										attchangeworkbo1.setNewClassName(attclassbo.getClassName());
									}
								}else{
									attchangeworkbo1.setNewClassName("未设");
								}
								WFNodeBO currentnode = attenceSetUCC
										.getCurrentNode(attchangeworkbo1.getChangeID());
								if (currentnode != null) {
									if (currentnode.getOperID().equals(operID)) {
										attchangeworkbo1.setFlagvalue("yes");
									} else {
										attchangeworkbo1.setFlagvalue("no");
									}
								}
								persBos2.add(attchangeworkbo1);
							}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public List getPersBos2() {
		return persBos2;
	}

	public void setPersBos2(List persBos2) {
		this.persBos2 = persBos2;
	}

	public List getPersBos1() {
		return persBos1;
	}

	public void setPersBos1(List persBos1) {
		this.persBos1 = persBos1;
	}

	public String getSuperID() {
		return superID;
	}

	public void setSuperID(String superID) {
		this.superID = superID;
	}
	
	public AttChangeWorkBO getBo1() {
		return bo1;
	}

	public void setBo1(AttChangeWorkBO bo1) {
		this.bo1 = bo1;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getInitEdit1() {
		try {
		if (super.getRequestParameter("evcctionNO") != null
				&& !super.getRequestParameter("evcctionNO").equals("") && super.getRequestParameter("operID") != null
				&& !super.getRequestParameter("operID").equals("")) {
			operID=super.getRequestParameter("operID");
			changeID = super.getRequestParameter("evcctionNO");
			bo1=attenceSetUCC.findAttChangeWorkBObyId(changeID);
			String name=SysCacheTool.findPersonById(bo1.getPersonID()).getName();
			String a="";
			if ("ORACLE".equals(Constants.DB_TYPE)) {
				a=new String(name.getBytes("iso-8859-1"), "GBK");	
			}else{
				a=name;
			}
			bo1.setPersonName(a);
			if(bo1.getOldClass()!=null && !"".equals(bo1.getOldClass())){
				if("1".equals(bo1.getOldClass())){
					bo1.setOldClassName("休息");
				}else if("2".equals(bo1.getOldClass())){
					bo1.setOldClassName("节假日");
				}else if("3".equals(bo1.getOldClass())){
					bo1.setOldClassName("公休日");
				}else{
					AttClassBO attclassbo=attenceSetUCC.findAttClassBObyId(bo1.getOldClass());
					bo1.setOldClassName(attclassbo.getClassName());
				}
			}else{
				bo1.setOldClassName("未设");
			}
			if(bo1.getNewClass()!=null && !"".equals(bo1.getNewClass())){
				if("1".equals(bo1.getNewClass())){
					bo1.setNewClassName("休息");
				}else if("2".equals(bo1.getNewClass())){
					bo1.setNewClassName("节假日");
				}else if("3".equals(bo1.getNewClass())){
					bo1.setNewClassName("公休日");
				}else{
					AttClassBO attclassbo=attenceSetUCC.findAttClassBObyId(bo1.getNewClass());
					bo1.setNewClassName(attclassbo.getClassName());
				}
			}else{
				bo1.setNewClassName("未设");
			}
			if(bo1.getDeptAuditResult()!=null && !"".equals(bo1.getDeptAuditResult())){
				if("1".equals(bo1.getDeptAuditResult())){
					bo1.setDeptAuditCausevalue("同意");
				}else{
					bo1.setDeptAuditCausevalue("不同意");
				}						
			}
		}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return initEdit1;
	}

	public void setInitEdit1(String initEdit1) {
		this.initEdit1 = initEdit1;
	}

	/*
	 *部门经理审批结果 
	 */
	public String personChangeWorkAudit1(){
		if("1".equals(status)){
			bo1.setStatusValue("1");
		}else if("2".equals(status)){
			bo1.setStatusValue("2");
		}
		bo1.setDeptAuditResult(status);
		bo1.setDeptAuditOper(personName);
		bo1.setDeptAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try {
			attenceSetUCC.saveorupdateAttChangeWorkBO(bo1);
			WFTransaction wt = new WFTransaction();
			wt.setLinkID(bo1.getChangeID());
			//wt.setOperID("0530");
			wt.setOperID(operID);
			wt.setUser(super.getUserInfo());
			wt.setWfType(KQGL_CHANGE_WORK_VALUE);
			wt.setStatusValue(status); //审批状态
			wt.setWffunction("att_WorkFlowChangeWorkService");
			attenceSetUCC.processTrans(wt);
			} catch (SysException e) {
				e.printStackTrace();
			}
		return "success";
	}
	
	/*
	 *人力资源部门审批结果 
	 */
	public String personChangeWorkAudit2(){
		if("1".equals(status)){
			bo1.setStatusValue("3");
		}else if("2".equals(status)){
			bo1.setStatusValue("2");
		}
		bo1.setHrAuditResult(status);
		bo1.setHrAuditOper(personName);
		bo1.setHrAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try {
			attenceSetUCC.saveorupdateAttChangeWorkBO(bo1);
			//if("2".equals(status)){
				WFTransaction wt = new WFTransaction();
				wt.setLinkID(bo1.getChangeID());
				//wt.setOperID("0530");
				wt.setOperID(operID);
				wt.setUser(super.getUserInfo());
				wt.setWfType(KQGL_CHANGE_WORK_VALUE);
				wt.setStatusValue(status); //审批状态
				wt.setWffunction("att_WorkFlowChangeWorkService");
				attenceSetUCC.processTrans(wt);
			//}
			} catch (SysException e) {
				e.printStackTrace();
			}
		return "success";
	}
	
	public void changeNowYearValue(ValueChangeEvent event){
        this.isExist="true".equals(event.getNewValue().toString());
        getPageInit();
    }
	
	public void changeNowYearValue1(ValueChangeEvent event){
        this.isExist1="true".equals(event.getNewValue().toString());
        getInitEdit();
    }
	
	public void changeStatus(ValueChangeEvent event){
		   this.status = event.getNewValue().toString();
		}
}
