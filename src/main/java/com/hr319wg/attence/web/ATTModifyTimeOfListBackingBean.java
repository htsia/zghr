package com.hr319wg.attence.web;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.hr319wg.attence.pojo.bo.AttTimeOffRecBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;

public class ATTModifyTimeOfListBackingBean extends BaseBackingBean {
	private AttTimeOffRecBO bo=new AttTimeOffRecBO();
	private String timeOffRecNO;
	private String initEdit;
	private String begindatevalueWdate;
	private String enddatevalueWdate;
	private String kqglLeaverDayValue;
	private String beginTime=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	private String name;
	private List lists1=new ArrayList();
	private PageVO mypage = new PageVO();
	private String superId=super.getUserInfo().getOrgId();
	private String pageInit;
	private IAttenceSetUCC attenceSetUCC;

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
		if(super.getRequestParameter("superId") != null && !super.getRequestParameter("superId").equals("")){
			superId=super.getRequestParameter("superId");
		}
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public List getLists1() {
		return lists1;
	}

	public void setLists1(List lists1) {
		this.lists1 = lists1;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getBegindatevalueWdate() {
		return begindatevalueWdate;
	}

	public void setBegindatevalueWdate(String begindatevalueWdate) {
		this.begindatevalueWdate = begindatevalueWdate;
	}

	public String getEnddatevalueWdate() {
		return enddatevalueWdate;
	}

	public void setEnddatevalueWdate(String enddatevalueWdate) {
		this.enddatevalueWdate = enddatevalueWdate;
	}

	public String getKqglLeaverDayValue() {
		return kqglLeaverDayValue;
	}

	public void setKqglLeaverDayValue(String kqglLeaverDayValue) {
		this.kqglLeaverDayValue = kqglLeaverDayValue;
	}

	public String getInitEdit() {
		try{
		if (super.getRequestParameter("timeOffRecNO") != null && !super.getRequestParameter("timeOffRecNO").equals("")) {
			timeOffRecNO = super.getRequestParameter("timeOffRecNO");
			begindatevalueWdate="";
			enddatevalueWdate="";
			kqglLeaverDayValue="";
			if(bo!=null){
			   bo=new AttTimeOffRecBO();
			}
			bo=attenceSetUCC.findAttTimeOffRecBObyId(timeOffRecNO);
			AttClassGroupVO attclassgroupvo=attenceSetUCC.findAttClassGroupVObyId(bo.getPersonID());
			String personname=attclassgroupvo.getName();
			bo.setPersonName(personname);
			begindatevalueWdate=bo.getBeginTime();
			enddatevalueWdate=bo.getEndTime();
			kqglLeaverDayValue=bo.getLastDate();
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public String getTimeOffRecNO() {
		return timeOffRecNO;
	}

	public void setTimeOffRecNO(String timeOffRecNO) {
		this.timeOffRecNO = timeOffRecNO;
	}

	public AttTimeOffRecBO getBo() {
		return bo;
	}

	public void setBo(AttTimeOffRecBO bo) {
		this.bo = bo;
	}

	public String doQuery(){
		try{
			if(lists1!=null && lists1.size()>0){
				lists1=new ArrayList();
			}
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			List lists=attenceSetUCC.findAttModifyTimeOffList(name,beginTime,superId,mypage);
			if(lists!=null && lists.size()>0){
				for(int i=0;i<lists.size();i++){
					AttTimeOffRecBO atttimeoffrecbo=(AttTimeOffRecBO)lists.get(i);
					AttClassGroupVO attclassgroupvo=attenceSetUCC.findAttClassGroupVObyId(atttimeoffrecbo.getPersonID());
					String personname=attclassgroupvo.getName();
					String seqname=attclassgroupvo.getPersonSeq();
					atttimeoffrecbo.setPersonName(personname);
					atttimeoffrecbo.setSeqName(seqname);
					lists1.add(atttimeoffrecbo);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public String queryPerson(){
		doQuery();
		return "";
	}
	
	/*
	 * 确认
	 */
		public String makesure(){
			try{
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date date1 = df.parse(begindatevalueWdate+":00");
				Date date2 = df.parse(enddatevalueWdate+":00");
				float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
				w = (float) (Math.round(w * 100)) / 100;
				kqglLeaverDayValue=""+w;
			}catch(Exception e){
				e.printStackTrace();
			}
			return "";
		}
		
		public String save(){
			try{
				if(begindatevalueWdate!=null && !"".equals(begindatevalueWdate) && enddatevalueWdate!=null && !"".equals(enddatevalueWdate)){
					if(kqglLeaverDayValue!=null && !"".equals(kqglLeaverDayValue)){
						float day1=Float.parseFloat(bo.getLastDate().trim());
						float day2=Float.parseFloat(kqglLeaverDayValue);
						if(day1!=day2){
							super.showMessageDetail("值必须等于倒休的天数"+bo.getLastDate().trim());
							return "";
						}
						bo.setBeginTime(begindatevalueWdate);
						bo.setEndTime(enddatevalueWdate);
						attenceSetUCC.saveorupdateAttTimeOffRecBO(bo);
					}else{
						super.showMessageDetail("请检查倒休天数！");
						return "";
					}
				}else{
					super.showMessageDetail("请正确填写倒休时间！");
					return "";
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			return "success";
		}
}
