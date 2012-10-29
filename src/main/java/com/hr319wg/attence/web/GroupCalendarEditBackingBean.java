package com.hr319wg.attence.web;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.attence.pojo.bo.AttWorkCalendarBO;
import com.hr319wg.attence.ucc.IworkCalenderUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.user.pojo.bo.UserRptBO;

public class GroupCalendarEditBackingBean extends BaseBackingBean {
	private String pageInits;
	private boolean isExist = false;
	private AttWorkCalendarBO bo1=new AttWorkCalendarBO();
	private String initEdit;
	private String itemID;
	private List attmachineList=new ArrayList();
	private String name;
	private String name1;
	private String yearvalue;
	private String monthvalue;
	private String daily;
	private String aDate;
	private String pageInit;
	private IworkCalenderUCC workcalenderUCC;

	public boolean getIsExist() {
		return isExist;
	}

	public void setIsExist(boolean isExist) {
		this.isExist = isExist;
	}
	public String getPageInit() {
		if (super.getRequestParameter("name") != null && !"".equals(super.getRequestParameter("name"))
			&& super.getRequestParameter("yearvalue") != null && !"".equals(super.getRequestParameter("yearvalue"))
			&& super.getRequestParameter("monthvalue") != null && !"".equals(super.getRequestParameter("monthvalue"))
			&& super.getRequestParameter("daily") != null && !"".equals(super.getRequestParameter("daily"))) {
			name=super.getRequestParameter("name");
			yearvalue=super.getRequestParameter("yearvalue");
			monthvalue=super.getRequestParameter("monthvalue");
			daily=super.getRequestParameter("daily");
			String monthvalue1="";
			if(monthvalue.length()==2){
				monthvalue1=monthvalue;
			}else{
				monthvalue1="0"+monthvalue;
			}
			String dailyvalue="";
			if(daily.length()==2){
				dailyvalue=daily;
			}else{
				dailyvalue="0"+daily;
			}
			aDate=yearvalue+"-"+monthvalue1+"-"+dailyvalue;
			name1=aDate;
		}
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {		
		this.pageInit = pageInit;
	}

	public String getInitEdit() {
		try {
		if (super.getRequestParameter("name") != null && !"".equals(super.getRequestParameter("name"))
		    && super.getRequestParameter("name1") != null && !"".equals(super.getRequestParameter("name1"))){
			name=super.getRequestParameter("name");	
			name1=super.getRequestParameter("name1");
			bo1=new AttWorkCalendarBO();
			bo1.setDate(name1);
			isExist=false;
		}else if(super.getRequestParameter("itemIDS") != null && !"".equals(super.getRequestParameter("itemIDS"))
				 && super.getRequestParameter("name1") != null && !"".equals(super.getRequestParameter("name1"))){
			String itemIDS=super.getRequestParameter("itemIDS");
			name1=super.getRequestParameter("name1");
			bo1=workcalenderUCC.findBobyId(itemIDS);
			//事宜值
			//bo1.getPersonID()
			//bo1.getDate()
			//bo1.getActivity()
			//事宜值
			isExist=true;
		}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public IworkCalenderUCC getWorkcalenderUCC() {
		return workcalenderUCC;
	}

	public void setWorkcalenderUCC(IworkCalenderUCC workcalenderUCC) {
		this.workcalenderUCC = workcalenderUCC;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getYearvalue() {
		return yearvalue;
	}

	public void setYearvalue(String yearvalue) {
		this.yearvalue = yearvalue;
	}

	public String getMonthvalue() {
		return monthvalue;
	}

	public void setMonthvalue(String monthvalue) {
		this.monthvalue = monthvalue;
	}

	public String getDaily() {
		return daily;
	}

	public void setDaily(String daily) {
		this.daily = daily;
	}

	public String getADate() {
		return aDate;
	}

	public void setADate(String date) {
		aDate = date;
	}

	public List getAttmachineList() {
		return attmachineList;
	}

	public void setAttmachineList(List attmachineList) {
		this.attmachineList = attmachineList;
	}

	public String getItemID() {
		return itemID;
	}

	public void setItemID(String itemID) {
		this.itemID = itemID;
	}

	public AttWorkCalendarBO getBo1() {
		return bo1;
	}

	public void setBo1(AttWorkCalendarBO bo1) {
		this.bo1 = bo1;
	}

	public String getName1() {
		return name1;
	}

	public void setName1(String name1) {
		this.name1 = name1;
	}

	public String getPageInits() {
		return pageInits;
	}

	public void setPageInits(String pageInits) {
		this.pageInits = pageInits;
	}

	public void doQuery() {
		if(attmachineList!=null){
			attmachineList=new ArrayList();
		}
		try {
		 //日期值this.aDate
		  List lists=workcalenderUCC.findAttWorkCalendarBO1(name, aDate);
		  if(lists!=null && lists.size()>0){
			  for(int i=0;i<lists.size();i++){
				  AttWorkCalendarBO bo=(AttWorkCalendarBO)lists.get(i);
				  attmachineList.add(bo); 
			  }
		  }
		} catch (SysException e) {
			e.printStackTrace();
		}
	}

	public  String  delete(){
		try {
			workcalenderUCC.deleteAttWorkCalendarBO(itemID);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public String add(){
		try {
			if(!isExist){
				bo1.setPersonID(name);	
			}
			workcalenderUCC.saveorupdateAttWorkCalendarBO(bo1);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}
	
	public String saveSort(){
		try {
		String orgids[] = getServletRequest().getParameterValues("showItem");
		String superSort = "";
			for (int i = 0; i < orgids.length; i++){
				AttWorkCalendarBO attworkcalendarbo=workcalenderUCC.findBobyId(orgids[i]);
				if (i < 9){
					attworkcalendarbo.setSeq(superSort + "00" + (i + 1));
				}else if (i < 99){
					attworkcalendarbo.setSeq(superSort + "0" + (i + 1));
				}else{
					attworkcalendarbo.setSeq(superSort + (i + 1));
				}
				workcalenderUCC.saveorupdateAttWorkCalendarBO(attworkcalendarbo);
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}
	
}
