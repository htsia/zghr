package com.hr319wg.custom.ins.web;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.ins.pojo.bo.InsCalcSetBO;
import com.hr319wg.custom.ins.pojo.bo.InsMonthPayBO;
import com.hr319wg.custom.ins.service.IInsDataService;
import com.hr319wg.custom.util.CommonUtil;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;

public class InsDataBackingBean extends BaseBackingBean{
	
	private User user = super.getUserInfo();
	private PageVO mypage = new PageVO();
	private String pageInit;
	private String editInit;
	private String dataInit;
	private String orgID;
	private String nameStr;
	private String personType;
	private String personTypeValue;
	private String wageDate;
	private String operSetID;
	private String operWageDate;
	private String operStatus;
	private IInsDataService insDataService;
	private List<InsCalcSetBO> setList;
	private List<InsMonthPayBO> monthPayList;
	private InsCalcSetBO item;
	private InsMonthPayBO insMonthPayBO;
	
	public List<InsMonthPayBO> getMonthPayList() {
		return monthPayList;
	}
	public void setMonthPayList(List<InsMonthPayBO> monthPayList) {
		this.monthPayList = monthPayList;
	}
	public String getOperStatus() {
		return operStatus;
	}
	public void setOperStatus(String operStatus) {
		this.operStatus = operStatus;
	}
	public String getOperWageDate() {
		return operWageDate;
	}
	public void setOperWageDate(String operWageDate) {
		this.operWageDate = operWageDate;
	}
	public String getOperSetID() {
		return operSetID;
	}
	public void setOperSetID(String operSetID) {
		this.operSetID = operSetID;
	}
	public InsCalcSetBO getItem() {
		return item;
	}
	public void setItem(InsCalcSetBO item) {
		this.item = item;
	}
	public String getWageDate() {
		return wageDate;
	}
	public void setWageDate(String wageDate) {
		this.wageDate = wageDate;
	}
	public InsMonthPayBO getInsMonthPayBO() {
		return insMonthPayBO;
	}
	public void setInsMonthPayBO(InsMonthPayBO insMonthPayBO) {
		this.insMonthPayBO = insMonthPayBO;
	}
	public List<InsCalcSetBO> getSetList() {
		return setList;
	}
	public void setSetList(List<InsCalcSetBO> setList) {
		this.setList = setList;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public PageVO getMypage() {
		return mypage;
	}
	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}
	public String getOrgID() {
		return orgID;
	}
	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}
	public String getNameStr() {
		return nameStr;
	}
	public void setNameStr(String nameStr) {
		this.nameStr = nameStr;
	}
	public String getPersonType() {
		return personType;
	}
	public void setPersonType(String personType) {
		this.personType = personType;
	}
	public String getPersonTypeValue() {
		return personTypeValue;
	}
	public void setPersonTypeValue(String personTypeValue) {
		this.personTypeValue = personTypeValue;
	}
	public IInsDataService getInsDataService() {
		return insDataService;
	}
	public void setInsDataService(IInsDataService insDataService) {
		this.insDataService = insDataService;
	}
	public String getPageInit() {
		doQuery();
		return pageInit;
	}
	public String getEditInit() {
		String ID=super.getRequestParameter("ID");
		if(ID!=null && !"".equals(ID)){
			try {
				this.item=(InsCalcSetBO) this.insDataService.getBOByID(InsCalcSetBO.class, ID);
			} catch (SysException e) {
				e.printStackTrace();
			}
		}else{
			this.item=new InsCalcSetBO();
			this.item.setCreateOrgID(user.getOrgId());
			this.item.setCreateUserID(user.getUserId());
		}
		return editInit;
	}
	
	public String first() {
		mypage.setCurrentPage(1);
		return null;
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		return null;
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		return null;
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		return null;
	}
	
	public void doQuery(){
		if(mypage.getCurrentPage()==0){
			mypage.setCurrentPage(1);
		}
		try {
			this.setList=this.insDataService.getAllInsCalcSetBO(mypage, user.getOrgId(), user.getUserId(), this.wageDate);
		} catch (SysException e) {
			e.printStackTrace();
		}
		if(this.setList==null){
			this.setList=new ArrayList<InsCalcSetBO>();
		}
		for(InsCalcSetBO bo : this.setList){
			PersonBO p = SysCacheTool.findPersonById(bo.getCreateUserID());
			bo.setCreateUserName(p.getName());
		}
	}
	
	//±£´æÏîÄ¿
	public String saveSet(){
		try {
			this.insDataService.saveOrUpdateBO(this.item);
			return "success";
		} catch (SysException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	//¹éµµ
	public void endCalc(){
		try {
			InsCalcSetBO bo =(InsCalcSetBO) this.insDataService.getBOByID(InsCalcSetBO.class, this.operSetID);
			bo.setStatus("1");
			this.insDataService.saveOrUpdateBO(bo);
			super.showMessageDetail("¹éµµÍê³É");
		} catch (SysException e) {
			super.showMessageDetail("¹éµµÊ§°Ü");
			e.printStackTrace();
		}
	}
	//É¾³ý
	public void deleteSet(){
		try {
			this.insDataService.deleteSet(this.operSetID, this.operWageDate);
			super.showMessageDetail("É¾³ýÍê³É");
		} catch (SysException e) {
			super.showMessageDetail("É¾³ýÊ§°Ü");
			e.printStackTrace();
		}
	}
	
	public String getDataInit(){
		String act=super.getRequestParameter("act");
		if("init".equals(act)){
			this.mypage = new PageVO();
			this.nameStr=null;
			this.orgID=null;
			this.operSetID=null;
			this.operWageDate=null;
			this.operStatus=null;
		}
		String orgID1=super.getRequestParameter("orgID");
		if(orgID1!=null && !"".equals(orgID1)){
			this.orgID=orgID1;
		}
		String ID1=super.getRequestParameter("ID");
		if(ID1!=null && !"".equals(ID1)){
			this.operSetID=ID1;
		}
		String operWageDate1=super.getRequestParameter("operWageDate");
		if(operWageDate1!=null && !"".equals(operWageDate1)){
			this.operWageDate=operWageDate1;
		}
		String operStatus1=super.getRequestParameter("operStatus");
		if(operStatus1!=null && !"".equals(operStatus1)){
			this.operStatus=operStatus1;
		}
		if(this.personType==null || "".equals(this.personType)){
			try {
				this.personType=CommonUtil.getAllPersonTypes(super.getUserInfo());
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		doDataQuery();
		return null;
	}
	
	public void doDataQuery(){
		if(mypage.getCurrentPage()==0){
		 	mypage.setCurrentPage(1);
		}
		try {
			this.monthPayList = this.insDataService.getAllInsMonthPayBO(mypage, this.operSetID, this.operWageDate, this.orgID, this.personType, this.nameStr);
			if(this.monthPayList!=null){
				for(InsMonthPayBO bo : this.monthPayList){
					PersonBO p = SysCacheTool.findPersonById(bo.getUserID());
					bo.setUserCode(p.getPersonCode());
					bo.setUserName(p.getName());
					bo.setSecDeptID(CodeUtil.interpertCode(bo.getSecDeptID()));
					bo.setOrgID(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, bo.getOrgID()));
					bo.setPayAddress(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, bo.getPayAddress()));
					bo.setUserType(CodeUtil.interpertCode(bo.getUserType()));
					bo.setSelfPay(CodeUtil.interpertCode(bo.getSelfPay()));
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	//¼ÆËã½É·Ñ½ð¶î
	public void calc(){
		try {
			this.insDataService.calc(this.operSetID, this.operWageDate, user.getOrgId());
			super.showMessageDetail("¼ÆËãÍê³É");
		} catch (SysException e) {
			super.showMessageDetail("¼ÆËãÊ§°Ü");
			e.printStackTrace();
		}
	}
	
}
