package com.hr319wg.attence.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.attence.pojo.bo.AttClassBO;
import com.hr319wg.attence.pojo.bo.AttManagerArgumentBO;
import com.hr319wg.attence.pojo.bo.AttenceWaterBO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.Constants;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.SequenceGenerator;

public class AutoClassManagerRuleBackingBean extends BaseBackingBean {
	private AttenceWaterBO bo1=new AttenceWaterBO();
	private String initEdit2;
	private List argumentList=new ArrayList();
	private String amaId;
	private String className;
	private String duraYearMonth;
	private String initEdit1;
	private String nowyearvalue="1";
	private AttManagerArgumentBO bo=new AttManagerArgumentBO();
	private String initEdit;
	private String superId=super.getUserInfo().getOrgId();
	private List dateList;
	private String pageInit;
	private IAttenceSetUCC attenceSetUCC;
	private PageVO mypage = new PageVO();
	
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

	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}

	public String getPageInit() {
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	
	public List getDateList() {
		return dateList;
	}

	public void setDateList(List dateList) {
		this.dateList = dateList;
	}

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public String getInitEdit() {
		try{
		className="";
		if (super.getRequestParameter("amaId") != null && !super.getRequestParameter("amaId").equals("")) {
			amaId = super.getRequestParameter("amaId");
			bo=attenceSetUCC.findAttManagerArgumentBObyId(amaId);
			nowyearvalue=bo.getFormula();
			OrgBO b = SysCacheTool.findOrgById(bo.getOrgId());
			if (b != null) {
				bo.setOrgIdName(b.getName());
			}else{
				bo.setOrgIdName("");
			}
			if(!"1".equals(bo.getLinkClass().trim())){
				 AttClassBO attclassbo=attenceSetUCC.findAttClassBObyId(bo.getLinkClass());
				 className=attclassbo.getClassName();
			}else{
			     className="休息";
			}
		}else if(super.getRequestParameter("superId") != null && !super.getRequestParameter("superId").equals("")){
			if(bo!=null){
				bo=new AttManagerArgumentBO();
				bo.setRestDay("6");
				if("1".equals(nowyearvalue)){
					bo.setLunchRate("40");
					bo.setSuperRate("60");
					bo.setWaiter("13");
					bo.setSquadPerson("4");
					bo.setProduceRate("");
					bo.setProduceRoad("");	
					bo.setCleanNumber("");
					bo.setBigTableWare("");
					bo.setSmallTableWare("");
					bo.setBonePlate("");
				}else if("2".equals(nowyearvalue)){
					bo.setLunchRate("");
					bo.setSuperRate("");
					bo.setWaiter("");
					bo.setProduceRate("");
					bo.setProduceRoad("");
					bo.setCleanNumber("");
					bo.setBigTableWare("");
					bo.setSmallTableWare("");
					bo.setBonePlate("");
				}else if("3".equals(nowyearvalue)){
					bo.setLunchRate("");
					bo.setSuperRate("");
					bo.setWaiter("");
					bo.setSquadPerson("");
					bo.setProduceRate("");
					bo.setProduceRoad("");	
					bo.setCleanNumber("500");
					bo.setBigTableWare("1");
					bo.setSmallTableWare("1");
					bo.setBonePlate("1.5");
				}
			}
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public AttManagerArgumentBO getBo() {
		return bo;
	}

	public void setBo(AttManagerArgumentBO bo) {
		this.bo = bo;
	}

	public String getNowyearvalue() {
		return nowyearvalue;
	}

	public void setNowyearvalue(String nowyearvalue) {
		this.nowyearvalue = nowyearvalue;
	}

	public String getInitEdit1() {
		try{
		if (super.getRequestParameter("duraYearMonth") != null && !super.getRequestParameter("duraYearMonth").equals("")) {
			duraYearMonth = super.getRequestParameter("duraYearMonth");
			if(argumentList!=null && argumentList.size()>0){
				argumentList=new ArrayList();
			}
		    List lists=attenceSetUCC.findAttenceWaterBO3(superId,duraYearMonth.trim());
		    if(lists!=null && lists.size()>0){
			  for(int i=0;i<lists.size();i++){
				  AttenceWaterBO attencewaterbo=(AttenceWaterBO)lists.get(i);
				  OrgBO b = SysCacheTool.findOrgById(attencewaterbo.getOrguid());
				  if(b!=null){
					  attencewaterbo.setOrguidName(b.getName());
				  }else{
					  attencewaterbo.setOrguidName("");
				  }
				  argumentList.add(attencewaterbo);
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

	public String getDuraYearMonth() {
		return duraYearMonth;
	}

	public void setDuraYearMonth(String duraYearMonth) {
		this.duraYearMonth = duraYearMonth;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getAmaId() {
		return amaId;
	}

	public void setAmaId(String amaId) {
		this.amaId = amaId;
	}

	public List getArgumentList() {
		return argumentList;
	}

	public void setArgumentList(List argumentList) {
		this.argumentList = argumentList;
	}

	public String getInitEdit2() {
		try{
		if (super.getRequestParameter("subId") != null
				&& !super.getRequestParameter("subId").equals("")
				&& super.getRequestParameter("orgId") != null
				&& !super.getRequestParameter("orgId").equals("")) {
			String subId1 = super.getRequestParameter("subId");
			String orgId1 = super.getRequestParameter("orgId");
			List lists=attenceSetUCC.findAttenceWaterBO(subId1,orgId1);
			bo1=(AttenceWaterBO)lists.get(0);
			OrgBO b = SysCacheTool.findOrgById(bo1.getOrguid());
			bo1.setOrguidName(b.getName());
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initEdit2;
	}

	public void setInitEdit2(String initEdit2) {
		this.initEdit2 = initEdit2;
	}

	public AttenceWaterBO getBo1() {
		return bo1;
	}

	public void setBo1(AttenceWaterBO bo1) {
		this.bo1 = bo1;
	}

	public void doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			dateList=attenceSetUCC.getAllAttManagerArgumentBO(mypage,superId);
			if (dateList != null && dateList.size() > 0) {
				for (int i = 0; i < dateList.size(); i++) {
					AttManagerArgumentBO attmanagerargumentbo=(AttManagerArgumentBO)dateList.get(i);
					OrgBO b = SysCacheTool.findOrgById(attmanagerargumentbo.getOrgId());
					if (b != null) {
						attmanagerargumentbo.setOrgIdName(b.getName());
					}else{
						attmanagerargumentbo.setOrgIdName("");
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String save(){
        try{
        	List lists=attenceSetUCC.findAttManagerArgumentBO(bo.getOrgId().trim());
        	if(lists!=null && lists.size()>0){
				super.showMessageDetail("本部门已经设置！");
				return "";
        	}
        	bo.setFormula(nowyearvalue);
        	attenceSetUCC.saveorupdateAttManagerArgumentBO(bo);
        }catch(Exception e){
        	e.printStackTrace();
        }
		return "success";
	}
	
	public String delete(){
		try{
			attenceSetUCC.deleteAttManagerArgumentBO(amaId);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public String save1(){
		try{
			AttenceWaterBO attencewaterbo=new AttenceWaterBO();
			attencewaterbo.setOrguid(bo1.getOrguid());
			attencewaterbo.setSubID(SequenceGenerator.getKeyId("B738"));
			attencewaterbo.setRecord(Constants.YES);
			attencewaterbo.setAttenceDate(bo1.getAttenceDate());
			attencewaterbo.setMonthVolume(bo1.getMonthVolume());
			attencewaterbo.setMonthProduce(bo1.getMonthProduce());
			attenceSetUCC.UpdateB738(bo1.getOrguid(),bo1.getAttenceDate());
			attenceSetUCC.saveorupdateAttenceWaterBO(attencewaterbo);
		}catch(Exception e){
		  e.printStackTrace();
		}
		return "success";
	}
	
	public void doQuery1() {
		try {
			if(argumentList!=null && argumentList.size()>0){
				 argumentList=new ArrayList();
			}
			System.out.println("duraYearMonth="+duraYearMonth);
		    List lists=attenceSetUCC.findAttenceWaterBO3(superId,duraYearMonth.trim());
		    if(lists!=null && lists.size()>0){
			  for(int i=0;i<lists.size();i++){
				  AttenceWaterBO attencewaterbo=(AttenceWaterBO)lists.get(i);
				  OrgBO b = SysCacheTool.findOrgById(attencewaterbo.getOrguid());
				  if(b!=null){
					  attencewaterbo.setOrguidName(b.getName());
				  }else{
					  attencewaterbo.setOrguidName("");
				  }
				  argumentList.add(attencewaterbo);
			  }
		    }
        }catch(Exception e){
        	e.printStackTrace();
        }
	}
	
	public String saveInput(){
		try{
			String[] orgIdStr = (String[])(String[])super.getHttpSession().getAttribute("orgIdStr");
			String[] argmentStr = (String[])(String[])super.getHttpSession().getAttribute("argmentStr");
		  if(orgIdStr!=null && orgIdStr.length>0){
			for(int i=0;i<orgIdStr.length;i++){
				 String value1=CommonFuns.filterNullToZero(super.getRequestParameter(orgIdStr[i] + "|" + argmentStr[0]));
				 String value2=CommonFuns.filterNullToZero(super.getRequestParameter(orgIdStr[i] + "|" + argmentStr[1]));
				 //String names=attenceSetUCC.selectB738(orgIdStr[i],duraYearMonth);
				 //if(names!=null && !"".equals(names)){
					 attenceSetUCC.UpdateB738(orgIdStr[i],duraYearMonth.trim());
				 //}
					AttenceWaterBO attencewaterbo=new AttenceWaterBO();
					attencewaterbo.setSubID(SequenceGenerator.getKeyId("B738"));
					attencewaterbo.setOrguid(orgIdStr[i]);
					attencewaterbo.setRecord(Constants.YES);
					attencewaterbo.setAttenceDate(duraYearMonth);
					attencewaterbo.setForecastWater("0");
					attencewaterbo.setRealityWater("0");
					attencewaterbo.setMonthVolume(value1);
					attencewaterbo.setMonthProduce(value2);
					attenceSetUCC.saveorupdateAttenceWaterBO(attencewaterbo);
			}
		  }else{
				super.showMessageDetail("请先设置自动排班计算规则！");
				return "";
		  }
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	
	public void changeNowYearValue(ValueChangeEvent event){
        this.nowyearvalue=event.getNewValue().toString();
    }
}
