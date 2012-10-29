package com.hr319wg.attence.web;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.attence.pojo.bo.AttClassBO;
import com.hr319wg.attence.pojo.bo.AttClassDetailBO;
import com.hr319wg.attence.pojo.bo.AttOverTimeLogBO;
import com.hr319wg.attence.pojo.bo.AttOverTimeRecBO;
import com.hr319wg.attence.pojo.bo.AttTimeOffRecBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.WFNodeBO;
import com.hr319wg.sys.pojo.vo.WFTransaction;
import com.hr319wg.util.CommonFuns;

public class PersonAddWorkBackingBean extends BaseBackingBean {
	private String status;
	private AttOverTimeRecBO bo1 = new AttOverTimeRecBO();
	private String initEdit1;
	private String superID = super.getUserInfo().getOrgId();
	private List persBos1;
	private List persBos2 = new ArrayList();
	private String operID;
	private String initEdit;
	private static String KQGL_ADD_WORK_VALUE = "KQGL_003";
	private AttOverTimeRecBO bo = new AttOverTimeRecBO();
	private String overTimeNO;
	private String kqglLeaverDayValue;
	private String enddatevalue;
	private String endtimevalue;
	private String begindatevalue;
	private String begintimevalue;
	private String pageInit1;
	private String personName = super.getUserInfo().getName();
	private List persBos;
	private boolean isExist = false;
	private boolean isExist1 = false;
	private boolean isExist2 = false;
	private String userid = super.getUserInfo().getUserId();
	private String pageInit;
	private PageVO mypage = new PageVO();
	private IAttenceSetUCC attenceSetUCC;
	private String typeStatus = "1";
	private String timeoffenddatevalue;
	private String timeofendtimevalue = "23:59";
	private String timeofbegindatevalue;
	private String timeofbegintimevalue = "00:00";
	private String timeoffkqglLeaverDayValue;
	private String timeInit;
	private List itemList = new ArrayList();
	private AttTimeOffRecBO atttimeoffrecbo = new AttTimeOffRecBO();
	private String groupvalue;
	private String begindatevalueWdate;
	private String enddatevalueWdate;
	private String timeoffbegindatevalueWdate;
	private String timeoffenddatevalueWdate;
	private String deptID = super.getUserInfo().getDeptId();
	public String first() {
		mypage.setCurrentPage(1);
		seePersonAddWorkMessage();
		return "";
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		seePersonAddWorkMessage();
		return "";
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		seePersonAddWorkMessage();
		return "";
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		seePersonAddWorkMessage();
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

	public String getPageInit() {
		seePersonAddWorkMessage();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
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

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getOverTimeNO() {
		return overTimeNO;
	}

	public void setOverTimeNO(String overTimeNO) {
		this.overTimeNO = overTimeNO;
	}

	public String getEnddatevalue() {
		return enddatevalue;
	}

	public void setEnddatevalue(String enddatevalue) {
		this.enddatevalue = enddatevalue;
	}

	public String getEndtimevalue() {
		return endtimevalue;
	}

	public void setEndtimevalue(String endtimevalue) {
		this.endtimevalue = endtimevalue;
	}

	public String getBegindatevalue() {
		return begindatevalue;
	}

	public void setBegindatevalue(String begindatevalue) {
		this.begindatevalue = begindatevalue;
	}

	public String getBegintimevalue() {
		return begintimevalue;
	}

	public void setBegintimevalue(String begintimevalue) {
		this.begintimevalue = begintimevalue;
	}

	public String getKqglLeaverDayValue() {
		return kqglLeaverDayValue;
	}

	public void setKqglLeaverDayValue(String kqglLeaverDayValue) {
		this.kqglLeaverDayValue = kqglLeaverDayValue;
	}

	public AttOverTimeRecBO getBo() {
		return bo;
	}

	public void setBo(AttOverTimeRecBO bo) {
		this.bo = bo;
	}

	public String getOperID() {
		return operID;
	}

	public void setOperID(String operID) {
		this.operID = operID;
	}

	public List getPersBos2() {
		return persBos2;
	}

	public void setPersBos2(List persBos2) {
		this.persBos2 = persBos2;
	}

	public String getSuperID() {
		return superID;
	}

	public void setSuperID(String superID) {
		this.superID = superID;
	}

	public List getPersBos1() {
		return persBos1;
	}

	public void setPersBos1(List persBos1) {
		this.persBos1 = persBos1;
	}

	public String getInitEdit() {
		if (super.getRequestParameter("OperID") != null
				&& !super.getRequestParameter("OperID").equals("")) {
			operID = super.getRequestParameter("OperID");
		}
		if (persBos2 != null) {
			persBos2 = new ArrayList();
		}
		personAddWorkAudit();
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public String getPageInit1() {
		try {
			if (super.getRequestParameter("okID") != null
					&& !super.getRequestParameter("okID").equals("")) {
				bo = new AttOverTimeRecBO();
				atttimeoffrecbo = new AttTimeOffRecBO();
				begindatevalue = "";
				begintimevalue = "00:00";
				enddatevalue = "";
				endtimevalue = "23:59";
				kqglLeaverDayValue = "";
    	    	begindatevalueWdate="";
    	    	enddatevalueWdate="";
    	    	
				timeofbegindatevalue = "";
				timeofbegintimevalue = "00:00";
				timeoffenddatevalue = "";
				timeofendtimevalue = "23:59";
				timeoffkqglLeaverDayValue = "";
				timeoffbegindatevalueWdate="";
				timeoffenddatevalueWdate="";
				
				typeStatus = "1";

				isExist2 = false;
			} else if (super.getRequestParameter("overTimeNO") != null
					&& !super.getRequestParameter("overTimeNO").equals("")) {
				overTimeNO = super.getRequestParameter("overTimeNO");
				bo = attenceSetUCC.findAttOverTimeRecBObyId(overTimeNO);
				String[] begindate = bo.getBeginTime().split(" ");
				begindatevalue = begindate[0];
				begintimevalue = begindate[1];
				String[] enddate = bo.getEndTime().split(" ");
				enddatevalue = enddate[0];
				endtimevalue = enddate[1];
				kqglLeaverDayValue = bo.getLastDate();
    	    	begindatevalueWdate=bo.getBeginTime();
    	    	enddatevalueWdate=bo.getEndTime();
				typeStatus = bo.getTypeStatus();
				isExist2 = false;
				List list = attenceSetUCC.findAttTimeOffRecBO(overTimeNO);
				if (list != null && list.size() > 0) {
					atttimeoffrecbo = (AttTimeOffRecBO) list.get(0);
					String[] timeoffbegindate = atttimeoffrecbo.getBeginTime()
							.split(" ");
					timeofbegindatevalue = timeoffbegindate[0];
					timeofbegintimevalue = timeoffbegindate[1];
					String[] timeoffenddate = atttimeoffrecbo.getEndTime()
							.split(" ");
					timeoffenddatevalue = timeoffenddate[0];
					timeofendtimevalue = timeoffenddate[1];
					timeoffkqglLeaverDayValue = atttimeoffrecbo.getLastDate();
					timeoffbegindatevalueWdate=atttimeoffrecbo.getBeginTime();
					timeoffenddatevalueWdate=atttimeoffrecbo.getEndTime();
				}
			}
		} catch (Exception e) {

		}
		return pageInit1;
	}

	public void setPageInit1(String pageInit1) {
		this.pageInit1 = pageInit1;
	}

	public String seePersonAddWorkMessage() {
		try {
			groupvalue=attenceSetUCC.getA001737(userid);
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			persBos = attenceSetUCC.getAttAddWorkRecBO(userid, mypage, isExist);
			if (persBos != null && persBos.size() > 0) {
				for (int i = 0; i < persBos.size(); i++) {
					AttOverTimeRecBO attovertimerecbo = (AttOverTimeRecBO) persBos
							.get(i);
					if (attovertimerecbo.getDeptAuditResult() != null
							&& !""
									.equals(attovertimerecbo
											.getDeptAuditResult())) {
						if ("1".equals(attovertimerecbo.getDeptAuditResult())) {
							attovertimerecbo.setDeptAuditCausevalue("同意");
						} else {
							attovertimerecbo.setDeptAuditCausevalue("不同意");
						}
					}
					if (attovertimerecbo.getLeaderAuditResult() != null
							&& !"".equals(attovertimerecbo
									.getLeaderAuditResult())) {
						if ("1".equals(attovertimerecbo.getLeaderAuditResult())) {
							attovertimerecbo.setLeaderAuditCausevalue("同意");
						} else {
							attovertimerecbo.setLeaderAuditCausevalue("不同意");
						}
					}
					if (attovertimerecbo.getHrAuditResult() != null
							&& !"".equals(attovertimerecbo.getHrAuditResult())) {
						if ("1".equals(attovertimerecbo.getHrAuditResult())) {
							attovertimerecbo.setHrAuditResultvalue("同意");
						} else {
							attovertimerecbo.setHrAuditResultvalue("不同意");
						}
					}
					if(attovertimerecbo.getHileaderAuditResult()!=null && !"".equals(attovertimerecbo.getHileaderAuditResult())){
						if("1".equals(attovertimerecbo.getHileaderAuditResult())){
							attovertimerecbo.setHileaderAuditResultvalue("同意");
						}else{
							attovertimerecbo.setHileaderAuditResultvalue("不同意");
						}
					}
					if(attovertimerecbo.getManAuditResult()!=null && !"".equals(attovertimerecbo.getManAuditResult())){
						if("1".equals(attovertimerecbo.getManAuditResult())){
							attovertimerecbo.setManAuditResultvalue("同意");
						}else{
							attovertimerecbo.setManAuditResultvalue("不同意");
						}
					}
					if (attovertimerecbo.getTypeStatus() != null
							&& !"".equals(attovertimerecbo.getTypeStatus())) {
						if ("1".equals(attovertimerecbo.getTypeStatus())) {
							attovertimerecbo.setTypeStatusName("工作日延时");
						} else if ("2".equals(attovertimerecbo.getTypeStatus())) {
							attovertimerecbo.setTypeStatusName("双休日");
						} else if ("3".equals(attovertimerecbo.getTypeStatus())) {
							attovertimerecbo.setTypeStatusName("节假日");
						}
					}
					persBos.set(i, attovertimerecbo);
				}
			}
		} catch (Exception e) {
            e.printStackTrace();
		}
		return "";
	}

	/*
	 * 确认
	 */
	public String makesure() {
		try {
			String[] begindatevalueWdatestrs=begindatevalueWdate.split(" ");
			begindatevalue=begindatevalueWdatestrs[0];
			begintimevalue=begindatevalueWdatestrs[1];
			String[] enddatevalueWdatestrs=enddatevalueWdate.split(" ");
			enddatevalue=enddatevalueWdatestrs[0];
			endtimevalue=enddatevalueWdatestrs[1];
			if ("1".equals(typeStatus)) {
				isExist2 = false;
				if (begindatevalue != null && !"".equals(begindatevalue)
						&& enddatevalue != null && !"".equals(enddatevalue)) {
					DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date date1 = df.parse(begindatevalue + " " + begintimevalue
							+ ":00");
					Date date2 = df.parse(enddatevalue + " " + endtimevalue
							+ ":00");
					if (date1.getTime() <= date2.getTime()) {
						float flvalues = ((float) (date2.getTime() - date1
								.getTime()))
								/ (1000 * 60 * 60 * 8);
						flvalues = (float) (Math.round(flvalues * 100)) / 100;
						float flvalues1=((float) (date2.getTime() - date1
								.getTime()))
								/ (1000 * 60 * 60);
						if (flvalues1>3) {
							kqglLeaverDayValue = "";
							isExist2 = false;
							super.showMessageDetail("延时加班不能超过3个小时！");
							return "";
						}
		       			String oldClassValue=attenceSetUCC.getA001737(userid);
						AttClassBO attclassbo1=attenceSetUCC.changeWork1(userid,superID,oldClassValue,begindatevalue);
						if(attclassbo1!=null){
							if("1".equals(attclassbo1.getClassID())){
								kqglLeaverDayValue = "";
								isExist2 = false;
								super.showMessageDetail("延时加班不得选择休息日内！");
								return "";
							}else if("2".equals(attclassbo1.getClassID())){
								kqglLeaverDayValue = "";
								isExist2 = false;
								super.showMessageDetail("延时加班不得选择在节假日内！");
								return "";
							}else if("3".equals(attclassbo1.getClassID())){
								kqglLeaverDayValue = "";
								isExist2 = false;
								super.showMessageDetail("延时加班不得选择在公休日内！");
								return "";
							}else{
								List attmachineList=attenceSetUCC.getAllAttClassDetailBO1(attclassbo1.getClassID());
								if(attmachineList!=null && attmachineList.size()>=12){
									AttClassDetailBO attclasdetailbo1=(AttClassDetailBO)attmachineList.get(1);
									AttClassDetailBO attclasdetailbo2=(AttClassDetailBO)attmachineList.get(attmachineList.size()-2);
									DateFormat df1 = new SimpleDateFormat("HH:mm");
									Date dateitemBeginTime = df1.parse(attclasdetailbo1.getItemTime());
									Date dateitemEndTime = df1.parse(attclasdetailbo2.getItemTime());
									Date datebegintimevalue = df1.parse(begintimevalue);
									if(datebegintimevalue.getTime()>=dateitemBeginTime.getTime() && datebegintimevalue.getTime()<=dateitemEndTime.getTime()){
										kqglLeaverDayValue = "";
										isExist2 = false;
										super.showMessageDetail("延时加班不得选择在班次时间内！");
										return "";
									}
								}else{
									super.showMessageDetail("请正确设置时段值！");
									return "";
								}
							}
						}else{
							kqglLeaverDayValue = "";
							isExist2 = false;
							super.showMessageDetail("延时加班必须选择在工作日内！");
							return "";
						}

						AttClassBO attclassbo2=attenceSetUCC.changeWork1(userid,superID,oldClassValue,enddatevalue);
						if(attclassbo2!=null){
							if("1".equals(attclassbo2.getClassID())){
								kqglLeaverDayValue = "";
								isExist2 = false;
								super.showMessageDetail("延时加班不得选择休息日内！");
								return "";
							}else if("2".equals(attclassbo2.getClassID())){
								kqglLeaverDayValue = "";
								isExist2 = false;
								super.showMessageDetail("延时加班不得选择在节假日内！");
								return "";
							}else if("3".equals(attclassbo2.getClassID())){
								kqglLeaverDayValue = "";
								isExist2 = false;
								super.showMessageDetail("延时加班不得选择在公休日内！");
								return "";
							}else{
								List attmachineList=attenceSetUCC.getAllAttClassDetailBO1(attclassbo2.getClassID());
								if(attmachineList!=null && attmachineList.size()>=12){
									AttClassDetailBO attclasdetailbo1=(AttClassDetailBO)attmachineList.get(1);
									AttClassDetailBO attclasdetailbo2=(AttClassDetailBO)attmachineList.get(attmachineList.size()-2);
									DateFormat df1 = new SimpleDateFormat("HH:mm");
									Date dateitemBeginTime = df1.parse(attclasdetailbo1.getItemTime());
									Date dateitemEndTime = df1.parse(attclasdetailbo2.getItemTime());
									Date dateendtimevalue = df1.parse(endtimevalue);
									if(dateendtimevalue.getTime()>=dateitemBeginTime.getTime() && dateendtimevalue.getTime()<=dateitemEndTime.getTime()){
										kqglLeaverDayValue = "";
										isExist2 = false;
										super.showMessageDetail("延时加班不得选择在班次时间内！");
										return "";
									}
								}else{
									super.showMessageDetail("请正确设置时段值！");
									return "";
								}
							}
						}else{
							kqglLeaverDayValue = "";
							isExist2 = false;
							super.showMessageDetail("延时加班必须选择在工作日内！");
							return "";
						}
						
						kqglLeaverDayValue = flvalues + "";
						isExist2 = true;
					}else{
						isExist2 = false;
					}
					
				
					if(begindatevalue.equals(enddatevalue)){
						List attovertimelogbos=attenceSetUCC.findAttOverTimeLogBO(userid,begindatevalue);
						if(attovertimelogbos!=null && attovertimelogbos.size()>0){
							float sum=0;
							for(int i=0;i<attovertimelogbos.size();i++){
								AttOverTimeRecBO attovertimelogbo=(AttOverTimeRecBO)attovertimelogbos.get(i);
								String[] begintimes=attovertimelogbo.getBeginTime().split(" ");
								String[] endtimes=attovertimelogbo.getEndTime().split(" ");
								if(begintimes[0].equals(endtimes[0])){
									//sum+=Float.parseFloat(attovertimelogbo.getLastDate());
									Date attovertimelogbo1 = df.parse(attovertimelogbo.getBeginTime()+ ":00");
									Date attovertimelogbo2 = df.parse(attovertimelogbo.getEndTime()+ ":00");
									sum+=((float) (attovertimelogbo2.getTime() - attovertimelogbo1.getTime()))/ (1000 * 60 * 60);
								}else{
									if(begintimes[0].equals(begindatevalue)){
										Date attovertimelogbo1 = df.parse(attovertimelogbo.getBeginTime()+ ":00");
										Date attovertimelogbo2 = df.parse(begindatevalue+" 23:59:59");
										float attovertimelogbo3 = ((float) (attovertimelogbo2.getTime() - attovertimelogbo1.getTime()))/ (1000 * 60 * 60);
										//attovertimelogbo3 = (float) (Math.round(attovertimelogbo3 * 100)) / 100;
										sum+=attovertimelogbo3;
									}else if(endtimes[0].equals(begindatevalue)){
										Date attovertimelogbo1 = df.parse(attovertimelogbo.getEndTime()+ ":00");
										Date attovertimelogbo2 = df.parse(begindatevalue+" 00:00:00");
										float attovertimelogbo3 = ((float) (attovertimelogbo1.getTime() - attovertimelogbo2.getTime()))/ (1000 * 60 * 60);
										//attovertimelogbo3 = (float) (Math.round(attovertimelogbo3 * 100)) / 100;
										sum+=attovertimelogbo3;
									}
								}
							}
							
							float flvalues1=((float) (date2.getTime() - date1.getTime()))/ (1000 * 60 * 60);
							sum=(flvalues1+sum);
							if(sum>3){
								kqglLeaverDayValue = "";
								isExist2 = false;
								super.showMessageDetail(begindatevalue+"日，延时加班累计已经超过3个小时！");
								return "";
							}
						}
					}else{
						List attovertimelogbos=attenceSetUCC.findAttOverTimeLogBO(userid,begindatevalue);
						if(attovertimelogbos!=null && attovertimelogbos.size()>0){
							float sum=0;
							for(int i=0;i<attovertimelogbos.size();i++){
								AttOverTimeRecBO attovertimelogbo=(AttOverTimeRecBO)attovertimelogbos.get(i);
								String[] begintimes=attovertimelogbo.getBeginTime().split(" ");
								String[] endtimes=attovertimelogbo.getEndTime().split(" ");
								if(begintimes[0].equals(endtimes[0])){
									//sum+=Float.parseFloat(attovertimelogbo.getLastDate());
									Date attovertimelogbo1 = df.parse(attovertimelogbo.getBeginTime()+ ":00");
									Date attovertimelogbo2 = df.parse(attovertimelogbo.getEndTime()+ ":00");
									sum+=((float) (attovertimelogbo2.getTime() - attovertimelogbo1.getTime()))/ (1000 * 60 * 60);
								}else{
									if(begintimes[0].equals(begindatevalue)){
										Date attovertimelogbo1 = df.parse(attovertimelogbo.getBeginTime()+ ":00");
										Date attovertimelogbo2 = df.parse(begindatevalue+" 23:59:59");
										float attovertimelogbo3 = ((float) (attovertimelogbo2.getTime() - attovertimelogbo1.getTime()))/ (1000 * 60 * 60);
										//attovertimelogbo3 = (float) (Math.round(attovertimelogbo3 * 100)) / 100;
										sum+=attovertimelogbo3;
									}else if(endtimes[0].equals(begindatevalue)){
										Date attovertimelogbo1 = df.parse(attovertimelogbo.getEndTime()+ ":00");
										Date attovertimelogbo2 = df.parse(begindatevalue+" 00:00:00");
										float attovertimelogbo3 = ((float) (attovertimelogbo1.getTime() - attovertimelogbo2.getTime()))/ (1000 * 60 * 60);
										//attovertimelogbo3 = (float) (Math.round(attovertimelogbo3 * 100)) / 100;
										sum+=attovertimelogbo3;
									}
								}
							}
							
							Date date3 = df.parse(begindatevalue + " 23:59:59");
							float flvalues1=((float) (date3.getTime() - date1.getTime()))/ (1000 * 60 * 60);
							sum=(flvalues1+sum);
							if(sum>3){
								kqglLeaverDayValue = "";
								isExist2 = false;
								super.showMessageDetail(begindatevalue+"日，延时加班累计已经超过3个小时！");
								return "";
							}
						}
						
						List attovertimelogbos1=attenceSetUCC.findAttOverTimeLogBO(userid,enddatevalue);
						if(attovertimelogbos1!=null && attovertimelogbos1.size()>0){
							float sum=0;
							for(int i=0;i<attovertimelogbos1.size();i++){
								AttOverTimeRecBO attovertimelogbo=(AttOverTimeRecBO)attovertimelogbos1.get(i);
								String[] begintimes=attovertimelogbo.getBeginTime().split(" ");
								String[] endtimes=attovertimelogbo.getEndTime().split(" ");
								if(begintimes[0].equals(endtimes[0])){
									//sum+=Float.parseFloat(attovertimelogbo.getLastDate());
									Date attovertimelogbo1 = df.parse(attovertimelogbo.getBeginTime()+ ":00");
									Date attovertimelogbo2 = df.parse(attovertimelogbo.getEndTime()+ ":00");
									sum+=((float) (attovertimelogbo2.getTime() - attovertimelogbo1.getTime()))/ (1000 * 60 * 60);
								}else{
									if(begintimes[0].equals(enddatevalue)){
										Date attovertimelogbo1 = df.parse(attovertimelogbo.getBeginTime()+ ":00");
										Date attovertimelogbo2 = df.parse(enddatevalue+" 23:59:59");
										float attovertimelogbo3 = ((float) (attovertimelogbo2.getTime() - attovertimelogbo1.getTime()))/ (1000 * 60 * 60);
										//attovertimelogbo3 = (float) (Math.round(attovertimelogbo3 * 100)) / 100;
										sum+=attovertimelogbo3;
									}else if(endtimes[0].equals(enddatevalue)){
										Date attovertimelogbo1 = df.parse(attovertimelogbo.getEndTime()+ ":00");
										Date attovertimelogbo2 = df.parse(enddatevalue+" 00:00:00");
										float attovertimelogbo3 = ((float) (attovertimelogbo1.getTime() - attovertimelogbo2.getTime()))/ (1000 * 60 * 60);
										//attovertimelogbo3 = (float) (Math.round(attovertimelogbo3 * 100)) / 100;
										sum+=attovertimelogbo3;
									}
								}
							}
							
							Date date3 = df.parse(enddatevalue + " 00:00:00");
							float flvalues1=((float) (date2.getTime() - date3.getTime()))/ (1000 * 60 * 60);
							sum=(flvalues1+sum);
							if(sum>3){
								kqglLeaverDayValue = "";
								isExist2 = false;
								super.showMessageDetail(enddatevalue+"日，延时加班累计已经超过3个小时！");
								return "";
							}
						}
						
						
//						kqglLeaverDayValue = "";
//						isExist2 = false;
//						super.showMessageDetail("延时加班已经超过3个小时！");
//						return "";
					}
				}
			} else if ("2".equals(typeStatus)) {
				if (begindatevalue != null && !"".equals(begindatevalue)
						&& enddatevalue != null && !"".equals(enddatevalue)) {
					DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date date1 = df.parse(begindatevalue + " " + begintimevalue
							+ ":00");
					Date date2 = df
							.parse(enddatevalue + " " + endtimevalue + ":00");
					if (date1.getTime() <= date2.getTime()) {
					float flvalues = ((float) (date2.getTime() - date1.getTime()))
							/ (1000 * 60 * 60 * 24);
					flvalues = (float) (Math.round(flvalues * 100)) / 100;
					String oldClassValue=attenceSetUCC.getA001737(userid);
					List list = attenceSetUCC.getCaclDay(begindatevalue,enddatevalue);
					if (list != null && list.size() > 0) {
						for (int i = 0; i < list.size(); i++) {
							String day = (String) list.get(i);
							AttClassBO attclassbo1=attenceSetUCC.changeWork1(userid,superID,oldClassValue,day);
							if(!"3".equals(attclassbo1.getClassID())){
								kqglLeaverDayValue = "";
								isExist2 = false;
								super.showMessageDetail("双休日加班应该选择在公休日内！");
								return "";
							}
						}
					}
					kqglLeaverDayValue = flvalues + "";
					isExist2 = true;
					}else{
						isExist2 = false;
					}
				}
			} else if ("3".equals(typeStatus)) {
				if (begindatevalue != null && !"".equals(begindatevalue)
						&& enddatevalue != null && !"".equals(enddatevalue)) {
					DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date date1 = df.parse(begindatevalue + " " + begintimevalue
							+ ":00");
					Date date2 = df
							.parse(enddatevalue + " " + endtimevalue + ":00");
					if (date1.getTime() <= date2.getTime()) {
					float flvalues = ((float) (date2.getTime() - date1.getTime()))
							/ (1000 * 60 * 60 * 24);
					flvalues = (float) (Math.round(flvalues * 100)) / 100;
					String oldClassValue=attenceSetUCC.getA001737(userid);
					List list = attenceSetUCC.getCaclDay(begindatevalue,enddatevalue);
					if (list != null && list.size() > 0) {
						for (int i = 0; i < list.size(); i++) {
							String day = (String) list.get(i);
							AttClassBO attclassbo1=attenceSetUCC.changeWork1(userid,superID,oldClassValue,day);
							if(!"2".equals(attclassbo1.getClassID())){
								kqglLeaverDayValue = "";
								isExist2 = false;
								super.showMessageDetail("节假日加班应该选择在节假日内！");
								return "";
							}
						}
					}
					kqglLeaverDayValue = flvalues + "";
					isExist2 = true;
					}else{
						isExist2 = false;
					}
				}
			}
		} catch (Exception e) {
            e.printStackTrace();
		}
		return "";
	}

	/*
	 * 倒休确认
	 */
	public String makesures() {
		try {
			String[] timeoffbegindatevalueWdates=timeoffbegindatevalueWdate.split(" ");
			timeofbegindatevalue=timeoffbegindatevalueWdates[0];
			timeofbegintimevalue=timeoffbegindatevalueWdates[1];
			String[] timeoffenddatevalueWdates=timeoffenddatevalueWdate.split(" ");
			timeoffenddatevalue=timeoffenddatevalueWdates[0];
			timeofendtimevalue=timeoffenddatevalueWdates[1];
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date1 = df.parse(timeofbegindatevalue + " "
					+ timeofbegintimevalue + ":00");
			Date date2 = df.parse(timeoffenddatevalue + " "
					+ timeofendtimevalue + ":00");
			if (date1.getTime() <= date2.getTime()) {
			float flvalues = ((float) (date2.getTime() - date1.getTime()))
					/ (1000 * 60 * 60 * 24);
			flvalues = (float) (Math.round(flvalues * 100)) / 100;
			String oldClassValue=attenceSetUCC.getA001737(userid);
			List list = attenceSetUCC.getCaclDay(timeofbegindatevalue,timeoffenddatevalue);
			if (list != null && list.size() > 0) {
				for (int i = 0; i < list.size(); i++) {
					String day = (String) list.get(i);
					AttClassBO attclassbo1=attenceSetUCC.changeWork1(userid,superID,oldClassValue,day);
					if("1".equals(attclassbo1.getClassID())){
						isExist2 = false;
						timeoffkqglLeaverDayValue="";
						super.showMessageDetail("倒休不得选择在休息日内！");
						return "";
					}else if("2".equals(attclassbo1.getClassID())){
						isExist2 = false;
						timeoffkqglLeaverDayValue="";
						super.showMessageDetail("倒休不得选择在节假日内！");
						return "";
					}else if("3".equals(attclassbo1.getClassID())){
						isExist2 = false;
						timeoffkqglLeaverDayValue="";
						super.showMessageDetail("倒休不得选择在公休日内！");
						return "";
					}
				}
			}
			timeoffkqglLeaverDayValue = flvalues + "";
			isExist2 = true;
			}else{
				isExist2 = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	/*
	 * 加班申请
	 */
	public String personEvectionMessage() {
		try {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    if(begindatevalue!=null && !"".equals(begindatevalue) && enddatevalue!=null && !"".equals(enddatevalue) && begintimevalue!=null && !"".equals(begintimevalue) && endtimevalue!=null && !"".equals(endtimevalue)){
			Date date1 = df.parse(begindatevalue);
			Date date2 = df.parse(enddatevalue);
			if(date2.getTime()<date1.getTime()){
				super.showMessageDetail("加班的结束日期应该晚于起始日期。");
				return "";
			}
		   if ("2".equals(typeStatus)) {
			 if(timeofbegindatevalue!=null && !"".equals(timeofbegindatevalue) && timeoffenddatevalue!=null && !"".equals(timeoffenddatevalue) && timeofbegintimevalue!=null && !"".equals(timeofbegintimevalue) && timeofendtimevalue!=null && !"".equals(timeofendtimevalue)){
					Date date3 = df.parse(timeofbegindatevalue);
					Date date4 = df.parse(timeoffenddatevalue);
					if(date4.getTime()<date3.getTime()){
						super.showMessageDetail("倒休的结束日期应该晚于起始日期。");
						return "";
					}
					if(date3.getTime()<date2.getTime()){
						super.showMessageDetail("倒休日期应该晚于加班日期。");
						return "";
					}
			    }else{
					super.showMessageDetail("倒休日期不能为空。");
					return "";
			    }
			if (!kqglLeaverDayValue.equals(timeoffkqglLeaverDayValue)) {
				super.showMessageDetail("加班天数必须与倒休天数相一致。");
				return "";
			}
		  }
	    }else{
			super.showMessageDetail("加班日期不能为空。");
			return "";
	    }
		bo.setPersonID(userid);
		bo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
		String begindate = begindatevalue + " " + begintimevalue;
		bo.setBeginTime(begindate);
		String enddate = enddatevalue + " " + endtimevalue;
		bo.setEndTime(enddate);
		bo.setLastDate(kqglLeaverDayValue);
		bo.setStatusValue("-1");
		bo.setTypeStatus(typeStatus);
			attenceSetUCC.saveAttOverTimeRecBO(bo);
			if ("2".equals(typeStatus)) {
				atttimeoffrecbo.setOverTimeNO(bo.getOverTimeNO());
				atttimeoffrecbo.setPersonID(userid);
				atttimeoffrecbo.setApplyDate(CommonFuns
						.getSysDate("yyyy-MM-dd"));
				String begindates = timeofbegindatevalue + " "
						+ timeofbegintimevalue;
				atttimeoffrecbo.setBeginTime(begindates);
				String enddates = timeoffenddatevalue + " "
						+ timeofendtimevalue;
				atttimeoffrecbo.setEndTime(enddates);
				atttimeoffrecbo.setLastDate(timeoffkqglLeaverDayValue);
				atttimeoffrecbo.setStatusValue("-1");
				attenceSetUCC.saveorupdateAttTimeOffRecBO(atttimeoffrecbo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	/*
	 * 报批
	 */
	public String personAddWorkMessageAudit() {
		try {
			if (overTimeNO != null) {
				AttOverTimeRecBO attovertimerecbo = attenceSetUCC
						.findAttOverTimeRecBObyId(overTimeNO);
				attovertimerecbo.setStatusValue("0");
				attenceSetUCC.saveAttOverTimeRecBO(attovertimerecbo);
				WFTransaction wt = new WFTransaction();
				wt.setLinkID(overTimeNO);
				wt.setOperID("0525");
				wt.setUser(super.getUserInfo());
				wt.setWfType(KQGL_ADD_WORK_VALUE);
				wt.setConValue(attovertimerecbo.getLastDate()); // 加班天数
				wt.setStatusValue("0"); // 审批状态
				wt.setWffunction("att_WorkFlowAddWorkService");
				attenceSetUCC.processTrans(wt);
			}
		} catch (Exception e) {
            e.printStackTrace();
		}
		return "";
	}

	/*
	 * 加班申请，并报批。
	 */
	public String personEvectionMessageAndPersonAddWorkMessageAudit() {
		try {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    if(begindatevalue!=null && !"".equals(begindatevalue) && enddatevalue!=null && !"".equals(enddatevalue) && begintimevalue!=null && !"".equals(begintimevalue) && endtimevalue!=null && !"".equals(endtimevalue)){
			Date date1 = df.parse(begindatevalue);
			Date date2 = df.parse(enddatevalue);
			if(date2.getTime()<date1.getTime()){
				super.showMessageDetail("加班的结束日期应该晚于起始日期。");
				return "";
			}
		   if ("2".equals(typeStatus)) {
			 if(timeofbegindatevalue!=null && !"".equals(timeofbegindatevalue) && timeoffenddatevalue!=null && !"".equals(timeoffenddatevalue) && timeofbegintimevalue!=null && !"".equals(timeofbegintimevalue) && timeofendtimevalue!=null && !"".equals(timeofendtimevalue)){
					Date date3 = df.parse(timeofbegindatevalue);
					Date date4 = df.parse(timeoffenddatevalue);
					if(date4.getTime()<date3.getTime()){
						super.showMessageDetail("倒休的结束日期应该晚于起始日期。");
						return "";
					}
					if(date3.getTime()<date2.getTime()){
						super.showMessageDetail("倒休日期应该晚于加班日期。");
						return "";
					}
			    }else{
					super.showMessageDetail("倒休日期不能为空。");
					return "";
			    }
			if (!kqglLeaverDayValue.equals(timeoffkqglLeaverDayValue)) {
				super.showMessageDetail("加班天数必须与倒休天数相一致。");
				return "";
			}
		  }
	    }else{
			super.showMessageDetail("加班日期不能为空。");
			return "";
	    }
		bo.setPersonID(userid);
		bo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
		String begindate = begindatevalue + " " + begintimevalue;
		bo.setBeginTime(begindate);
		String enddate = enddatevalue + " " + endtimevalue;
		bo.setEndTime(enddate);
		bo.setLastDate(kqglLeaverDayValue);
		bo.setStatusValue("-1");
		bo.setTypeStatus(typeStatus);
			attenceSetUCC.saveAttOverTimeRecBO(bo);
			if ("2".equals(typeStatus)) {
				atttimeoffrecbo.setOverTimeNO(bo.getOverTimeNO());
				atttimeoffrecbo.setPersonID(userid);
				atttimeoffrecbo.setApplyDate(CommonFuns
						.getSysDate("yyyy-MM-dd"));
				String begindates = timeofbegindatevalue + " "
						+ timeofbegintimevalue;
				atttimeoffrecbo.setBeginTime(begindates);
				String enddates = timeoffenddatevalue + " "
						+ timeofendtimevalue;
				atttimeoffrecbo.setEndTime(enddates);
				atttimeoffrecbo.setLastDate(timeoffkqglLeaverDayValue);
				atttimeoffrecbo.setStatusValue("-1");
				attenceSetUCC.saveorupdateAttTimeOffRecBO(atttimeoffrecbo);
			}
			
			if (bo.getOverTimeNO() != null) {
				AttOverTimeRecBO attovertimerecbo = attenceSetUCC
						.findAttOverTimeRecBObyId(bo.getOverTimeNO());
				attovertimerecbo.setStatusValue("0");
				attenceSetUCC.saveAttOverTimeRecBO(attovertimerecbo);
				WFTransaction wt = new WFTransaction();
				wt.setLinkID(bo.getOverTimeNO());
				wt.setOperID("0525");
				wt.setUser(super.getUserInfo());
				wt.setWfType(KQGL_ADD_WORK_VALUE);
				wt.setConValue(attovertimerecbo.getLastDate()); // 加班天数
				wt.setStatusValue("0"); // 审批状态
				wt.setWffunction("att_WorkFlowAddWorkService");
				attenceSetUCC.processTrans(wt);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	
	/*
	 * 审批
	 */
	public String personAddWorkAudit() {
		PersonBO person = null;
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			persBos1 = attenceSetUCC.getAttOverTimeRecBO(this.superID, mypage,
					isExist1,operID,deptID,super.getUserInfo());
			if (persBos1 != null && persBos1.size() > 0) {
			  if(isExist1){
				for (int j = 0; j < persBos1.size(); j++) {
					AttOverTimeRecBO attovertimerecbo = (AttOverTimeRecBO) persBos1
							.get(j);
					person = SysCacheTool.findPersonById(attovertimerecbo
							.getPersonID());
					attovertimerecbo.setPersonName(person.getName());
					WFNodeBO currentnode = attenceSetUCC
							.getCurrentNode(attovertimerecbo.getOverTimeNO());
					if (currentnode != null) {
						if (currentnode.getOperID().equals(operID)) {
							attovertimerecbo.setFlagvalue("yes");
						} else {
							attovertimerecbo.setFlagvalue("no");
						}
					}
					persBos2.add(attovertimerecbo);
				}
			  }else{
					for (int j = 0; j < persBos1.size(); j++) {
						AttOverTimeRecBO attovertimerecbo = (AttOverTimeRecBO) persBos1
								.get(j);
						WFNodeBO currentnode = attenceSetUCC
						.getCurrentNode(attovertimerecbo.getOverTimeNO());
				       if (currentnode != null) {
					    if (currentnode.getOperID().equals(operID)) {
						person = SysCacheTool.findPersonById(attovertimerecbo
								.getPersonID());
						attovertimerecbo.setPersonName(person.getName());
						attovertimerecbo.setFlagvalue("yes");
						persBos2.add(attovertimerecbo);
					    }
				       }
					}
			  }
			}
		} catch (Exception e) {
            e.printStackTrace();
		}
		return "";
	}

	public AttOverTimeRecBO getBo1() {
		return bo1;
	}

	public void setBo1(AttOverTimeRecBO bo1) {
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
			if (super.getRequestParameter("overTimeNO") != null
					&& !super.getRequestParameter("overTimeNO").equals("")
					&& super.getRequestParameter("operID") != null
					&& !super.getRequestParameter("operID").equals("")) {
				operID = super.getRequestParameter("operID");
				overTimeNO = super.getRequestParameter("overTimeNO");
				bo1 = attenceSetUCC.findAttOverTimeRecBObyId(overTimeNO);
				String name =SysCacheTool.findPersonById(bo1.getPersonID()).getName();
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
				if(bo1.getHileaderAuditResult()!=null && !"".equals(bo1.getHileaderAuditResult())){
					if("1".equals(bo1.getHileaderAuditResult())){
						bo1.setHileaderAuditResultvalue("同意");
					}else{
						bo1.setHileaderAuditResultvalue("不同意");
					}
				}
				if(bo1.getManAuditResult()!=null && !"".equals(bo1.getManAuditResult())){
					if("1".equals(bo1.getManAuditResult())){
						bo1.setManAuditResultvalue("同意");
					}else{
						bo1.setManAuditResultvalue("不同意");
					}
				}
				if (bo1.getTypeStatus() != null
						&& !"".equals(bo1.getTypeStatus())) {
					if ("1".equals(bo1.getTypeStatus())) {
						bo1.setTypeStatusName("工作延时");
					} else if ("2".equals(bo1.getTypeStatus())) {
						bo1.setTypeStatusName("双休日");
					} else if ("3".equals(bo1.getTypeStatus())) {
						bo1.setTypeStatusName("节假日");
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
	 * 部门经理审批结果
	 */
	public String personAddWorkAudit1() {
		if ("1".equals(status)) {
			bo1.setStatusValue("1");
		} else if ("2".equals(status)) {
			bo1.setStatusValue("2");
		}
		bo1.setDeptAuditResult(status);
		bo1.setDeptAuditOper(personName);
		bo1.setDeptAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try {
			attenceSetUCC.saveAttOverTimeRecBO(bo1);
			WFTransaction wt = new WFTransaction();
			wt.setLinkID(bo1.getOverTimeNO());
			wt.setOperID(operID);
			wt.setUser(super.getUserInfo());
			wt.setWfType(KQGL_ADD_WORK_VALUE);
			wt.setConValue(bo1.getLastDate()); // 加班天数
			wt.setStatusValue(status); // 审批状态
			wt.setWffunction("att_WorkFlowAddWorkService");
			attenceSetUCC.processTrans(wt);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}

	/*
	 * 主管领导审批结果
	 */
	public String personAddWorkAudit2() {
		if ("1".equals(status)) {
			bo1.setStatusValue("1");
		} else if ("2".equals(status)) {
			bo1.setStatusValue("2");
		}
		bo1.setLeaderAuditResult(status);
		bo1.setLeaderAuditOper(personName);
		bo1.setLeaderAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try {
			attenceSetUCC.saveAttOverTimeRecBO(bo1);
			WFTransaction wt = new WFTransaction();
			wt.setLinkID(bo1.getOverTimeNO());
			wt.setOperID(operID);
			wt.setUser(super.getUserInfo());
			wt.setWfType(KQGL_ADD_WORK_VALUE);
			wt.setConValue(bo1.getLastDate()); // 加班天数
			wt.setStatusValue(status); // 审批状态
			wt.setWffunction("att_WorkFlowAddWorkService");
			attenceSetUCC.processTrans(wt);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}

	/*
	 * 人力资源部门审批结果
	 */
	public String personAddWorkAudit3() {
		if ("1".equals(status)) {
			bo1.setStatusValue("3");
		} else if ("2".equals(status)) {
			bo1.setStatusValue("2");
		}
		bo1.setHrAuditResult(status);
		bo1.setHrAuditOper(personName);
		bo1.setHrAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try {
			attenceSetUCC.saveAttOverTimeRecBO(bo1);
			// if("2".equals(status)){
			WFTransaction wt = new WFTransaction();
			wt.setLinkID(bo1.getOverTimeNO());
			// wt.setOperID("0530");
			wt.setOperID(operID);
			wt.setUser(super.getUserInfo());
			wt.setWfType(KQGL_ADD_WORK_VALUE);
			wt.setConValue(bo1.getLastDate()); // 加班天数
			wt.setStatusValue(status); // 审批状态
			wt.setWffunction("att_WorkFlowAddWorkService");
			attenceSetUCC.processTrans(wt);
			// }
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}
	/*
	 *总监审批结果 
	 */
	public String personAddWorkAudit4(){
		if("1".equals(status)){
			bo1.setStatusValue("1");
		}else if("2".equals(status)){
			bo1.setStatusValue("2");
		}
		bo1.setHileaderAuditResult(status);
		bo1.setHileaderAuditOper(personName);
		bo1.setHileaderAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try {
			attenceSetUCC.saveAttOverTimeRecBO(bo1);
			WFTransaction wt = new WFTransaction();
			wt.setLinkID(bo1.getOverTimeNO());
			//wt.setOperID("0530");
			wt.setOperID(operID);
			wt.setUser(super.getUserInfo());
			wt.setWfType(KQGL_ADD_WORK_VALUE);
			wt.setConValue(bo1.getLastDate());  // 加班天数
			wt.setStatusValue(status); //审批状态
			wt.setWffunction("att_WorkFlowAddWorkService");
			attenceSetUCC.processTrans(wt);
			} catch (SysException e) {
				e.printStackTrace();
			}
		return "success";
	}
	/*
	 *总经理审批结果 
	 */
	public String personAddWorkAudit5(){
		if("1".equals(status)){
			bo1.setStatusValue("1");
		}else if("2".equals(status)){
			bo1.setStatusValue("2");
		}
		bo1.setManAuditResult(status);
		bo1.setManAuditOper(personName);
		bo1.setManAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try {
			attenceSetUCC.saveAttOverTimeRecBO(bo1);
			WFTransaction wt = new WFTransaction();
			wt.setLinkID(bo1.getOverTimeNO());
			//wt.setOperID("0530");
			wt.setOperID(operID);
			wt.setUser(super.getUserInfo());
			wt.setWfType(KQGL_ADD_WORK_VALUE);
			wt.setConValue(bo1.getLastDate());  // 加班天数
			wt.setStatusValue(status); //审批状态
			wt.setWffunction("att_WorkFlowAddWorkService");
			attenceSetUCC.processTrans(wt);
			} catch (SysException e) {
				e.printStackTrace();
			}
		return "success";
	}
	public void changeNowYearValue(ValueChangeEvent event) {
		this.isExist = "true".equals(event.getNewValue().toString());
		getPageInit();
	}

	public void changeNowYearValue1(ValueChangeEvent event) {
		this.isExist1 = "true".equals(event.getNewValue().toString());
		getInitEdit();
	}

	public void changeStatus(ValueChangeEvent event) {
		this.status = event.getNewValue().toString();
	}

	public String getTypeStatus() {
		return typeStatus;
	}

	public void setTypeStatus(String typeStatus) {
		this.typeStatus = typeStatus;
	}

	public String getTimeoffenddatevalue() {
		return timeoffenddatevalue;
	}

	public void setTimeoffenddatevalue(String timeoffenddatevalue) {
		this.timeoffenddatevalue = timeoffenddatevalue;
	}

	public String getTimeofendtimevalue() {
		return timeofendtimevalue;
	}

	public void setTimeofendtimevalue(String timeofendtimevalue) {
		this.timeofendtimevalue = timeofendtimevalue;
	}

	public String getTimeofbegindatevalue() {
		return timeofbegindatevalue;
	}

	public void setTimeofbegindatevalue(String timeofbegindatevalue) {
		this.timeofbegindatevalue = timeofbegindatevalue;
	}

	public String getTimeofbegintimevalue() {
		return timeofbegintimevalue;
	}

	public void setTimeofbegintimevalue(String timeofbegintimevalue) {
		this.timeofbegintimevalue = timeofbegintimevalue;
	}

	public String getTimeoffkqglLeaverDayValue() {
		return timeoffkqglLeaverDayValue;
	}

	public void setTimeoffkqglLeaverDayValue(String timeoffkqglLeaverDayValue) {
		this.timeoffkqglLeaverDayValue = timeoffkqglLeaverDayValue;
	}

	public String getTimeInit() {
		if (super.getRequestParameter("overTimeNO") != null
				&& !super.getRequestParameter("overTimeNO").equals("")) {
			overTimeNO = super.getRequestParameter("overTimeNO");
		}
		timeQuery();
		return timeInit;
	}

	public void setTimeInit(String timeInit) {
		this.timeInit = timeInit;
	}

	public List getItemList() {
		return itemList;
	}

	public void setItemList(List itemList) {
		this.itemList = itemList;
	}

	public String timeQuery() {
		if (itemList != null && itemList.size() > 0) {
			itemList = new ArrayList();
		}
		try {
			List list = attenceSetUCC.findAttTimeOffRecBO(overTimeNO);
			if (list != null && list.size() > 0) {
				for (int i = 0; i < list.size(); i++) {
					AttTimeOffRecBO atttimeoffrecbo = (AttTimeOffRecBO) list
							.get(i);
					AttClassGroupVO vo = attenceSetUCC
							.findAttClassGroupVObyId(atttimeoffrecbo
									.getPersonID());
					atttimeoffrecbo.setPersonName(vo.getName());
					itemList.add(atttimeoffrecbo);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public AttTimeOffRecBO getAtttimeoffrecbo() {
		return atttimeoffrecbo;
	}

	public void setAtttimeoffrecbo(AttTimeOffRecBO atttimeoffrecbo) {
		this.atttimeoffrecbo = atttimeoffrecbo;
	}

	public String getGroupvalue() {
		return groupvalue;
	}

	public void setGroupvalue(String groupvalue) {
		this.groupvalue = groupvalue;
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

	public String getTimeoffbegindatevalueWdate() {
		return timeoffbegindatevalueWdate;
	}

	public void setTimeoffbegindatevalueWdate(String timeoffbegindatevalueWdate) {
		this.timeoffbegindatevalueWdate = timeoffbegindatevalueWdate;
	}

	public String getTimeoffenddatevalueWdate() {
		return timeoffenddatevalueWdate;
	}

	public void setTimeoffenddatevalueWdate(String timeoffenddatevalueWdate) {
		this.timeoffenddatevalueWdate = timeoffenddatevalueWdate;
	}

	public String getDeptID() {
		return deptID;
	}

	public void setDeptID(String deptID) {
		this.deptID = deptID;
	}

}
