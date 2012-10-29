package com.hr319wg.attence.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.attence.pojo.bo.AttenceWaterBO;
import com.hr319wg.attence.pojo.bo.AttenceWeekWaterBO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.user.pojo.bo.RoleInfoBO;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.SequenceGenerator;

public class SetWeekSumBackingBean extends BaseBackingBean {
	private IAttenceSetUCC attenceSetUCC;
	private String pageInit;
	private PageVO mypage = new PageVO();
	private List dateList;
	private String dateValue=CommonFuns.getSysDate("yyyy-MM");
	private String orgIdsss=super.getUserInfo().getOrgId();
	private String initEdit;
	private AttenceWeekWaterBO bo=new AttenceWeekWaterBO();
	private String attenceDate;
	private String orgId;
	private boolean isExist;
	private String setStatus="1";
	private String initEdit1;
	private String orgId1;
	private String attenceDate1;
	private String attenceWeekDate1;
	private List dateList1;
	public boolean getIsExist() {
		return isExist;
	}

	public void setIsExist(boolean isExist) {
		this.isExist = isExist;
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
	
	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}
	
	public List getDateList1() {
		return dateList1;
	}

	public void setDateList1(List dateList1) {
		this.dateList1 = dateList1;
	}

	public String getOrgId1() {
		return orgId1;
	}

	public void setOrgId1(String orgId1) {
		this.orgId1 = orgId1;
	}

	public String getAttenceDate1() {
		return attenceDate1;
	}

	public void setAttenceDate1(String attenceDate1) {
		this.attenceDate1 = attenceDate1;
	}

	public String getAttenceWeekDate1() {
		return attenceWeekDate1;
	}

	public void setAttenceWeekDate1(String attenceWeekDate1) {
		this.attenceWeekDate1 = attenceWeekDate1;
	}

	public String getInitEdit1() {
		 if(super.getRequestParameter("orgId") != null && !super.getRequestParameter("orgId").equals("") && super.getRequestParameter("attenceDate") != null && !super.getRequestParameter("attenceDate").equals("")){
			 orgId1=super.getRequestParameter("orgId");
			 attenceDate1=super.getRequestParameter("attenceDate");
			 attenceWeekDate1=super.getRequestParameter("attenceWeekDate");
		  }
		doQuery1();
		return initEdit1;
	}

	public void setInitEdit1(String initEdit1) {
		this.initEdit1 = initEdit1;
	}

	public String getSetStatus() {
		return setStatus;
	}

	public void setSetStatus(String setStatus) {
		this.setStatus = setStatus;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String getAttenceDate() {
		return attenceDate;
	}

	public void setAttenceDate(String attenceDate) {
		this.attenceDate = attenceDate;
	}

	public AttenceWeekWaterBO getBo() {
		return bo;
	}

	public void setBo(AttenceWeekWaterBO bo) {
		this.bo = bo;
	}

	public String getInitEdit() {
		try{
			if (super.getRequestParameter("subId") != null
					&& !super.getRequestParameter("subId").equals("")
					&& super.getRequestParameter("orgId") != null
					&& !super.getRequestParameter("orgId").equals("")) {
				String subId1 = super.getRequestParameter("subId");
				String orgId1 = super.getRequestParameter("orgId");
				List lists=attenceSetUCC.findAttenceWeekWaterBO(subId1,orgId1);
				bo=(AttenceWeekWaterBO)lists.get(0);
				attenceDate=bo.getAttenceDate();
				OrgBO b = SysCacheTool.findOrgById(bo.getOrguid());
				bo.setOrguidName(b.getName());
				orgId=bo.getOrguid();
				isExist = false;
				setStatus=bo.getAttenceWeekDate();
			}else if(super.getRequestParameter("ok") != null && !super.getRequestParameter("ok").equals("")){
				bo=new AttenceWeekWaterBO();
				isExist = true;
				setStatus="1";
			}
			}catch(Exception e){
				e.printStackTrace();
			}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public String getDateValue() {
		return dateValue;
	}

	public void setDateValue(String dateValue) {
		this.dateValue = dateValue;
	}

	public String getOrgIdsss() {
		return orgIdsss;
	}

	public void setOrgIdsss(String orgIdsss) {
		this.orgIdsss = orgIdsss;
	}

	public List getDateList() {
		return dateList;
	}

	public void setDateList(List dateList) {
		this.dateList = dateList;
	}

	public String getPageInit() {
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}
	
	public void doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			if(super.getUserInfo().getprocessUnit().equals(RoleInfoBO.ORGTYPE_ALL)){
				dateList=attenceSetUCC.getAllAttenceWeekWaterBO(mypage,dateValue);
			}else{
				dateList=attenceSetUCC.getAllAttenceWeekWaterBO(mypage,dateValue,orgIdsss);
			}
			if (dateList != null && dateList.size() > 0) {
				for (int i = 0; i < dateList.size(); i++) {
					AttenceWeekWaterBO attenceweekwaterbo=(AttenceWeekWaterBO)dateList.get(i);
					OrgBO b = SysCacheTool.findOrgById(attenceweekwaterbo.getOrguid());
					attenceweekwaterbo.setOrguidName(b.getName());
					dateList.set(i, attenceweekwaterbo);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	public String save(){
		try{
		if(orgId!=null && !"".equals(orgId)){
			String[] orgIds=orgId.split(",");
			for(int i=0;i<orgIds.length;i++){
				String names=attenceSetUCC.selectB739(orgIds[i],attenceDate,setStatus);
				if(names!=null && !"".equals(names)){
					OrgBO b = SysCacheTool.findOrgById(orgIds[i]);
					super.showMessageDetail("应用范围是:("+b.getName()+")、时间是:("+attenceDate+")、第"+names+"周，已经选择");
					return "";
				}else{
					AttenceWeekWaterBO attenceweekwaterbo=new AttenceWeekWaterBO();
					attenceweekwaterbo.setSubID(SequenceGenerator.getKeyId("B739"));
					attenceweekwaterbo.setOrguid(orgIds[i]);
					attenceweekwaterbo.setRecord(Constants.YES);
					attenceweekwaterbo.setAttenceDate(attenceDate);
					attenceweekwaterbo.setAttenceWeekDate(setStatus);
					attenceweekwaterbo.setForecastWater(bo.getForecastWater());
					attenceweekwaterbo.setRealityWater(bo.getRealityWater());
					attenceSetUCC.saveorupdateAttenceWeekWaterBO(attenceweekwaterbo);
				}
			}
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	
	public String save1(){
		try{
			attenceSetUCC.UpdateB739(bo.getOrguid(),attenceDate,setStatus);
			bo.setSubID(SequenceGenerator.getKeyId("B739"));
			bo.setRecord(Constants.YES);
			bo.setAttenceDate(attenceDate);
			bo.setAttenceWeekDate(setStatus);
			attenceSetUCC.saveorupdateAttenceWeekWaterBO(bo);
			}catch(Exception e){
				e.printStackTrace();
			}
		return "success";
	}
	
	public void changeSetStatus(ValueChangeEvent event){
		   this.setStatus = event.getNewValue().toString();		   
}
	
	public void doQuery1() {
		try {
			dateList1=attenceSetUCC.findAttenceWeekWaterBO1(orgId1,attenceDate1,attenceWeekDate1);
			if (dateList1 != null && dateList1.size() > 0) {
				for (int i = 0; i < dateList1.size(); i++) {
					AttenceWeekWaterBO attenceweekwaterbo=(AttenceWeekWaterBO)dateList1.get(i);
					OrgBO b = SysCacheTool.findOrgById(attenceweekwaterbo.getOrguid());
					attenceweekwaterbo.setOrguidName(b.getName());
					dateList1.set(i, attenceweekwaterbo);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
}
