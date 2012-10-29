package com.hr319wg.attence.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.attence.pojo.bo.AttAnnualItemBO;
import com.hr319wg.attence.pojo.bo.AttAnnualRecordBO;
import com.hr319wg.attence.pojo.bo.AttMimicReportRecBO;
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

public class MrNetWorkHolidayBackingBean extends BaseBackingBean {
	private IAttenceSetUCC attenceSetUCC;
	private boolean isExist = false;
	private boolean isExist1 = false;
	private boolean isExist2 = false;
	private String pageInit;
	private String pageInit1;
	private String groupvalue;
	private PageVO mypage = new PageVO();
	private List persBos;
	private List persBos1;
	private List persBos2 = new ArrayList();
	private String userid = super.getUserInfo().getUserId();
	private String mimicReportNO;
	private String personName = super.getUserInfo().getName();
	private String networkyearvalue;
	private String networkdayvalue;
	private String networktimevalue;
	private String networkdestvalue;
	private String timeObject;
	private AttMimicReportRecBO bo=new AttMimicReportRecBO();
	private AttMimicReportRecBO bo1=new AttMimicReportRecBO();
	private String superID = super.getUserInfo().getOrgId();
	private static String KQGL_MR_NET_WORK_HOLIDAY_VALUE = "KQGL_007";
	private String initEdit;
	private String initEdit1;
	private String operID;
	private String status;
	private String deptID = super.getUserInfo().getDeptId();
	
	public String first() {
		mypage.setCurrentPage(1);
		seeMrNetWorkHolidayMessage();
		return "";
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		seeMrNetWorkHolidayMessage();
		return "";
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		seeMrNetWorkHolidayMessage();
		return "";
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		seeMrNetWorkHolidayMessage();
		return "";
	}
	
	/*
	 * 年假拟报申请
	 */
	public String mrNetWorkHolidayMessage() {
		try{
			bo.setPersonID(userid);
			bo.setMrYear(networkyearvalue);
			bo.setMrMonth(networktimevalue);
			bo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
			bo.setDest(networkdestvalue);
			bo.setLastDate(networkdayvalue);
			bo.setStatusValue("-1");
			attenceSetUCC.saveAttMimicReportRecBO(bo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	
	public void delete(){
		try{
			attenceSetUCC.deleteAttMimicReportRecBO(mimicReportNO);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void seeMrNetWorkHolidayMessage(){
		try{
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			persBos = attenceSetUCC.getAttMimicReportRecBO(userid, mypage, isExist);
			if (persBos != null && persBos.size() > 0) {
				for (int i = 0; i < persBos.size(); i++) {
					AttMimicReportRecBO attmimicrepoertrecbo=(AttMimicReportRecBO)persBos.get(i);
					if (attmimicrepoertrecbo.getDeptAuditResult() != null
							&& !""
									.equals(attmimicrepoertrecbo
											.getDeptAuditResult())) {
						if ("1".equals(attmimicrepoertrecbo.getDeptAuditResult())) {
							attmimicrepoertrecbo.setDeptAuditCausevalue("同意");
						} else {
							attmimicrepoertrecbo.setDeptAuditCausevalue("不同意");
						}
					}
					if (attmimicrepoertrecbo.getLeaderAuditResult() != null
							&& !"".equals(attmimicrepoertrecbo
									.getLeaderAuditResult())) {
						if ("1".equals(attmimicrepoertrecbo.getLeaderAuditResult())) {
							attmimicrepoertrecbo.setLeaderAuditCausevalue("同意");
						} else {
							attmimicrepoertrecbo.setLeaderAuditCausevalue("不同意");
						}
					}
					if (attmimicrepoertrecbo.getHrAuditResult() != null
							&& !"".equals(attmimicrepoertrecbo.getHrAuditResult())) {
						if ("1".equals(attmimicrepoertrecbo.getHrAuditResult())) {
							attmimicrepoertrecbo.setHrAuditResultvalue("同意");
						} else {
							attmimicrepoertrecbo.setHrAuditResultvalue("不同意");
						}
					}
					if (attmimicrepoertrecbo.getHrDeptAuditResult() != null
							&& !""
									.equals(attmimicrepoertrecbo
											.getHrDeptAuditResult())) {
						if ("1".equals(attmimicrepoertrecbo.getHrDeptAuditResult())) {
							attmimicrepoertrecbo.setHrDeptAuditCausevalue("同意");
						} else {
							attmimicrepoertrecbo.setHrDeptAuditCausevalue("不同意");
						}
					}
					if (attmimicrepoertrecbo.getHrLeaderAuditResult() != null
							&& !"".equals(attmimicrepoertrecbo
									.getHrLeaderAuditResult())) {
						if ("1".equals(attmimicrepoertrecbo.getHrLeaderAuditResult())) {
							attmimicrepoertrecbo.setHrLeaderAuditCausevalue("同意");
						} else {
							attmimicrepoertrecbo.setHrLeaderAuditCausevalue("不同意");
						}
					}
					if(attmimicrepoertrecbo.getManAuditResult()!=null && !"".equals(attmimicrepoertrecbo.getManAuditResult())){
						if("1".equals(attmimicrepoertrecbo.getManAuditResult())){
							attmimicrepoertrecbo.setManAuditResultvalue("同意");
						}else{
							attmimicrepoertrecbo.setManAuditResultvalue("不同意");
						}
					}
					persBos.set(i, attmimicrepoertrecbo);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	/*
	 * 报批
	 */
	public String mrNetWorkHolidayMessageAudit() {
		try {
			if (mimicReportNO != null) {
			 AttMimicReportRecBO attmimicreportrecbo=attenceSetUCC.findAttMimicReportRecBObyId(mimicReportNO);
			 attmimicreportrecbo.setStatusValue("0");
			 attenceSetUCC.saveAttMimicReportRecBO(attmimicreportrecbo);
				WFTransaction wt = new WFTransaction();
				wt.setLinkID(mimicReportNO);
				wt.setOperID("0525");
				wt.setUser(super.getUserInfo());
				wt.setWfType(KQGL_MR_NET_WORK_HOLIDAY_VALUE);
				wt.setStatusValue(AttMimicReportRecBO.APPROVING); // 审批状态
				wt.setWffunction("att_WorkFlowMrNetWorkHolidayService");
				attenceSetUCC.processTrans(wt);
			}
		} catch (Exception e) {
            e.printStackTrace();
		}
		return "";
	}

	/*
	 * 部门经理审批结果
	 */
	public String mrNetWorkHolidayAudit1() {
		if ("1".equals(status)) {
			bo1.setStatusValue("1");
		} else if ("2".equals(status)) {
			bo1.setStatusValue("2");
		}
		bo1.setDeptAuditResult(status);
		bo1.setDeptAuditOper(personName);
		bo1.setDeptAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try{
			attenceSetUCC.saveAttMimicReportRecBO(bo1);
			WFTransaction wt = new WFTransaction();
			wt.setLinkID(bo1.getMimicReportNO());
			wt.setOperID(operID);
			wt.setUser(super.getUserInfo());
			wt.setWfType(KQGL_MR_NET_WORK_HOLIDAY_VALUE);
			wt.setStatusValue(status); // 审批状态
			wt.setWffunction("att_WorkFlowMrNetWorkHolidayService");
			attenceSetUCC.processTrans(wt);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	
	/*
	 * 主管领导审批结果
	 */
	public String mrNetWorkHolidayAudit2() {
		if ("1".equals(status)) {
			bo1.setStatusValue("1");
		} else if ("2".equals(status)) {
			bo1.setStatusValue("2");
		}
		bo1.setLeaderAuditResult(status);
		bo1.setLeaderAuditOper(personName);
		bo1.setLeaderAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try {
			attenceSetUCC.saveAttMimicReportRecBO(bo1);
			WFTransaction wt = new WFTransaction();
			wt.setLinkID(bo1.getMimicReportNO());
			wt.setOperID(operID);
			wt.setUser(super.getUserInfo());
			wt.setWfType(KQGL_MR_NET_WORK_HOLIDAY_VALUE);
			wt.setStatusValue(status); // 审批状态
			wt.setWffunction("att_WorkFlowMrNetWorkHolidayService");
			attenceSetUCC.processTrans(wt);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}
	
	/*
	 * 人力资源考勤员审批结果
	 */
	public String mrNetWorkHolidayAudit3() {
		if ("1".equals(status)) {
			bo1.setStatusValue("1");
		} else if ("2".equals(status)) {
			bo1.setStatusValue("2");
		}
		bo1.setHrAuditResult(status);
		bo1.setHrAuditOper(personName);
		bo1.setHrAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try {
			attenceSetUCC.saveAttMimicReportRecBO(bo1);
			WFTransaction wt = new WFTransaction();
			wt.setLinkID(bo1.getMimicReportNO());
			wt.setOperID(operID);
			wt.setUser(super.getUserInfo());
			wt.setWfType(KQGL_MR_NET_WORK_HOLIDAY_VALUE);
			wt.setStatusValue(status); // 审批状态
			wt.setWffunction("att_WorkFlowMrNetWorkHolidayService");
			attenceSetUCC.processTrans(wt);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}
	
	/*
	 * 人力资源部门经理审批结果
	 */
	public String mrNetWorkHolidayAudit4() {
		if ("1".equals(status)) {
			bo1.setStatusValue("1");
		} else if ("2".equals(status)) {
			bo1.setStatusValue("2");
		}
		bo1.setHrDeptAuditResult(status);
		bo1.setHrDeptAuditOper(personName);
		bo1.setHrDeptAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try{
			attenceSetUCC.saveAttMimicReportRecBO(bo1);
			WFTransaction wt = new WFTransaction();
			wt.setLinkID(bo1.getMimicReportNO());
			wt.setOperID(operID);
			wt.setUser(super.getUserInfo());
			wt.setWfType(KQGL_MR_NET_WORK_HOLIDAY_VALUE);
			wt.setStatusValue(status); // 审批状态
			wt.setWffunction("att_WorkFlowMrNetWorkHolidayService");
			attenceSetUCC.processTrans(wt);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	
	/*
	 * 人力资源主管领导审批结果
	 */
	public String mrNetWorkHolidayAudit5() {
		if ("1".equals(status)) {
			bo1.setStatusValue("1");
		} else if ("2".equals(status)) {
			bo1.setStatusValue("2");
		}
		bo1.setHrLeaderAuditResult(status);
		bo1.setHrLeaderAuditOper(personName);
		bo1.setHrLeaderAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try {
			attenceSetUCC.saveAttMimicReportRecBO(bo1);
			WFTransaction wt = new WFTransaction();
			wt.setLinkID(bo1.getMimicReportNO());
			wt.setOperID(operID);
			wt.setUser(super.getUserInfo());
			wt.setWfType(KQGL_MR_NET_WORK_HOLIDAY_VALUE);
			wt.setStatusValue(status); // 审批状态
			wt.setWffunction("att_WorkFlowMrNetWorkHolidayService");
			attenceSetUCC.processTrans(wt);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}
	
	/*
	 *总经理审批结果 
	 */
	public String mrNetWorkHolidayAudit6(){
		if("1".equals(status)){
			bo1.setStatusValue("1");
		}else if("2".equals(status)){
			bo1.setStatusValue("2");
		}
		bo1.setManAuditResult(status);
		bo1.setManAuditOper(personName);
		bo1.setManAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try {
			attenceSetUCC.saveAttMimicReportRecBO(bo1);
			WFTransaction wt = new WFTransaction();
			wt.setLinkID(bo1.getMimicReportNO());
			wt.setOperID(operID);
			wt.setUser(super.getUserInfo());
			wt.setWfType(KQGL_MR_NET_WORK_HOLIDAY_VALUE);
			wt.setStatusValue(status); // 审批状态
			wt.setWffunction("att_WorkFlowMrNetWorkHolidayService");
			attenceSetUCC.processTrans(wt);
			} catch (SysException e) {
				e.printStackTrace();
			}
		return "success";
	}
	
	/*
	 * 审批
	 */
	public String mrNetWorkHolidayAudit() {
		PersonBO person = null;
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			persBos1 = attenceSetUCC.findAttOverTimeRecBO(this.superID, mypage,isExist1,operID,deptID,super.getUserInfo());
			if (persBos1 != null && persBos1.size() > 0) {
				for (int j = 0; j < persBos1.size(); j++) {
					AttMimicReportRecBO attmimicrepoertrecbo=(AttMimicReportRecBO)persBos1.get(j);
					person = SysCacheTool.findPersonById(attmimicrepoertrecbo.getPersonID());
					attmimicrepoertrecbo.setPersonName(person.getName());
					WFNodeBO currentnode = attenceSetUCC.getCurrentNode(attmimicrepoertrecbo.getMimicReportNO());
					if (currentnode != null) {
						if (currentnode.getOperID().equals(operID)) {
							attmimicrepoertrecbo.setFlagvalue("yes");
						} else {
							attmimicrepoertrecbo.setFlagvalue("no");
						}
					}
					persBos2.add(attmimicrepoertrecbo);
				}
			}
		} catch (Exception e) {

		}
		return "";
	}
	
	public String getInitEdit1() {
		try{
			if (super.getRequestParameter("mimicReportNO") != null
					&& !super.getRequestParameter("mimicReportNO").equals("")
					&& super.getRequestParameter("operID") != null
					&& !super.getRequestParameter("operID").equals("")) {
				operID = super.getRequestParameter("operID");
				mimicReportNO = super.getRequestParameter("mimicReportNO");
				bo1 = attenceSetUCC.findAttMimicReportRecBObyId(mimicReportNO);
				String name = SysCacheTool.findPersonById(bo1.getPersonID()).getName();
				String a = "";
				//if ("ORACLE".equals(Constants.DB_TYPE)) {
					//a = new String(name.getBytes("iso-8859-1"), "GBK");
				//} else {
					a = name;
				//}
				bo1.setPersonName(a);
				if (bo1.getDeptAuditResult() != null
						&& !"".equals(bo1.getDeptAuditResult())) {
					if ("1".equals(bo1.getDeptAuditResult())) {
						bo1.setDeptAuditCausevalue("同意");
					} else {
						bo1.setDeptAuditCausevalue("不同意");
					}
				}
				if (bo1.getLeaderAuditResult() != null
						&& !"".equals(bo1.getLeaderAuditResult())) {
					if ("1".equals(bo1.getLeaderAuditResult())) {
						bo1.setLeaderAuditCausevalue("同意");
					} else {
						bo1.setLeaderAuditCausevalue("不同意");
					}
				}
				if (bo1.getHrAuditResult() != null
						&& !"".equals(bo1.getHrAuditResult())) {
					if ("1".equals(bo1.getHrAuditResult())) {
						bo1.setHrAuditResultvalue("同意");
					} else {
						bo1.setHrAuditResultvalue("不同意");
					}
				}
				if (bo1.getHrDeptAuditResult() != null
						&& !"".equals(bo1.getHrDeptAuditResult())) {
					if ("1".equals(bo1.getHrDeptAuditResult())) {
						bo1.setHrDeptAuditCausevalue("同意");
					} else {
						bo1.setHrDeptAuditCausevalue("不同意");
					}
				}
				if (bo1.getHrLeaderAuditResult() != null
						&& !"".equals(bo1.getHrLeaderAuditResult())) {
					if ("1".equals(bo1.getHrLeaderAuditResult())) {
						bo1.setHrLeaderAuditCausevalue("同意");
					} else {
						bo1.setHrLeaderAuditCausevalue("不同意");
					}
				}
				if(bo1.getManAuditResult()!=null && !"".equals(bo1.getManAuditResult())){
					if("1".equals(bo1.getManAuditResult())){
						bo1.setManAuditResultvalue("同意");
					}else{
						bo1.setManAuditResultvalue("不同意");
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initEdit1;
	}

	public void setInitEdit1(String initEdit1) {
		this.initEdit1 = initEdit1;
	}

	public List getPersBos1() {
		return persBos1;
	}

	public void setPersBos1(List persBos1) {
		this.persBos1 = persBos1;
	}

	public List getPersBos2() {
		return persBos2;
	}

	public void setPersBos2(List persBos2) {
		this.persBos2 = persBos2;
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
		mrNetWorkHolidayAudit();
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public String getSuperID() {
		return superID;
	}

	public void setSuperID(String superID) {
		this.superID = superID;
	}

	public AttMimicReportRecBO getBo() {
		return bo;
	}

	public void setBo(AttMimicReportRecBO bo) {
		this.bo = bo;
	}

	public String getNetworkyearvalue() {
		return networkyearvalue;
	}

	public void setNetworkyearvalue(String networkyearvalue) {
		this.networkyearvalue = networkyearvalue;
	}

	public String getNetworkdayvalue() {
		return networkdayvalue;
	}

	public void setNetworkdayvalue(String networkdayvalue) {
		this.networkdayvalue = networkdayvalue;
	}
	
	public void changeStatus(ValueChangeEvent event) {
		this.status = event.getNewValue().toString();
	}
	
	public void changeNowYearValue(ValueChangeEvent event) {
		this.isExist = "true".equals(event.getNewValue().toString());
		getPageInit();
	}
	
	public void changeNowYearValue1(ValueChangeEvent event) {
		this.isExist1 = "true".equals(event.getNewValue().toString());
		getInitEdit();
	}
	
	public String getTimeObject() {
		return timeObject;
	}

	public void setTimeObject(String timeObject) {
		this.timeObject = timeObject;
	}

	public String getNetworktimevalue() {
		return networktimevalue;
	}

	public void setNetworktimevalue(String networktimevalue) {
		this.networktimevalue = networktimevalue;
	}

	public String getNetworkdestvalue() {
		return networkdestvalue;
	}

	public void setNetworkdestvalue(String networkdestvalue) {
		this.networkdestvalue = networkdestvalue;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getPageInit1() {
		try{
			networkyearvalue="";
			networkdayvalue="";
			List lists=attenceSetUCC.findAttAnnualRecordBO(superID);
			if(lists!=null && lists.size()>0){
				isExist2 = true;
				AttAnnualRecordBO attannualrecordbo=(AttAnnualRecordBO)lists.get(0);
				networkyearvalue=attannualrecordbo.getRecodeYear().trim();
				List list1=attenceSetUCC.findAttAnnualItemBO(attannualrecordbo.getRecID(),userid);
				if(list1!=null && list1.size()>0){
					isExist2 = true;
					AttAnnualItemBO attannualitembo=(AttAnnualItemBO)list1.get(0);
					if(attannualitembo.getCriticalDate()!=null && !"".equals(attannualitembo.getCriticalDate())){
						if(attannualitembo.getAnnDay()!=null && !"".equals(attannualitembo.getAnnDay())){
							networkdayvalue=attannualitembo.getCriticalDate()+"之前（包括临界日期），年假可休天数为："+attannualitembo.getAnnDay()+";"+attannualitembo.getCriticalDate()+"之后，年假可休天数为："+attannualitembo.getCriticalAnnDay()+"天。";
						}else{
							networkdayvalue=attannualitembo.getCriticalDate()+"之前（包括临界日期），年假可休天数为：0天；"+attannualitembo.getCriticalDate()+"之后，年假可休天数为："+attannualitembo.getCriticalAnnDay()+"天。";
						}
					}else{
						networkdayvalue=attannualitembo.getAnnDay()+"天";
					}
				}else{
					isExist2 = false;
				}
			}else{
				isExist2 = false;
			}
			if (super.getRequestParameter("okID") != null
					&& !super.getRequestParameter("okID").equals("")) {
				bo=new AttMimicReportRecBO();
				networktimevalue="";
				networkdestvalue="";
			}else if (super.getRequestParameter("mimicReportNO") != null
					&& !super.getRequestParameter("mimicReportNO").equals("")) {
				mimicReportNO = super.getRequestParameter("mimicReportNO");
				bo=attenceSetUCC.findAttMimicReportRecBObyId(mimicReportNO);
				networkyearvalue=bo.getMrYear();
				networktimevalue=bo.getMrMonth();
				networkdayvalue=bo.getLastDate();
				networkdestvalue=bo.getDest();
				isExist2 = true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return pageInit1;
	}

	public void setPageInit1(String pageInit1) {
		this.pageInit1 = pageInit1;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public AttMimicReportRecBO getBo1() {
		return bo1;
	}

	public void setBo1(AttMimicReportRecBO bo1) {
		this.bo1 = bo1;
	}

	public String getMimicReportNO() {
		return mimicReportNO;
	}

	public void setMimicReportNO(String mimicReportNO) {
		this.mimicReportNO = mimicReportNO;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public List getPersBos() {
		return persBos;
	}

	public void setPersBos(List persBos) {
		this.persBos = persBos;
	}

	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public String getGroupvalue() {
		return groupvalue;
	}

	public void setGroupvalue(String groupvalue) {
		this.groupvalue = groupvalue;
	}

	public String getPageInit() {
		seeMrNetWorkHolidayMessage();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
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
	
	public boolean getIsExist2() {
		return isExist2;
	}

	public void setIsExist2(boolean isExist2) {
		this.isExist2 = isExist2;
	}
	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}

	public String getDeptID() {
		return deptID;
	}

	public void setDeptID(String deptID) {
		this.deptID = deptID;
	}
	
	
}
