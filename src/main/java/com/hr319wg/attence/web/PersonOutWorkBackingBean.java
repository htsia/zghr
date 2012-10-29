package com.hr319wg.attence.web;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.attence.pojo.bo.AttClassBO;
import com.hr319wg.attence.pojo.bo.AttOutWorkBO;
import com.hr319wg.attence.pojo.bo.AttOutWorkCollectBO;
import com.hr319wg.attence.pojo.bo.AttTimeOffRecBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.WFNodeBO;
import com.hr319wg.sys.pojo.bo.WFProcessBO;
import com.hr319wg.sys.pojo.vo.WFTransaction;
import com.hr319wg.user.ucc.IUserManageUCC;
import com.hr319wg.util.CommonFuns;

public class PersonOutWorkBackingBean extends BaseBackingBean {
	private IUserManageUCC usermanageucc;
	private String holidayBegin;
	private String holidayEnd;
	private String holidayDaySpan;
	private List persBos3 = new ArrayList();
	private String initEdit2;
	private String status;
	private AttOutWorkBO bo1=new AttOutWorkBO();
	private String initEdit1;
	private String superID = super.getUserInfo().getOrgId();
	private List persBos1;
	private List persBos2 = new ArrayList();
	private String operID;
	private String initEdit;
	private String reason;
	private boolean isExist = false;
	private boolean isExist1 = false;
	private boolean isExist2 = false;
	private boolean isExist3 = false;
	private boolean isExist5 = false;
	private boolean isExist6 = false;
	private AttOutWorkBO bos=new AttOutWorkBO();
	private String flag;
	private String pageInit2;
	private String pageInit1;
	private String enddatevalue;
	private String endtimevalue;
	private String begindatevalue;
	private String begintimevalue;
	private String kqglLeaverDayValue;
	private AttOutWorkBO bo=new AttOutWorkBO();
	private static String KQGL_OUTWORK_VALUE="KQGL_006";
	private String outWorkNo;
	private String personName = super.getUserInfo().getName();
	private static String NORMAL_NAME="正常";
	private static String ADD_FURLOUGHREC_NAME="续增";
	private static String ESC_FURLOUGHREC_NAME="销减";
	private String status1="2";
	private PageVO mypage = new PageVO();
	private List persBos;
	private String pageInit;
	private String userid = super.getUserInfo().getUserId();
	private IAttenceSetUCC attenceSetUCC;
	private String groupvalue;
	private String begindatevalueWdate;
	private String enddatevalueWdate;
	private String deptID = super.getUserInfo().getDeptId();
	private String setStatus="1";
	private List personIdTimeOffList=new ArrayList();
	private String personTimeOffState="0";
	private List listscommon=new ArrayList();
	private String personTimeOffDay="0";
	private String timeoffenddatevalue;
	private String timeofendtimevalue = "23:59";
	private String timeofbegindatevalue;
	private String timeofbegintimevalue = "00:00";
	private String timeoffkqglLeaverDayValue;
	private String timeoffbegindatevalueWdate;
	private String timeoffenddatevalueWdate;
	private String pageInit3;
	private String personIdTimeOff;
	private String personIdTimeOffDay;
	private String personIdTimeOff1;
	private String typeStatus="1";
	private String begindatevalueWdate2;
	private String enddatevalueWdate2;
	private String daySpan1;
	private String begindatevalueWdate3;
	private String enddatevalueWdate3;
	public String first() {
		mypage.setCurrentPage(1);
		seePersonEvcetionMessage();
		return "";
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		seePersonEvcetionMessage();
		return "";
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		seePersonEvcetionMessage();
		return "";
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		seePersonEvcetionMessage();
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
	
	public boolean getIsExist3() {
		return isExist3;
	}

	public void setIsExist3(boolean isExist3) {
		this.isExist3 = isExist3;
	}
	
	public boolean getIsExist5() {
		return isExist5;
	}
	
	public void setIsExist5(boolean isExist5) {
		this.isExist5 = isExist5;
	}
	
	public boolean getIsExist6() {
		return isExist6;
	}
	
	public void setIsExist6(boolean isExist6) {
		this.isExist6 = isExist6;
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

	public String getPageInit() {
		seePersonEvcetionMessage();
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
	
	public String getStatus1() {
		return status1;
	}

	public void setStatus1(String status1) {
		this.status1 = status1;
	}

	public void changeStatus1(ValueChangeEvent event){
		   this.status1 = event.getNewValue().toString();
	}
	
	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
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
	
	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getPageInit1() {
		try{
		    if(super.getRequestParameter("okID") != null
					&& !super.getRequestParameter("okID").equals("")){
                bo=new AttOutWorkBO();
    	    	begindatevalue="";
    	    	begintimevalue="00:00";
    	    	enddatevalue="";
    	    	endtimevalue="23:59";
    	    	kqglLeaverDayValue="";
    	    	begindatevalueWdate="";
    	    	enddatevalueWdate="";
    	    	setStatus="1";
    	    	if("1".equals(setStatus)){
    	    		super.getHttpSession().removeAttribute("perIdListsCommon");
    	    		List list=new ArrayList();
    	    		list.add(userid);
    	    		super.getHttpSession().setAttribute("perIdListsCommon",list);
    	    	}
    	    	super.getHttpSession().removeAttribute("perIdListsCommonhashTable");
    	    	if(personIdTimeOffList!=null && personIdTimeOffList.size()>0){
    	    		personIdTimeOffList=new ArrayList();
    	    	}
    	    	personTimeOffState="0";
		    }else if(super.getRequestParameter("outWorkNo") != null
					&& !super.getRequestParameter("outWorkNo").equals("")){
		    	outWorkNo = super.getRequestParameter("outWorkNo");
				bo=attenceSetUCC.findAttOutWorkBObyId(outWorkNo);
				String[] begindate=bo.getBeginTime().split(" ");
				begindatevalue=begindate[0];
				begintimevalue=begindate[1];
				String[] enddate=bo.getEndTime().split(" ");
				enddatevalue=enddate[0];
				endtimevalue=enddate[1];
				kqglLeaverDayValue=bo.getLastDate();
    	    	begindatevalueWdate=bo.getBeginTime();
    	    	enddatevalueWdate=bo.getEndTime();
    	    	if("1".equals(bo.getOutWorkType())){
    	    		setStatus="1";
    	    		//公出人员信息
    	    		super.getHttpSession().removeAttribute("perIdListsCommon");
    	    		List list=new ArrayList();
    	    		list.add(userid);
    	    		super.getHttpSession().setAttribute("perIdListsCommon",list);
    	    		//公出倒休信息
    	    		super.getHttpSession().removeAttribute("perIdListsCommonhashTable");
    	    		List atttimeoffrecbovalue=null;
    	    		System.out.println("计算 bo.getOutWorkNo()");
    		    	if(bo.getSuperFurloughNo()!=null && !"".equals(bo.getSuperFurloughNo())){
    		    		 System.out.println("计算 bo.getSuperFurloughNo()="+bo.getSuperFurloughNo());
    		    		 atttimeoffrecbovalue=attenceSetUCC.findAttTimeOffRecBO(userid,bo.getSuperFurloughNo());
    		    	}else{
    		    		 System.out.println("计算 bo.getOutWorkNo()="+bo.getOutWorkNo());
                         atttimeoffrecbovalue=attenceSetUCC.findAttTimeOffRecBO(userid,bo.getOutWorkNo());
    		    	}
    		    	System.out.println("计算 atttimeoffrecbovalue");
    	    		if(atttimeoffrecbovalue!=null && atttimeoffrecbovalue.size()>0){
    	    			System.out.println("计算 atttimeoffrecbovalue!=null && atttimeoffrecbovalue.size()>0");
    	    			Hashtable hashTable=new Hashtable();
    	    			for(int i=0;i<atttimeoffrecbovalue.size();i++){
    	    				AttTimeOffRecBO atttimeoffrecbo=(AttTimeOffRecBO)atttimeoffrecbovalue.get(i);
    	               	    String timevalue=atttimeoffrecbo.getBeginTime()+";"+atttimeoffrecbo.getEndTime()+";"+atttimeoffrecbo.getLastDate();
    	               	    personTimeOffDay=atttimeoffrecbo.getLastDate();
    	            	    hashTable.put(atttimeoffrecbo.getPersonID(),timevalue);
    	    			}
    	    			super.getHttpSession().setAttribute("perIdListsCommonhashTable",hashTable);
    	    			personTimeOffState="1";
    	    		}
    	    	}else if("2".equals(bo.getOutWorkType())){
    	    		setStatus="2";
    	    		//公出人员信息
    	    		String ids[]=bo.getPersonGroupID().split(",");
    	    		if(ids!=null){
    	    			super.getHttpSession().removeAttribute("perIdListsCommon");
    	    			List list=new ArrayList();
    	    			for(int i=0;i<ids.length;i++){
    	    				String id=(String)ids[i];
    	    				list.add(id);
    	    			}
    	    			super.getHttpSession().setAttribute("perIdListsCommon",list);
    	    		}
    	    		//公出倒休信息
    	    		super.getHttpSession().removeAttribute("perIdListsCommonhashTable");
    	    		List atttimeoffrecbovalue=attenceSetUCC.findAttTimeOffRecBO(bo.getOutWorkNo());
    	    		if(atttimeoffrecbovalue!=null && atttimeoffrecbovalue.size()>0){
    	    			Hashtable hashTable=new Hashtable();
    	    			for(int i=0;i<atttimeoffrecbovalue.size();i++){
    	    				AttTimeOffRecBO atttimeoffrecbo=(AttTimeOffRecBO)atttimeoffrecbovalue.get(i);
    	               	    String timevalue=atttimeoffrecbo.getBeginTime()+";"+atttimeoffrecbo.getEndTime()+";"+atttimeoffrecbo.getLastDate();
    	               	    personTimeOffDay=atttimeoffrecbo.getLastDate();
    	            	    hashTable.put(atttimeoffrecbo.getPersonID(),timevalue);
    	    			}
    	    			super.getHttpSession().setAttribute("perIdListsCommonhashTable",hashTable);
    	    			personTimeOffState="1";
    	    		}
    	    	}
			}
		    find();
		    find1();
			}catch(Exception e){
				e.printStackTrace();
			}
		return pageInit1;
	}

	public void setPageInit1(String pageInit1) {
		this.pageInit1 = pageInit1;
	}

	public String seePersonEvcetionMessage() {
		try {
			groupvalue=attenceSetUCC.getA001737(userid);
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			if(!"1".equals(status1)){
			persBos = attenceSetUCC.findAttOutWorkBO(userid,mypage,status1);
			if (persBos != null && persBos.size() > 0) {
				for (int i = 0; i < persBos.size(); i++) {
					AttOutWorkBO attoutworkbo = (AttOutWorkBO) persBos
							.get(i);
					String personnamevalue=SysCacheTool.findPersonById(attoutworkbo.getPersonID()).getName();
					attoutworkbo.setPersonName(personnamevalue);
					if(attoutworkbo.getDeptAuditResult()!=null && !"".equals(attoutworkbo.getDeptAuditResult())){
						if("1".equals(attoutworkbo.getDeptAuditResult())){
							attoutworkbo.setDeptAuditCausevalue("同意");
						}else{
							attoutworkbo.setDeptAuditCausevalue("不同意");
						}						
					}
					if(attoutworkbo.getLeaderAuditResult()!=null && !"".equals(attoutworkbo.getLeaderAuditResult())){
						if("1".equals(attoutworkbo.getLeaderAuditResult())){
							attoutworkbo.setLeaderAuditCausevalue("同意");
						}else{
							attoutworkbo.setLeaderAuditCausevalue("不同意");
						}
					}
					if(attoutworkbo.getHrAuditResult()!=null && !"".equals(attoutworkbo.getHrAuditResult())){
						if("1".equals(attoutworkbo.getHrAuditResult())){
							attoutworkbo.setHrAuditResultvalue("同意");
						}else{
							attoutworkbo.setHrAuditResultvalue("不同意");
						}
					}
					if(attoutworkbo.getHileaderAuditResult()!=null && !"".equals(attoutworkbo.getHileaderAuditResult())){
						if("1".equals(attoutworkbo.getHileaderAuditResult())){
							attoutworkbo.setHileaderAuditResultvalue("同意");
						}else{
							attoutworkbo.setHileaderAuditResultvalue("不同意");
						}
					}
					if(attoutworkbo.getManAuditResult()!=null && !"".equals(attoutworkbo.getManAuditResult())){
						if("1".equals(attoutworkbo.getManAuditResult())){
							attoutworkbo.setManAuditResultvalue("同意");
						}else{
							attoutworkbo.setManAuditResultvalue("不同意");
						}
					}
					if(attoutworkbo.getSuperFlId()!=null && !"".equals(attoutworkbo.getSuperFlId())){
                        if("1".equals(attoutworkbo.getSuperFlId())){
                        	attoutworkbo.setSuperFlIdName(this.NORMAL_NAME);
						}else if("2".equals(attoutworkbo.getSuperFlId())){
							attoutworkbo.setSuperFlIdName(this.ADD_FURLOUGHREC_NAME);
						}else if("3".equals(attoutworkbo.getSuperFlId())){
							attoutworkbo.setSuperFlIdName(this.ESC_FURLOUGHREC_NAME);
						}
					}
					if(attoutworkbo.getOutWorkType()!=null && !"".equals(attoutworkbo.getOutWorkType())){
						if("1".equals(attoutworkbo.getOutWorkType())){
							attoutworkbo.setOutWorkTypeName("个人");
						}else if("2".equals(attoutworkbo.getOutWorkType())){
							attoutworkbo.setOutWorkTypeName("集体");
						}
					}
					if(attoutworkbo.getPersonGroupID()!=null && !"".equals(attoutworkbo.getPersonGroupID())){
						String[] persongroupids=attoutworkbo.getPersonGroupID().split(",");
						String personnamevalue1="";
						for(int x=0;x<persongroupids.length;x++){
							String ids=persongroupids[x];
							String personnamevalue2=SysCacheTool.findPersonById(ids).getName();
			        		if(x>0){
			        			personnamevalue1+=","+personnamevalue2;
			        		}else{
			        			personnamevalue1=personnamevalue2;
			        		}
						}
						attoutworkbo.setPersonGroupIDName(personnamevalue1);
					}else{
						attoutworkbo.setPersonGroupIDName(personName);
					}
					persBos.set(i, attoutworkbo);
				}
			}
			}else{
				persBos= attenceSetUCC.getAttOutWorkCollectBO(userid,mypage);
				if (persBos != null && persBos.size() > 0) {
					for (int i = 0; i < persBos.size(); i++) {
						AttOutWorkBO attoutworkbo=new AttOutWorkBO();
						AttOutWorkCollectBO attoutworkcollectbo = (AttOutWorkCollectBO) persBos
								.get(i);
						String personnamevalue=SysCacheTool.findPersonById(attoutworkcollectbo.getPersonID()).getName();
						attoutworkbo.setPersonName("-");
						attoutworkbo.setPersonGroupIDName(personnamevalue);
						attoutworkbo.setOutWorkNoCollectNo(attoutworkcollectbo.getOutWorkCollectNo());
						attoutworkbo.setOutWorkNo(attoutworkcollectbo.getOutWorkNo());
						attoutworkbo.setSuperFlIdName(this.NORMAL_NAME);
						attoutworkbo.setOutWorkTypeName("-");
						attoutworkbo.setApplyDate(attoutworkcollectbo.getCaclDate());
						attoutworkbo.setBeginTime(attoutworkcollectbo.getBeginTime());
						attoutworkbo.setEndTime(attoutworkcollectbo.getEndTime());
						attoutworkbo.setStatusValue(attoutworkcollectbo.getStatusValue());
						attoutworkbo.setSuperFlId(attoutworkcollectbo.getSuperFlId());
						persBos.set(i, attoutworkbo);
					}
				  }
			}
		} catch (Exception e) {
            e.printStackTrace();
		}
		return "";
	}

	public String getOutWorkNo() {
		return outWorkNo;
	}

	public void setOutWorkNo(String outWorkNo) {
		this.outWorkNo = outWorkNo;
	}
	
    public AttOutWorkBO getBo() {
		return bo;
	}

	public void setBo(AttOutWorkBO bo) {
		this.bo = bo;
	}

	
	/*
	 * 确认
	 */
		public String makesure(){
			try{
				String oldClassValue=attenceSetUCC.getA001737(userid);
				String[] begindatevalueWdatestrs=begindatevalueWdate.split(" ");
				begindatevalue=begindatevalueWdatestrs[0];
				begintimevalue=begindatevalueWdatestrs[1];
				String[] enddatevalueWdatestrs=enddatevalueWdate.split(" ");
				enddatevalue=enddatevalueWdatestrs[0];
				endtimevalue=enddatevalueWdatestrs[1];
			if(!begindatevalue.equals(enddatevalue)){
				float sum=0;
				float timeoffday1=0;
				AttClassBO beginattclassbo=attenceSetUCC.changeWork1(userid,superID,oldClassValue,begindatevalue);
				if(beginattclassbo!=null){
					if("1".equals(beginattclassbo.getClassID())){
//						sum+=0;
			            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            Date date1 = df.parse(begindatevalue+" "+begintimevalue + ":00");
			            Date date2 = df.parse(begindatevalue+" 23:59:59");
			            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
			            w = (float) (Math.round(w * 100)) / 100;
						sum+=w;
					}else if("2".equals(beginattclassbo.getClassID())){
//						sum+=0;
			            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            Date date1 = df.parse(begindatevalue+" "+begintimevalue + ":00");
			            Date date2 = df.parse(begindatevalue+" 23:59:59");
			            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
			            w = (float) (Math.round(w * 100)) / 100;
						sum+=w;
					}else if("3".equals(beginattclassbo.getClassID())){
//						sum+=0;
			            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            Date date1 = df.parse(begindatevalue+" "+begintimevalue + ":00");
			            Date date2 = df.parse(begindatevalue+" 23:59:59");
			            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
			            w = (float) (Math.round(w * 100)) / 100;
			            timeoffday1+=w;
						sum+=w;
					}else{
						String str=attenceSetUCC.cacldays(userid,begintimevalue,beginattclassbo);
						float a=Float.parseFloat(str);
						sum+=a;
					}
				}else{
//					sum+=0;
		            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		            Date date1 = df.parse(begindatevalue+" "+begintimevalue + ":00");
		            Date date2 = df.parse(begindatevalue+" 23:59:59");
		            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
		            w = (float) (Math.round(w * 100)) / 100;
					sum+=w;
				}
				
				
				
				List lists=attenceSetUCC.getCaclDay(begindatevalue,enddatevalue);
				if(lists!=null && lists.size()>0){
					for(int i=1;i<lists.size()-1;i++){
						String d=(String)lists.get(i);
						System.out.println("d="+d);
						AttClassBO attclassbo=attenceSetUCC.changeWork1(userid,superID,oldClassValue,d);
						if(attclassbo!=null){
//							if("1".equals(attclassbo.getClassID())){
//								sum+=0;
//							}else if("2".equals(attclassbo.getClassID())){
//								sum+=0;
//							}else if("3".equals(attclassbo.getClassID())){
//								sum+=0;
//							}else{
//								sum+=1;
//							}
							sum+=1;
						}else{
//							sum+=0;
							sum+=1;
						}
					}
				}
				
				AttClassBO beginattclassbo1=attenceSetUCC.changeWork1(userid,superID,oldClassValue,enddatevalue);
				if(beginattclassbo1!=null){
					if("1".equals(beginattclassbo1.getClassID())){
//						sum+=0;
			            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            Date date1 = df.parse(enddatevalue+" 00:00:00");
			            Date date2 = df.parse(enddatevalue+" "+endtimevalue + ":59");
			            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
			            w = (float) (Math.round(w * 100)) / 100;
						sum+=w;
					}else if("2".equals(beginattclassbo1.getClassID())){
//						sum+=0;
			            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            Date date1 = df.parse(enddatevalue+" 00:00:00");
			            Date date2 = df.parse(enddatevalue+" "+endtimevalue + ":59");
			            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
			            w = (float) (Math.round(w * 100)) / 100;
						sum+=w;
					}else if("3".equals(beginattclassbo1.getClassID())){
//						sum+=0;
			            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            Date date1 = df.parse(enddatevalue+" 00:00:00");
			            Date date2 = df.parse(enddatevalue+" "+endtimevalue + ":59");
			            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
			            w = (float) (Math.round(w * 100)) / 100;
			            timeoffday1+=w;
						sum+=w;
					}else{
						String str=attenceSetUCC.cacldays1(userid,endtimevalue,beginattclassbo1);
						float a=Float.parseFloat(str);
						sum+=a;
					}
				}else{
//					sum+=0;
		            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		            Date date1 = df.parse(enddatevalue+" 00:00:00");
		            Date date2 = df.parse(enddatevalue+" "+endtimevalue + ":59");
		            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
		            w = (float) (Math.round(w * 100)) / 100;
					sum+=w;
				}
				
				//时间中包含双休日，倒休天数
				float timeoffday2=0;
				timeoffday2=timeoffday1;
				personTimeOffDay=""+timeoffday2;
				if(Float.parseFloat(personTimeOffDay)>0){
					personTimeOffState="1";
				}else{
					personTimeOffState="0";
				}
				
				//实际天数
				sum = (float) (Math.round(sum * 100)) / 100;
				kqglLeaverDayValue=sum+"";
			}else{
				float sum=0;
				float sum1=0;
				float sum2=0;
				float timeoffday1=0;
				float timeoffday2=0;
				AttClassBO beginattclassbo=attenceSetUCC.changeWork1(userid,superID,oldClassValue,begindatevalue);
				if(beginattclassbo!=null){
					if("1".equals(beginattclassbo.getClassID())){
//						sum1+=0;
			            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            Date date1 = df.parse(begindatevalue+" "+begintimevalue + ":00");
			            Date date2 = df.parse(begindatevalue+" 23:59:59");
			            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
			            w = (float) (Math.round(w * 100)) / 100;
			            sum1+=w;
					}else if("2".equals(beginattclassbo.getClassID())){
//						sum1+=0;
			            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            Date date1 = df.parse(begindatevalue+" "+begintimevalue + ":00");
			            Date date2 = df.parse(begindatevalue+" 23:59:59");
			            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
			            w = (float) (Math.round(w * 100)) / 100;
			            sum1+=w;
					}else if("3".equals(beginattclassbo.getClassID())){
//						sum1+=0;
			            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            Date date1 = df.parse(begindatevalue+" "+begintimevalue + ":00");
			            Date date2 = df.parse(begindatevalue+" 23:59:59");
			            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
			            w = (float) (Math.round(w * 100)) / 100;
			            timeoffday1=w;
			            sum1+=w;
					}else{
						String str=attenceSetUCC.cacldays(userid,begintimevalue,beginattclassbo);
						float a=Float.parseFloat(str);
						sum1+=a;
					}
				}else{
//					sum1+=0;
		            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		            Date date1 = df.parse(begindatevalue+" "+begintimevalue + ":00");
		            Date date2 = df.parse(begindatevalue+" 23:00:00");
		            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
		            w = (float) (Math.round(w * 100)) / 100;
		            sum1+=w;
				}
				
				AttClassBO beginattclassbo1=attenceSetUCC.changeWork1(userid,superID,oldClassValue,enddatevalue);
				if(beginattclassbo1!=null){
					if("1".equals(beginattclassbo1.getClassID())){
//						sum2+=0;
			            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            Date date1 = df.parse(enddatevalue+" "+endtimevalue + ":00");
			            Date date2 = df.parse(enddatevalue+" 23:59:59");
			            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
			            w = (float) (Math.round(w * 100)) / 100;
			            sum2+=w;
					}else if("2".equals(beginattclassbo1.getClassID())){
//						sum2+=0;
			            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            Date date1 = df.parse(enddatevalue+" "+endtimevalue + ":00");
			            Date date2 = df.parse(enddatevalue+" 23:59:59");
			            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
			            w = (float) (Math.round(w * 100)) / 100;
			            sum2+=w;
					}else if("3".equals(beginattclassbo1.getClassID())){
//						sum2+=0;
			            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            Date date1 = df.parse(enddatevalue+" "+endtimevalue + ":00");
			            Date date2 = df.parse(enddatevalue+" 23:59:59");
			            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
			            w = (float) (Math.round(w * 100)) / 100;
			            timeoffday2=w;
			            sum2+=w;
					}else{
						String str=attenceSetUCC.cacldays(userid,endtimevalue,beginattclassbo1);
						float a=Float.parseFloat(str);
						sum2+=a;
					}
				}else{
//					sum2+=0;
		            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		            Date date1 = df.parse(enddatevalue+" "+endtimevalue + ":00");
		            Date date2 = df.parse(enddatevalue+" 23:59:59");
		            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
		            w = (float) (Math.round(w * 100)) / 100;
		            sum2+=w;
				}
				
				//时间中包含双休日，倒休天数
				float timeoffday3=0;
				timeoffday3=timeoffday1-timeoffday2;
				timeoffday3 = (float) (Math.round(timeoffday3 * 100)) / 100;
				personTimeOffDay=""+timeoffday3;
				if(Float.parseFloat(personTimeOffDay)>0){
					personTimeOffState="1";
				}else{
					personTimeOffState="0";
				}
				
				//实际天数
				sum=Math.abs(sum1-sum2);
				sum = (float) (Math.round(sum * 100)) / 100;
				kqglLeaverDayValue=sum+"";
			}
			}catch(Exception e){
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
							isExist3 = false;
							timeoffkqglLeaverDayValue="";
							super.showMessageDetail("倒休不得选择在休息日内！");
							return "";
						}else if("2".equals(attclassbo1.getClassID())){
							isExist3 = false;
							timeoffkqglLeaverDayValue="";
							super.showMessageDetail("倒休不得选择在节假日内！");
							return "";
						}else if("3".equals(attclassbo1.getClassID())){
							isExist3 = false;
							timeoffkqglLeaverDayValue="";
							super.showMessageDetail("倒休不得选择在公休日内！");
							return "";
						}
					}
				}
				
				if(flvalues==Float.parseFloat(personIdTimeOffDay)){
					timeoffkqglLeaverDayValue = flvalues + "";
				}else{
					isExist3 = false;
					timeoffkqglLeaverDayValue="";
					super.showMessageDetail("申请的倒休天数，必须等同于本次公出最大倒休天数！");
					return "";
				}
				
				isExist3 = true;
				}else{
					isExist3 = false;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return "";
		}
		
		/*
		 * 倒休确认
		 */
		public String makesure2() {
			try {
				String[] timeoffbegindatevalueWdates=begindatevalueWdate2.split(" ");
				timeofbegindatevalue=timeoffbegindatevalueWdates[0];
				timeofbegintimevalue=timeoffbegindatevalueWdates[1];
				String[] timeoffenddatevalueWdates=enddatevalueWdate2.split(" ");
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
							daySpan1="";
							super.showMessageDetail("倒休不得选择在休息日内！");
							return "";
						}else if("2".equals(attclassbo1.getClassID())){
							daySpan1="";
							super.showMessageDetail("倒休不得选择在节假日内！");
							return "";
						}else if("3".equals(attclassbo1.getClassID())){
							daySpan1="";
							super.showMessageDetail("倒休不得选择在公休日内！");
							return "";
						}
					}
				}
				    daySpan1=""+flvalues;
				}else{
					daySpan1="";
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return "";
		}
		
	/*
	 *申请公出 
	 */
	public String personEvectionMessage() {
	  try {
		bo.setPersonID(userid);
		bo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
		String begindate=begindatevalue+" "+begintimevalue;
		bo.setBeginTime(begindate);
		String enddate=enddatevalue+" "+endtimevalue;
		bo.setEndTime(enddate);
		bo.setLastDate(kqglLeaverDayValue);
		if(!"2".equals(bo.getSuperFlId()) && !"3".equals(bo.getSuperFlId())){
			bo.setStatusValue("-1");
			bo.setSuperFurloughNo("");
			bo.setSuperFlId("1");
		}
		bo.setOutWorkType(setStatus);
		if("1".equals(setStatus)){
		       bo.setPersonGroupID("");
		       System.out.println("计算 personTimeOffState="+personTimeOffState);
		       if("1".equals(personTimeOffState)){
		    	   System.out.println("计算 个人倒休");
		    	   Hashtable hashTable=(Hashtable)super.getHttpSession().getAttribute("perIdListsCommonhashTable");
		    	   if(hashTable!=null && hashTable.size()>0){
	                   
		    	   }else{
						super.showMessageDetail("请指定共出人员的倒休日期。");
						return "";
		    	   }
		       }
			}else if("2".equals(setStatus)){
				List list=(List)super.getHttpSession().getAttribute("perIdListsCommon");
				if(list!=null && list.size()>0){
					String ids="";
		        	for(int i=0;i<list.size();i++){
		        		String id=(String)list.get(i);
		        		if(i>0){
		        			ids+=","+id;
		        		}else{
		        			ids=id;
		        		}
		        	}
		        	bo.setPersonGroupID(ids);
		           System.out.println("计算 personTimeOffState="+personTimeOffState);
		 	       if("1".equals(personTimeOffState)){
			    	   Hashtable hashTable=(Hashtable)super.getHttpSession().getAttribute("perIdListsCommonhashTable");
			    	   if(hashTable!=null && hashTable.size()>0){
			    		   String ids1="id";
				        	for(int i=0;i<list.size();i++){
				        		String id=(String)list.get(i);
				        		String bos=(String)hashTable.get(id);
				        		if(bos!=null && !"".equals(bos)){
				        			
				        		}else{
	                               ids1+=","+id;
				        		}
				        	}
				        	if(!"id".equals(ids1.trim())){
				        		String[] ids2=ids1.split(",");
				        		String ids3="";
				        		for(int i=0;i<ids2.length;i++){
				        			String personnamevalue=SysCacheTool.findPersonById(ids2[i]).getName();
				        			if(i>0){
				        				ids3+=","+personnamevalue;
				        			}else{
				        				ids3=personnamevalue;
				        			}
				        		}
								super.showMessageDetail("请指定公出人员["+ids3+"]的倒休日期。");
								return "";
				        	}
			    	   }else{
							super.showMessageDetail("请指定公出人员的倒休日期。");
							return "";
			    	   }
			       }
				}else{
					super.showMessageDetail("请选择人员。");
					return "";
				}
			}
		

			if("1".equals(setStatus)){
				   attenceSetUCC.saveAttOutWorkBO(bo);
			       System.out.println("计算 personTimeOffState="+personTimeOffState);
			       if("1".equals(personTimeOffState)){
			    	   System.out.println("计算 个人倒休");
			    	   Hashtable hashTable=(Hashtable)super.getHttpSession().getAttribute("perIdListsCommonhashTable");
			    	   if(hashTable!=null && hashTable.size()>0){
							//Iterator it=hashTable.keySet().iterator();
							//while(it.hasNext()){
								String keyValue=bo.getPersonID().trim();
								String keyValue1=(String)hashTable.get(keyValue);
							 if(keyValue1!=null && !"".equals(keyValue1)){
								List atttimeoffrecbovalue=null;
								if(bo.getSuperFurloughNo()!=null && !"".equals(bo.getSuperFurloughNo())){
									attenceSetUCC.deleteAttTimeOffRecBO2(keyValue,bo.getSuperFurloughNo());
									atttimeoffrecbovalue=attenceSetUCC.findAttTimeOffRecBO1(keyValue,bo.getSuperFurloughNo());
								}else{
									atttimeoffrecbovalue=attenceSetUCC.findAttTimeOffRecBO(keyValue,bo.getOutWorkNo());
								}
						        if(atttimeoffrecbovalue!=null && atttimeoffrecbovalue.size()>0){
						        	AttTimeOffRecBO atttimeoffrecbo =(AttTimeOffRecBO)atttimeoffrecbovalue.get(0);
									if(bo.getSuperFurloughNo()!=null && !"".equals(bo.getSuperFurloughNo())){
										atttimeoffrecbo.setOverTimeNO(bo.getSuperFurloughNo());
									}else{
										atttimeoffrecbo.setOverTimeNO(bo.getOutWorkNo());
									}
									atttimeoffrecbo.setPersonID(keyValue);
									atttimeoffrecbo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
									String[] timevalue=keyValue1.split(";");
									atttimeoffrecbo.setBeginTime(timevalue[0]);
									atttimeoffrecbo.setEndTime(timevalue[1]);
							        atttimeoffrecbo.setLastDate(timevalue[2]);
							        atttimeoffrecbo.setStatusValue("-1");
						        	attenceSetUCC.saveorupdateAttTimeOffRecBO(atttimeoffrecbo);
						        }else{
									AttTimeOffRecBO atttimeoffrecbo = new AttTimeOffRecBO();
									if(bo.getSuperFurloughNo()!=null && !"".equals(bo.getSuperFurloughNo())){
										atttimeoffrecbo.setOverTimeNO(bo.getSuperFurloughNo());
									}else{
										atttimeoffrecbo.setOverTimeNO(bo.getOutWorkNo());
									}
									atttimeoffrecbo.setPersonID(keyValue);
									atttimeoffrecbo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
									String[] timevalue=keyValue1.split(";");
									atttimeoffrecbo.setBeginTime(timevalue[0]);
									atttimeoffrecbo.setEndTime(timevalue[1]);
							        atttimeoffrecbo.setLastDate(timevalue[2]);
							        atttimeoffrecbo.setStatusValue("-1");
						        	attenceSetUCC.saveorupdateAttTimeOffRecBO(atttimeoffrecbo);
						        }
							}
			    	   }
			       }else if("0".equals(personTimeOffState)){
			    	   attenceSetUCC.deleteAttTimeOffRecBO(bo.getOutWorkNo());
			       }
			}else if("2".equals(setStatus)){
				if(bo.getPersonGroupID()!=null && !"".equals(bo.getPersonGroupID())){
					Hashtable hashTable=new Hashtable();
					String[] personidstr=bo.getPersonGroupID().trim().split(",");
					for(int i=0;i<personidstr.length;i++){
						String idstr=(String)personidstr[i];
						String deftIdValue=attenceSetUCC.getFlowProcess(idstr,"att_WorkFlowOutWorkService",KQGL_OUTWORK_VALUE);
						System.out.println("idstr="+idstr);
						System.out.println("getFlowProcess="+deftIdValue);
						String keyValue1=(String)hashTable.get(deftIdValue);
						if(keyValue1!=null && !"".equals(keyValue1)){
							String idstr1=keyValue1+","+idstr;
							hashTable.put(deftIdValue,idstr1);
						}else{
							hashTable.put(deftIdValue,idstr);
						}
					}
					
					if(hashTable!=null && hashTable.size()>0){
						Iterator it=hashTable.keySet().iterator();
						while(it.hasNext()){
							String keyValue=(String)it.next();
							String keyValue1=(String)hashTable.get(keyValue);
							String[] idstr=keyValue1.trim().split(",");
							AttOutWorkBO attoutworkbo=new AttOutWorkBO();
							attoutworkbo.setPersonID(idstr[0]);
							attoutworkbo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
							attoutworkbo.setBeginTime(bo.getBeginTime());
							attoutworkbo.setEndTime(bo.getEndTime());
							attoutworkbo.setLastDate(bo.getLastDate());
							attoutworkbo.setDest(bo.getDest());
							attoutworkbo.setReason(bo.getReason());
							attoutworkbo.setOutWorkType(bo.getOutWorkType());
							attoutworkbo.setPersonGroupID(keyValue1.trim());
							attoutworkbo.setStatusValue("-1");
							attoutworkbo.setSuperFurloughNo("");
							attoutworkbo.setSuperFlId("1");
							attenceSetUCC.saveAttOutWorkBO(attoutworkbo);
							
							for(int i=0;i<idstr.length;i++){
								String idvalue=(String)idstr[i];
								if("1".equals(personTimeOffState)){
							    	   System.out.println("计算 个人倒休");
							    	   Hashtable hashTable1=(Hashtable)super.getHttpSession().getAttribute("perIdListsCommonhashTable");
							    	   if(hashTable1!=null && hashTable1.size()>0){
											//Iterator it=hashTable.keySet().iterator();
											//while(it.hasNext()){
												String idvalue1=idvalue.trim();
												String idvalue2=(String)hashTable1.get(idvalue1);
											 if(idvalue2!=null && !"".equals(idvalue2)){
													AttTimeOffRecBO atttimeoffrecbo = new AttTimeOffRecBO();
												    atttimeoffrecbo.setOverTimeNO(attoutworkbo.getOutWorkNo());
													atttimeoffrecbo.setPersonID(idvalue1);
													atttimeoffrecbo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
													String[] timevalue=idvalue2.split(";");
													atttimeoffrecbo.setBeginTime(timevalue[0]);
													atttimeoffrecbo.setEndTime(timevalue[1]);
											        atttimeoffrecbo.setLastDate(timevalue[2]);
											        atttimeoffrecbo.setStatusValue("-1");
										        	attenceSetUCC.saveorupdateAttTimeOffRecBO(atttimeoffrecbo);
											}
							    	   }
							       }else if("0".equals(personTimeOffState)){
							    	   attenceSetUCC.deleteAttTimeOffRecBO(attoutworkbo.getOutWorkNo());
							       }
								
							}
						}
					}
					 if(bo.getOutWorkNo()!=null && !"".equals(bo.getOutWorkNo())){
						 attenceSetUCC.deleteAttTimeOffRecBO(bo.getOutWorkNo());
						 attenceSetUCC.deleteAttOutWorkBO(bo.getOutWorkNo());
					 }
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}

	/*
     * 报批
     */
	public String personEvectionMessageAudit() {
		try {
			if (outWorkNo != null) {
				AttOutWorkBO attoutworkbo=attenceSetUCC.findAttOutWorkBObyId(outWorkNo);
				attoutworkbo.setStatusValue("0");
				attenceSetUCC.saveAttOutWorkBO(attoutworkbo);
				WFTransaction wt = new WFTransaction();
				wt.setLinkID(outWorkNo);
				wt.setOperID("0525");
				wt.setUser(super.getUserInfo());
				wt.setWfType(KQGL_OUTWORK_VALUE);
				wt.setConValue(attoutworkbo.getLastDate());  //公出天数
				wt.setStatusValue("0"); //审批状态
				wt.setWffunction("att_WorkFlowOutWorkService");
				attenceSetUCC.processTrans(wt);
			}
		} catch (Exception e) {
            e.printStackTrace();
		}
		return "";
	}
	
	/*
	 *申请公出，并报批。 
	 */
	public String personEvectionMessageAndPersonEvectionMessageAudit() {
	  try {
			bo.setPersonID(userid);
			bo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
			String begindate=begindatevalue+" "+begintimevalue;
			bo.setBeginTime(begindate);
			String enddate=enddatevalue+" "+endtimevalue;
			bo.setEndTime(enddate);
			bo.setLastDate(kqglLeaverDayValue);
			if(!"2".equals(bo.getSuperFlId()) && !"3".equals(bo.getSuperFlId())){
				bo.setStatusValue("-1");
				bo.setSuperFurloughNo("");
				bo.setSuperFlId("1");
			}
			bo.setOutWorkType(setStatus);
			if("1".equals(setStatus)){
			       bo.setPersonGroupID("");
			       System.out.println("计算 personTimeOffState="+personTimeOffState);
			       if("1".equals(personTimeOffState)){
			    	   System.out.println("计算 个人倒休");
			    	   Hashtable hashTable=(Hashtable)super.getHttpSession().getAttribute("perIdListsCommonhashTable");
			    	   if(hashTable!=null && hashTable.size()>0){
		                   
			    	   }else{
							super.showMessageDetail("请指定公出人员的倒休日期。");
							return "";
			    	   }
			       }
				}else if("2".equals(setStatus)){
					List list=(List)super.getHttpSession().getAttribute("perIdListsCommon");
					if(list!=null && list.size()>0){
						String ids="";
			        	for(int i=0;i<list.size();i++){
			        		String id=(String)list.get(i);
			        		if(i>0){
			        			ids+=","+id;
			        		}else{
			        			ids=id;
			        		}
			        	}
			        	bo.setPersonGroupID(ids);
			           System.out.println("计算 personTimeOffState="+personTimeOffState);
			 	       if("1".equals(personTimeOffState)){
				    	   Hashtable hashTable=(Hashtable)super.getHttpSession().getAttribute("perIdListsCommonhashTable");
				    	   if(hashTable!=null && hashTable.size()>0){
				    		   String ids1="id";
					        	for(int i=0;i<list.size();i++){
					        		String id=(String)list.get(i);
					        		String bos=(String)hashTable.get(id);
					        		if(bos!=null && !"".equals(bos)){
					        			
					        		}else{
		                               ids1+=","+id;
					        		}
					        	}
					        	if(!"id".equals(ids1.trim())){
					        		String[] ids2=ids1.split(",");
					        		String ids3="";
					        		for(int i=0;i<ids2.length;i++){
					        			String personnamevalue=SysCacheTool.findPersonById(ids2[i]).getName();
					        			if(i>0){
					        				ids3+=","+personnamevalue;
					        			}else{
					        				ids3=personnamevalue;
					        			}
					        		}
									super.showMessageDetail("请指定公出人员["+ids3+"]的倒休日期");
									return "";
					        	}
				    	   }else{
								super.showMessageDetail("请指定公出人员的倒休日期。");
								return "";
				    	   }
				       }
					}else{
						super.showMessageDetail("请选择人员。");
						return "";
					}
				}
			
				if("1".equals(setStatus)){
					   attenceSetUCC.saveAttOutWorkBO(bo);
						if (bo.getOutWorkNo() != null) {
							AttOutWorkBO attoutworkbo=attenceSetUCC.findAttOutWorkBObyId(bo.getOutWorkNo());
							attoutworkbo.setStatusValue("0");
							attenceSetUCC.saveAttOutWorkBO(attoutworkbo);
							WFTransaction wt = new WFTransaction();
							wt.setLinkID(bo.getOutWorkNo());
							wt.setOperID("0525");
							wt.setUser(super.getUserInfo());
							wt.setWfType(KQGL_OUTWORK_VALUE);
							wt.setConValue(attoutworkbo.getLastDate());  //公出天数
							wt.setStatusValue("0"); //审批状态
							wt.setWffunction("att_WorkFlowOutWorkService");
							attenceSetUCC.processTrans(wt);
						}
				       System.out.println("计算 personTimeOffState="+personTimeOffState);
				       if("1".equals(personTimeOffState)){
				    	   System.out.println("计算 个人倒休");
				    	   Hashtable hashTable=(Hashtable)super.getHttpSession().getAttribute("perIdListsCommonhashTable");
				    	   if(hashTable!=null && hashTable.size()>0){
								//Iterator it=hashTable.keySet().iterator();
								//while(it.hasNext()){
									String keyValue=bo.getPersonID().trim();
									String keyValue1=(String)hashTable.get(keyValue);
								 if(keyValue1!=null && !"".equals(keyValue1)){
									List atttimeoffrecbovalue=null;
									if(bo.getSuperFurloughNo()!=null && !"".equals(bo.getSuperFurloughNo())){
										attenceSetUCC.deleteAttTimeOffRecBO2(keyValue,bo.getSuperFurloughNo());
										atttimeoffrecbovalue=attenceSetUCC.findAttTimeOffRecBO1(keyValue,bo.getSuperFurloughNo());
									}else{
										atttimeoffrecbovalue=attenceSetUCC.findAttTimeOffRecBO(keyValue,bo.getOutWorkNo());
									}
							        if(atttimeoffrecbovalue!=null && atttimeoffrecbovalue.size()>0){
							        	AttTimeOffRecBO atttimeoffrecbo =(AttTimeOffRecBO)atttimeoffrecbovalue.get(0);
										if(bo.getSuperFurloughNo()!=null && !"".equals(bo.getSuperFurloughNo())){
											atttimeoffrecbo.setOverTimeNO(bo.getSuperFurloughNo());
										}else{
											atttimeoffrecbo.setOverTimeNO(bo.getOutWorkNo());
										}
										atttimeoffrecbo.setPersonID(keyValue);
										atttimeoffrecbo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
										String[] timevalue=keyValue1.split(";");
										atttimeoffrecbo.setBeginTime(timevalue[0]);
										atttimeoffrecbo.setEndTime(timevalue[1]);
								        atttimeoffrecbo.setLastDate(timevalue[2]);
								        atttimeoffrecbo.setStatusValue("-1");
							        	attenceSetUCC.saveorupdateAttTimeOffRecBO(atttimeoffrecbo);
							        }else{
										AttTimeOffRecBO atttimeoffrecbo = new AttTimeOffRecBO();
										if(bo.getSuperFurloughNo()!=null && !"".equals(bo.getSuperFurloughNo())){
											atttimeoffrecbo.setOverTimeNO(bo.getSuperFurloughNo());
										}else{
											atttimeoffrecbo.setOverTimeNO(bo.getOutWorkNo());
										}
										atttimeoffrecbo.setPersonID(keyValue);
										atttimeoffrecbo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
										String[] timevalue=keyValue1.split(";");
										atttimeoffrecbo.setBeginTime(timevalue[0]);
										atttimeoffrecbo.setEndTime(timevalue[1]);
								        atttimeoffrecbo.setLastDate(timevalue[2]);
								        atttimeoffrecbo.setStatusValue("-1");
							        	attenceSetUCC.saveorupdateAttTimeOffRecBO(atttimeoffrecbo);
							        }
								}
				    	   }
				       }else if("0".equals(personTimeOffState)){
				    	   attenceSetUCC.deleteAttTimeOffRecBO(bo.getOutWorkNo());
				       }
				}else if("2".equals(setStatus)){
					if(bo.getPersonGroupID()!=null && !"".equals(bo.getPersonGroupID())){
						Hashtable hashTable=new Hashtable();
						String[] personidstr=bo.getPersonGroupID().trim().split(",");
						for(int i=0;i<personidstr.length;i++){
							String idstr=(String)personidstr[i];
							String deftIdValue=attenceSetUCC.getFlowProcess(idstr,"att_WorkFlowOutWorkService",KQGL_OUTWORK_VALUE);
							System.out.println("idstr="+idstr);
							System.out.println("getFlowProcess="+deftIdValue);
							String keyValue1=(String)hashTable.get(deftIdValue);
							if(keyValue1!=null && !"".equals(keyValue1)){
								String idstr1=keyValue1+","+idstr;
								hashTable.put(deftIdValue,idstr1);
							}else{
								hashTable.put(deftIdValue,idstr);
							}
						}
						
						if(hashTable!=null && hashTable.size()>0){
							Iterator it=hashTable.keySet().iterator();
							while(it.hasNext()){
								String keyValue=(String)it.next();
								String keyValue1=(String)hashTable.get(keyValue);
								String[] idstr=keyValue1.trim().split(",");
								AttOutWorkBO attoutworkbo=new AttOutWorkBO();
								attoutworkbo.setPersonID(idstr[0]);
								attoutworkbo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
								attoutworkbo.setBeginTime(bo.getBeginTime());
								attoutworkbo.setEndTime(bo.getEndTime());
								attoutworkbo.setLastDate(bo.getLastDate());
								attoutworkbo.setDest(bo.getDest());
								attoutworkbo.setReason(bo.getReason());
								attoutworkbo.setOutWorkType(bo.getOutWorkType());
								attoutworkbo.setPersonGroupID(keyValue1.trim());
								attoutworkbo.setStatusValue("-1");
								attoutworkbo.setSuperFurloughNo("");
								attoutworkbo.setSuperFlId("1");
								attenceSetUCC.saveAttOutWorkBO(attoutworkbo);

								User user=usermanageucc.findUserById(idstr[0]);
								PersonBO pb = SysCacheTool.findPersonById(user.getUserId());
								user.setOrgId(pb.getOrgId());
								user.setDeptId(pb.getDeptId());		
								if (attoutworkbo.getOutWorkNo() != null) {
									AttOutWorkBO attoutworkbo1=attenceSetUCC.findAttOutWorkBObyId(attoutworkbo.getOutWorkNo());
									attoutworkbo1.setStatusValue("0");
									attenceSetUCC.saveAttOutWorkBO(attoutworkbo1);
									WFTransaction wt = new WFTransaction();
									wt.setLinkID(attoutworkbo.getOutWorkNo());
									wt.setOperID("0525");
									wt.setUser(user);
									wt.setWfType(KQGL_OUTWORK_VALUE);
									wt.setConValue(attoutworkbo1.getLastDate());  //公出天数
									wt.setStatusValue("0"); //审批状态
									wt.setWffunction("att_WorkFlowOutWorkService");
									attenceSetUCC.processTrans(wt);
								}
								
								for(int i=0;i<idstr.length;i++){
									String idvalue=(String)idstr[i];
									if("1".equals(personTimeOffState)){
								    	   System.out.println("计算 个人倒休");
								    	   Hashtable hashTable1=(Hashtable)super.getHttpSession().getAttribute("perIdListsCommonhashTable");
								    	   if(hashTable1!=null && hashTable1.size()>0){
												//Iterator it=hashTable.keySet().iterator();
												//while(it.hasNext()){
													String idvalue1=idvalue.trim();
													String idvalue2=(String)hashTable1.get(idvalue1);
												 if(idvalue2!=null && !"".equals(idvalue2)){
														AttTimeOffRecBO atttimeoffrecbo = new AttTimeOffRecBO();
													    atttimeoffrecbo.setOverTimeNO(attoutworkbo.getOutWorkNo());
														atttimeoffrecbo.setPersonID(idvalue1);
														atttimeoffrecbo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
														String[] timevalue=idvalue2.split(";");
														atttimeoffrecbo.setBeginTime(timevalue[0]);
														atttimeoffrecbo.setEndTime(timevalue[1]);
												        atttimeoffrecbo.setLastDate(timevalue[2]);
												        atttimeoffrecbo.setStatusValue("-1");
											        	attenceSetUCC.saveorupdateAttTimeOffRecBO(atttimeoffrecbo);
												}
								    	   }
								       }else if("0".equals(personTimeOffState)){
								    	   attenceSetUCC.deleteAttTimeOffRecBO(attoutworkbo.getOutWorkNo());
								       }
									
								}
							}
						}
						 if(bo.getOutWorkNo()!=null && !"".equals(bo.getOutWorkNo())){
							 attenceSetUCC.deleteAttTimeOffRecBO(bo.getOutWorkNo());
							 attenceSetUCC.deleteAttOutWorkBO(bo.getOutWorkNo());
						 }
					}
				}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}	
	
	/*
	 *审批 
	 */
	public String personEvectionAudit() {
		 PersonBO person=null;
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			persBos1 = attenceSetUCC.getAttOutWorkBO1(this.superID,mypage,isExist1,operID,deptID,super.getUserInfo());
			if (persBos1 != null && persBos1.size() > 0) {
				if(isExist1){
							for (int j = 0; j < persBos1.size(); j++) {
								AttOutWorkBO attoutworkbo1 = (AttOutWorkBO) persBos1
										.get(j);
								person =SysCacheTool.findPersonById(attoutworkbo1.getPersonID());
								attoutworkbo1.setPersonName(person.getName());
								if("3".equals(attoutworkbo1.getStatusValue())){
									attoutworkbo1.setStatusValueName("审批通过");
								}else{
									attoutworkbo1.setStatusValueName("审批中");
								}
								WFNodeBO currentnode = attenceSetUCC
										.getCurrentNode(attoutworkbo1.getOutWorkNo());
								if (currentnode != null) {
									if (currentnode.getOperID().equals(operID)) {
										attoutworkbo1.setFlagvalue("yes");
									} else {
										attoutworkbo1.setFlagvalue("no");
									}
								}
								persBos2.add(attoutworkbo1);
							}
				 }else{
						for (int j = 0; j < persBos1.size(); j++) {
							AttOutWorkBO attoutworkbo1 = (AttOutWorkBO) persBos1
									.get(j);
							WFNodeBO currentnode = attenceSetUCC
							.getCurrentNode(attoutworkbo1.getOutWorkNo());
					       if (currentnode != null) {
						     if (currentnode.getOperID().equals(operID)) {
							person =SysCacheTool.findPersonById(attoutworkbo1.getPersonID());
							attoutworkbo1.setPersonName(person.getName());
							if("3".equals(attoutworkbo1.getStatusValue())){
								attoutworkbo1.setStatusValueName("审批通过");
							}else{
								attoutworkbo1.setStatusValueName("审批中");
							}
                            attoutworkbo1.setFlagvalue("yes");
							persBos2.add(attoutworkbo1);
						     }
					       }
						}
				 }
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "";
	}
	
	/*
	 *部门经理审批结果 
	 */
	public String personEvectionAudit1(){
		if("1".equals(status)){
			bo1.setStatusValue("1");
		}else if("2".equals(status)){
			bo1.setStatusValue("2");
		}
		bo1.setDeptAuditResult(status);
		bo1.setDeptAuditOper(personName);
		bo1.setDeptAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try {
			attenceSetUCC.saveAttOutWorkBO(bo1);
			WFTransaction wt = new WFTransaction();
			wt.setLinkID(bo1.getOutWorkNo());
			//wt.setOperID("0530");
			wt.setOperID(operID);
			wt.setUser(super.getUserInfo());
			wt.setWfType(KQGL_OUTWORK_VALUE);
			wt.setConValue(bo1.getLastDate());  //出差/公出天数
			wt.setStatusValue(status); //审批状态
			wt.setWffunction("att_WorkFlowOutWorkService");
			attenceSetUCC.processTrans(wt);
			} catch (SysException e) {
				e.printStackTrace();
			}
		return "success";
	}
	/*
	 *主管领导审批结果 
	 */
	public String personEvectionAudit2(){
		if("1".equals(status)){
			bo1.setStatusValue("1");
		}else if("2".equals(status)){
			bo1.setStatusValue("2");
		}
		bo1.setLeaderAuditResult(status);
		bo1.setLeaderAuditOper(personName);
		bo1.setLeaderAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try {
			attenceSetUCC.saveAttOutWorkBO(bo1);
			WFTransaction wt = new WFTransaction();
			wt.setLinkID(bo1.getOutWorkNo());
			//wt.setOperID("0530");
			wt.setOperID(operID);
			wt.setUser(super.getUserInfo());
			wt.setWfType(KQGL_OUTWORK_VALUE);
			wt.setConValue(bo1.getLastDate());  //公出天数
			wt.setStatusValue(status); //审批状态
			wt.setWffunction("att_WorkFlowOutWorkService");
			attenceSetUCC.processTrans(wt);
			} catch (SysException e) {
				e.printStackTrace();
			}
		return "success";
	}
	/*
	 *人力资源部门审批结果 
	 */
	public String personEvectionAudit3(){
		if("1".equals(status)){
			bo1.setStatusValue("3");
		}else if("2".equals(status)){
			bo1.setStatusValue("2");
		}
		bo1.setHrAuditResult(status);
		bo1.setHrAuditOper(personName);
		bo1.setHrAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try {
			attenceSetUCC.saveAttOutWorkBO(bo1);
			//if("2".equals(status)){
				WFTransaction wt = new WFTransaction();
				wt.setLinkID(bo1.getOutWorkNo());
				//wt.setOperID("0530");
				wt.setOperID(operID);
				wt.setUser(super.getUserInfo());
				wt.setWfType(KQGL_OUTWORK_VALUE);
				wt.setConValue(bo1.getLastDate());  //公出天数
				wt.setStatusValue(status); //审批状态
				wt.setWffunction("att_WorkFlowOutWorkService");
				attenceSetUCC.processTrans(wt);
			//}
			} catch (SysException e) {
				e.printStackTrace();
			}
		return "success";
	}
	/*
	 *总监审批结果 
	 */
	public String personEvectionAudit4(){
		if("1".equals(status)){
			bo1.setStatusValue("1");
		}else if("2".equals(status)){
			bo1.setStatusValue("2");
		}
		bo1.setHileaderAuditResult(status);
		bo1.setHileaderAuditOper(personName);
		bo1.setHileaderAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try {
			attenceSetUCC.saveAttOutWorkBO(bo1);
			//if("2".equals(status)){
				WFTransaction wt = new WFTransaction();
				wt.setLinkID(bo1.getOutWorkNo());
				//wt.setOperID("0530");
				wt.setOperID(operID);
				wt.setUser(super.getUserInfo());
				wt.setWfType(KQGL_OUTWORK_VALUE);
				wt.setConValue(bo1.getLastDate());  //公出天数
				wt.setStatusValue(status); //审批状态
				wt.setWffunction("att_WorkFlowOutWorkService");
				attenceSetUCC.processTrans(wt);
			//}
			} catch (SysException e) {
				e.printStackTrace();
			}
		return "success";
	}
	/*
	 *总经理审批结果 
	 */
	public String personEvectionAudit5(){
		if("1".equals(status)){
			bo1.setStatusValue("1");
		}else if("2".equals(status)){
			bo1.setStatusValue("2");
		}
		bo1.setManAuditResult(status);
		bo1.setManAuditOper(personName);
		bo1.setManAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try {
			attenceSetUCC.saveAttOutWorkBO(bo1);
			//if("2".equals(status)){
				WFTransaction wt = new WFTransaction();
				wt.setLinkID(bo1.getOutWorkNo());
				//wt.setOperID("0530");
				wt.setOperID(operID);
				wt.setUser(super.getUserInfo());
				wt.setWfType(KQGL_OUTWORK_VALUE);
				wt.setConValue(bo1.getLastDate());  //公出天数
				wt.setStatusValue(status); //审批状态
				wt.setWffunction("att_WorkFlowOutWorkService");
				attenceSetUCC.processTrans(wt);
			//}
			} catch (SysException e) {
				e.printStackTrace();
			}
		return "success";
	}
	public String delete(){
		try{
			if (outWorkNo != null) {
				AttOutWorkBO attevcctionrecbo=attenceSetUCC.findAttOutWorkBObyId(outWorkNo);
				if(attevcctionrecbo.getSuperFurloughNo()!=null && !"".equals(attevcctionrecbo.getSuperFurloughNo())){
					attenceSetUCC.deleteAttTimeOffRecBO2(userid,attevcctionrecbo.getSuperFurloughNo());
				}else{
					attenceSetUCC.deleteAttTimeOffRecBO2(userid,outWorkNo);
				}
				attenceSetUCC.deleteAttOutWorkBO(outWorkNo);
				WFProcessBO wfprocessbo=attenceSetUCC.findWFProcessBO(outWorkNo);
				if(wfprocessbo!=null){
					attenceSetUCC.deleteWFLogBO(wfprocessbo.getProcessID());
					attenceSetUCC.deleteSysInProcessBO(wfprocessbo.getProcessID());
					attenceSetUCC.deleteWFProcessBO(wfprocessbo.getProcessID());
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	/*
	 * 撤销申请
	 */
	public String escdelete(){
		try{
			if (outWorkNo != null) {
				AttOutWorkBO attoutworkbo=attenceSetUCC.findAttOutWorkBObyId(outWorkNo);
				attoutworkbo.setStatusValue("-1");
				attenceSetUCC.saveAttOutWorkBO(attoutworkbo);
				WFProcessBO wfprocessbo=attenceSetUCC.findWFProcessBO(outWorkNo);
				if(wfprocessbo!=null){
					attenceSetUCC.deleteWFLogBO(wfprocessbo.getProcessID());
					attenceSetUCC.deleteSysInProcessBO(wfprocessbo.getProcessID());
					attenceSetUCC.deleteWFProcessBO(wfprocessbo.getProcessID());
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}

	public AttOutWorkBO getBos() {
		return bos;
	}

	public void setBos(AttOutWorkBO bos) {
		this.bos = bos;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getPageInit2() {
		try{
			if(super.getRequestParameter("outWorkNo") != null
					&& !super.getRequestParameter("outWorkNo").equals("") && super.getRequestParameter("flag") != null
					&& !super.getRequestParameter("flag").equals("") && super.getRequestParameter("outWorkNoCollectNo") != null && !super.getRequestParameter("outWorkNoCollectNo").equals("")){
				outWorkNo = super.getRequestParameter("outWorkNo");
				flag= super.getRequestParameter("flag");
				String outWorkNoCollectNo= super.getRequestParameter("outWorkNoCollectNo");
				bo=attenceSetUCC.findAttOutWorkBObyId(outWorkNo);
//				String[] begindate=bos.getBeginTime().split(" ");
//				begindatevalue=begindate[0];
//				begintimevalue=begindate[1];
//				kqglLeaverDayValue=bo.getLastDate();
//				reason=bo.getReason();
				AttOutWorkCollectBO attoutworkcollectbo=attenceSetUCC.findAttOutWorkCollectBObyId(outWorkNoCollectNo);
				if("2".equals(flag)){
					//String[] enddate=attoutworkcollectbo.getEndTime().split(" ");
					//begindatevalue=enddate[0];
					//begintimevalue=enddate[1];
					begindatevalueWdate=attoutworkcollectbo.getEndTime();
					enddatevalueWdate="";
					begindatevalueWdate3=attoutworkcollectbo.getBeginTime();
					enddatevalueWdate3=attoutworkcollectbo.getEndTime();
					kqglLeaverDayValue="";
				}else if("3".equals(flag)){
					begindatevalueWdate="";
					enddatevalueWdate="";
					begindatevalueWdate3=attoutworkcollectbo.getBeginTime();
					enddatevalueWdate3=attoutworkcollectbo.getEndTime();
					kqglLeaverDayValue=bo.getLastDate();
				}else{
					//begindatevalue="";
					//begintimevalue="00:00";
					begindatevalueWdate="";
					enddatevalueWdate="";
				}
				//endtimevalue="23:59";
				
				//公出倒休信息
				typeStatus="1";
				isExist5=false;
	    		begindatevalueWdate2="";
	    		enddatevalueWdate2="";
	    		daySpan1="";	
		        List atttimeoffrecbovalue=attenceSetUCC.findAttTimeOffRecBO(attoutworkcollectbo.getPersonID(),attoutworkcollectbo.getOutWorkNo());
		        if(atttimeoffrecbovalue!=null && atttimeoffrecbovalue.size()>0){
		        	isExist5=true;
		        	AttTimeOffRecBO atttimeoffrecbo =(AttTimeOffRecBO)atttimeoffrecbovalue.get(0);
		    		begindatevalueWdate2=atttimeoffrecbo.getBeginTime();
		    		enddatevalueWdate2=atttimeoffrecbo.getEndTime();
		    		daySpan1=atttimeoffrecbo.getLastDate();
		        }
		        
				//公出历史记录信息
					doQuery();
					isExist2=true;
			}
			}catch(Exception e){
				e.printStackTrace();
			}
		return pageInit2;
	}

	public void setPageInit2(String pageInit2) {
		this.pageInit2 = pageInit2;
	}
	
	/*
	 * 续加、销减。
	 */
	public String PersonEvcctionMessages() {
		try {
		String begindate="";
		String enddate="";
		if(begindatevalue!=null && !"".equals(begindatevalue) && enddatevalue!=null && !"".equals(enddatevalue)){
			begindate=begindatevalue+" "+begintimevalue;
			enddate=enddatevalue+" "+endtimevalue;
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date1 = df.parse(begindate + ":00");
            Date date2 = df.parse(enddate+":00");
            Date date3 = df.parse(begindatevalueWdate3 + ":00");
            Date date4 = df.parse(enddatevalueWdate3+":00");
            if(date1.getTime()<date3.getTime()){
    			super.showMessageDetail("续/销公出的开始时间必须大于等于原始公出的开始时间。");
    			return "";
            }
            if("3".equals(flag)){
                if(date1.getTime()>date4.getTime()){
        			super.showMessageDetail("续/销公出的开始时间必须小于等于原始公出的结束时间。");
        			return "";
                }
                if(date2.getTime()<date3.getTime()){
        			super.showMessageDetail("续/销公出的结束时间必须大于等于原始公出的开始时间。");
        			return "";
                }
                if(date2.getTime()>date4.getTime()){
        			super.showMessageDetail("续/销公出的结束时间必须大于等于原始公出的结束时间。");
        			return "";
                }
            }
		}else{
			super.showMessageDetail("请选择续/销公出时间");
			return "";
		}
		AttOutWorkBO attoutworkbo=new AttOutWorkBO();
		attoutworkbo.setPersonID(userid);
		attoutworkbo.setDest(bo.getDest());
		attoutworkbo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
		attoutworkbo.setBeginTime(begindate);
		attoutworkbo.setEndTime(enddate);
		attoutworkbo.setLastDate(kqglLeaverDayValue);
		attoutworkbo.setReason(reason);
		attoutworkbo.setStatusValue("-1");
		attoutworkbo.setSuperFurloughNo(bo.getOutWorkNo());
		attoutworkbo.setSuperFlId(flag);
		attoutworkbo.setOutWorkType("1");
		
			attenceSetUCC.saveAttOutWorkBO(attoutworkbo);
			if(isExist5){
				if("1".equals(typeStatus)){
					attenceSetUCC.deleteAttTimeOffRecBO2(userid,bo.getOutWorkNo());
				}else if("2".equals(typeStatus)){
					    attenceSetUCC.deleteAttTimeOffRecBO2(userid,bo.getOutWorkNo());
			        	AttTimeOffRecBO atttimeoffrecbo=new AttTimeOffRecBO();
			        	atttimeoffrecbo.setOverTimeNO(bo.getOutWorkNo());
			        	atttimeoffrecbo.setPersonID(userid);
			        	atttimeoffrecbo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
			        	atttimeoffrecbo.setBeginTime(begindatevalueWdate2);
			        	atttimeoffrecbo.setEndTime(enddatevalueWdate2);
			        	atttimeoffrecbo.setLastDate(daySpan1);
			        	atttimeoffrecbo.setStatusValue("-1");
			        	attenceSetUCC.saveorupdateAttTimeOffRecBO(atttimeoffrecbo);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	/*
	 * 续加、销减，并报批。
	 */
	public String PersonEvcctionMessagesAndPersonEvectionMessageAudit() {
	   try {
		String begindate="";
		String enddate="";
		if(begindatevalue!=null && !"".equals(begindatevalue) && enddatevalue!=null && !"".equals(enddatevalue)){
			begindate=begindatevalue+" "+begintimevalue;
			enddate=enddatevalue+" "+endtimevalue;
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date1 = df.parse(begindate + ":00");
            Date date2 = df.parse(enddate+":00");
            Date date3 = df.parse(begindatevalueWdate3 + ":00");
            Date date4 = df.parse(enddatevalueWdate3+":00");
            if(date1.getTime()<date3.getTime()){
    			super.showMessageDetail("续/销公出的开始时间必须大于等于原始公出的开始时间。");
    			return "";
            }
            if("3".equals(flag)){
                if(date1.getTime()>date4.getTime()){
        			super.showMessageDetail("续/销公出的开始时间必须小于等于原始公出的结束时间。");
        			return "";
                }
                if(date2.getTime()<date3.getTime()){
        			super.showMessageDetail("续/销公出的结束时间必须大于等于原始公出的开始时间。");
        			return "";
                }
                if(date2.getTime()>date4.getTime()){
        			super.showMessageDetail("续/销公出的结束时间必须大于等于原始公出的结束时间。");
        			return "";
                }
            }
		}else{
			super.showMessageDetail("请选择公出时间");
			return "";
		}
		AttOutWorkBO attoutworkbo=new AttOutWorkBO();
		attoutworkbo.setPersonID(userid);
		attoutworkbo.setDest(bo.getDest());
		attoutworkbo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
		attoutworkbo.setBeginTime(begindate);
		attoutworkbo.setEndTime(enddate);
		attoutworkbo.setLastDate(kqglLeaverDayValue);
		attoutworkbo.setReason(reason);
		attoutworkbo.setStatusValue("-1");
		attoutworkbo.setSuperFurloughNo(bo.getOutWorkNo());
		attoutworkbo.setSuperFlId(flag);
		attoutworkbo.setOutWorkType("1");
		
			attenceSetUCC.saveAttOutWorkBO(attoutworkbo);
			if(isExist5){
				if("1".equals(typeStatus)){
					attenceSetUCC.deleteAttTimeOffRecBO2(userid,bo.getOutWorkNo());
				}else if("2".equals(typeStatus)){
					    attenceSetUCC.deleteAttTimeOffRecBO2(userid,bo.getOutWorkNo());
			        	AttTimeOffRecBO atttimeoffrecbo=new AttTimeOffRecBO();
			        	atttimeoffrecbo.setOverTimeNO(bo.getOutWorkNo());
			        	atttimeoffrecbo.setPersonID(userid);
			        	atttimeoffrecbo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
			        	atttimeoffrecbo.setBeginTime(begindatevalueWdate2);
			        	atttimeoffrecbo.setEndTime(enddatevalueWdate2);
			        	atttimeoffrecbo.setLastDate(daySpan1);
			        	atttimeoffrecbo.setStatusValue("-1");
			        	attenceSetUCC.saveorupdateAttTimeOffRecBO(atttimeoffrecbo);
				}
			}
			if (attoutworkbo.getOutWorkNo() != null) {
				AttOutWorkBO attoutworkbo1=attenceSetUCC.findAttOutWorkBObyId(attoutworkbo.getOutWorkNo());
				attoutworkbo1.setStatusValue("0");
				attenceSetUCC.saveAttOutWorkBO(attoutworkbo1);
				WFTransaction wt = new WFTransaction();
				wt.setLinkID(attoutworkbo.getOutWorkNo());
				wt.setOperID("0525");
				wt.setUser(super.getUserInfo());
				wt.setWfType(KQGL_OUTWORK_VALUE);
				wt.setConValue(attoutworkbo1.getLastDate());  //公出天数
				wt.setStatusValue("0"); //审批状态
				wt.setWffunction("att_WorkFlowOutWorkService");
				attenceSetUCC.processTrans(wt);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
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
		personEvectionAudit();
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}
	public void changeNowYearValue1(ValueChangeEvent event){
        this.isExist1="true".equals(event.getNewValue().toString());
        getInitEdit();
    }

	public AttOutWorkBO getBo1() {
		return bo1;
	}

	public void setBo1(AttOutWorkBO bo1) {
		this.bo1 = bo1;
	}

	public String getInitEdit1() {
		try {
			if (super.getRequestParameter("outWorkNo") != null
					&& !super.getRequestParameter("outWorkNo").equals("") && super.getRequestParameter("operID") != null
					&& !super.getRequestParameter("operID").equals("")) {
				operID=super.getRequestParameter("operID");
				outWorkNo = super.getRequestParameter("outWorkNo");
				bo1=attenceSetUCC.findAttOutWorkBObyId(outWorkNo);
				String name=SysCacheTool.findPersonById(bo1.getPersonID()).getName();
				String a="";
				//if ("ORACLE".equals(Constants.DB_TYPE)) {
					//a=new String(name.getBytes("iso-8859-1"), "GBK");	
				//}else{
					a=name;
				//}
				bo1.setPersonName(a);
				if(bo1.getDeptAuditResult()!=null && !"".equals(bo1.getDeptAuditResult())){
					if("1".equals(bo1.getDeptAuditResult())){
						bo1.setDeptAuditCausevalue("同意");
					}else{
						bo1.setDeptAuditCausevalue("不同意");
					}						
				}
				if(bo1.getLeaderAuditResult()!=null && !"".equals(bo1.getLeaderAuditResult())){
					if("1".equals(bo1.getLeaderAuditResult())){
						bo1.setLeaderAuditCausevalue("同意");
					}else{
						bo1.setLeaderAuditCausevalue("不同意");
					}
				}
				if(bo1.getHrAuditResult()!=null && !"".equals(bo1.getHrAuditResult())){
					if("1".equals(bo1.getHrAuditResult())){
						bo1.setHrAuditResultvalue("同意");
					}else{
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
				if(bo1.getOutWorkType()!=null && !"".equals(bo1.getOutWorkType())){
					if("1".equals(bo1.getOutWorkType())){
						bo1.setOutWorkTypeName("个人");
					}else if("2".equals(bo1.getOutWorkType())){
						bo1.setOutWorkTypeName("集体");
						if(bo1.getPersonGroupID()!=null && !"".equals(bo1.getPersonGroupID())){
							String[] persongroupids=bo1.getPersonGroupID().split(",");
							String personnamevalue1="";
							for(int x=0;x<persongroupids.length;x++){
								String ids=persongroupids[x];
								String personnamevalue2=SysCacheTool.findPersonById(ids).getName();
				        		if(x>0){
				        			personnamevalue1+=","+personnamevalue2;
				        		}else{
				        			personnamevalue1=personnamevalue2;
				        		}
							}
							bo1.setPersonGroupIDName(personnamevalue1);
						}else{
							bo1.setPersonGroupIDName(bo1.getPersonName());
						}
					}
				}else{
					bo1.setOutWorkTypeName("个人");
				}
				
				//倒休信息
				List list=attenceSetUCC.getAllAttTimeOffRecBO(bo1.getOutWorkNo());
				if(list!=null && list.size()>0){
					AttTimeOffRecBO atttimeoffrecbo=(AttTimeOffRecBO)list.get(0);
					holidayBegin=atttimeoffrecbo.getBeginTime();
					holidayEnd=atttimeoffrecbo.getEndTime();
					holidayDaySpan=atttimeoffrecbo.getLastDate();
					isExist6=true;
				}
				
				//公出历史记录信息
				if(bo1.getSuperFurloughNo()!=null && !"".equals(bo1.getSuperFurloughNo())){
					outWorkNo=bo1.getSuperFurloughNo();
					doQuery();
					isExist2=true;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	public void changeStatus(ValueChangeEvent event){
		   this.status = event.getNewValue().toString();
		}

	public List getPersBos3() {
		return persBos3;
	}

	public void setPersBos3(List persBos3) {
		this.persBos3 = persBos3;
	}

	public String getInitEdit2() {
		if(super.getRequestParameter("outWorkNo") != null
				&& !super.getRequestParameter("outWorkNo").equals("")){
			outWorkNo = super.getRequestParameter("outWorkNo");
		}
		doQuery();
		return initEdit2;
	}

	public void setInitEdit2(String initEdit2) {
		this.initEdit2 = initEdit2;
	}
	public String doQuery(){
		try{
			if(persBos3!=null && persBos3.size()>0){
				persBos3=new ArrayList();
			}
			persBos3 = attenceSetUCC.findAttOutWorkBO(outWorkNo);
			if (persBos3 != null && persBos3.size() > 0) {
				for (int i = 0; i < persBos3.size(); i++) {
					AttOutWorkBO attevcctionrecbo = (AttOutWorkBO) persBos3
							.get(i);
					if(attevcctionrecbo.getDeptAuditResult()!=null && !"".equals(attevcctionrecbo.getDeptAuditResult())){
						if("1".equals(attevcctionrecbo.getDeptAuditResult())){
							attevcctionrecbo.setDeptAuditCausevalue("同意");
						}else{
							attevcctionrecbo.setDeptAuditCausevalue("不同意");
						}						
					}
					if(attevcctionrecbo.getLeaderAuditResult()!=null && !"".equals(attevcctionrecbo.getLeaderAuditResult())){
						if("1".equals(attevcctionrecbo.getLeaderAuditResult())){
							attevcctionrecbo.setLeaderAuditCausevalue("同意");
						}else{
							attevcctionrecbo.setLeaderAuditCausevalue("不同意");
						}
					}
					if(attevcctionrecbo.getHrAuditResult()!=null && !"".equals(attevcctionrecbo.getHrAuditResult())){
						if("1".equals(attevcctionrecbo.getHrAuditResult())){
							attevcctionrecbo.setHrAuditResultvalue("同意");
						}else{
							attevcctionrecbo.setHrAuditResultvalue("不同意");
						}
					}
					if(attevcctionrecbo.getHileaderAuditResult()!=null && !"".equals(attevcctionrecbo.getHileaderAuditResult())){
						if("1".equals(attevcctionrecbo.getHileaderAuditResult())){
							attevcctionrecbo.setHileaderAuditResultvalue("同意");
						}else{
							attevcctionrecbo.setHileaderAuditResultvalue("不同意");
						}
					}
					if(attevcctionrecbo.getManAuditResult()!=null && !"".equals(attevcctionrecbo.getManAuditResult())){
						if("1".equals(attevcctionrecbo.getManAuditResult())){
							attevcctionrecbo.setManAuditResultvalue("同意");
						}else{
							attevcctionrecbo.setManAuditResultvalue("不同意");
						}
					}
					if(attevcctionrecbo.getSuperFlId()!=null && !"".equals(attevcctionrecbo.getSuperFlId())){
                        if("1".equals(attevcctionrecbo.getSuperFlId())){
                        	attevcctionrecbo.setSuperFlIdName(this.NORMAL_NAME);
						}else if("2".equals(attevcctionrecbo.getSuperFlId())){
							attevcctionrecbo.setSuperFlIdName(this.ADD_FURLOUGHREC_NAME);
						}else if("3".equals(attevcctionrecbo.getSuperFlId())){
							attevcctionrecbo.setSuperFlIdName(this.ESC_FURLOUGHREC_NAME);
						}
					}
					persBos3.set(i, attevcctionrecbo);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}

	public void changeSetStatus(ValueChangeEvent event){
		   this.setStatus = event.getNewValue().toString();
	    	if("1".equals(setStatus)){
	    		super.getHttpSession().removeAttribute("perIdListsCommon");
	    		List list=new ArrayList();
	    		list.add(userid);
	    		super.getHttpSession().setAttribute("perIdListsCommon",list);
	    		super.getHttpSession().removeAttribute("perIdListsCommonhashTable");
	    	}else if("2".equals(setStatus)){
	    		super.getHttpSession().removeAttribute("perIdListsCommon");
	    		super.getHttpSession().removeAttribute("perIdListsCommonhashTable");
	    	}
		   
}
	
	public String find(){
		try{
			if(listscommon!=null && listscommon.size()>0){
				listscommon=new ArrayList();
			}
            List list1=(List)super.getHttpSession().getAttribute("perIdListsCommon");
            if(list1!=null && list1.size()>0){
            	for(int i=0;i<list1.size();i++){
            		String id=(String)list1.get(i);
					AttClassGroupVO attclassgroupvo=attenceSetUCC.findAttClassGroupVObyId(id);
					OrgBO a=SysCacheTool.findOrgById(attclassgroupvo.getDeptId());
					attclassgroupvo.setDeptName(a.getName());
					OrgBO b1 = SysCacheTool.findOrgById(attclassgroupvo.getOrgId());
					attclassgroupvo.setOrgName(b1.getName());
					listscommon.add(attclassgroupvo);
            	}
            }
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public String remove(){
		String ids[] = getServletRequest().getParameterValues("selected_ids");
        List list=(List)super.getHttpSession().getAttribute("perIdListsCommon");
        if(list!=null && list.size()>0){
            int i=0;
            while(i<list.size()){
            	String id=(String)list.get(i);
            	if(id!=null && !"".equals(id)){
                  if(ids!=null){
                	  String name="";
                	for(int j=0;j<ids.length;j++){
                		String id1=(String)ids[j];
                		if(id.equals(id1)){
                			name="name";
                		}
                	}
                	if(!"".equals(name)){
                		list.remove(i);
                	}else{
                		i++;
                	}
                }
            	}
            }
        }
        super.getHttpSession().removeAttribute("perIdListsCommon");
        super.getHttpSession().setAttribute("perIdListsCommon",list);
		return "";
	}
	
	public String find1(){
		System.out.println("计算 find1");
		try{
			if(personIdTimeOffList!=null && personIdTimeOffList.size()>0){
				personIdTimeOffList=new ArrayList();
			}
			Hashtable hashTable=(Hashtable)super.getHttpSession().getAttribute("perIdListsCommonhashTable");
			if(hashTable!=null && hashTable.size()>0){
				System.out.println("计算 hashTable");
				Iterator it=hashTable.keySet().iterator();
				while(it.hasNext()){
					String keyValue=(String)it.next();
					String keyValue1=(String)hashTable.get(keyValue);
					AttTimeOffRecBO atttimeoffrecbo = new AttTimeOffRecBO();
					atttimeoffrecbo.setPersonID(keyValue);
					String personnamevalue=SysCacheTool.findPersonById(keyValue).getName();
					atttimeoffrecbo.setPersonName(personnamevalue);
					String[] timevalue=keyValue1.split(";");
					atttimeoffrecbo.setBeginTime(timevalue[0]);
					atttimeoffrecbo.setEndTime(timevalue[1]);
					atttimeoffrecbo.setLastDate(timevalue[2]);
					personIdTimeOffList.add(atttimeoffrecbo);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public String personEvectionMessageTimeOff(){
		System.out.println("计算 personEvectionMessageTimeOff");
		try{
			Hashtable hashTable=(Hashtable)super.getHttpSession().getAttribute("perIdListsCommonhashTable");
			if(hashTable==null){
				hashTable=new Hashtable();
			}
			if(personIdTimeOff1!=null && !"".equals(personIdTimeOff1)){
               String[] personIdTimeOffvalue=personIdTimeOff1.split(",");
               for(int i=0;i<personIdTimeOffvalue.length;i++){
            	 String timevalue=timeoffbegindatevalueWdate+";"+timeoffenddatevalueWdate+";"+timeoffkqglLeaverDayValue;
            	 hashTable.put(personIdTimeOffvalue[i],timevalue);
               }
			}
			//hashTable.put("1", "1");
			super.getHttpSession().setAttribute("perIdListsCommonhashTable",hashTable);
			System.out.println("计算 personEvectionMessageTimeOff hashTable");
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	
	public String getPageInit3() {
		try{
			if (super.getRequestParameter("personIdTimeOff") != null
					&& !super.getRequestParameter("personIdTimeOff").equals("") && super.getRequestParameter("personIdTimeOffDay") != null
					&& !super.getRequestParameter("personIdTimeOffDay").equals("")) {
				String personIdTimeOffvalue=super.getRequestParameter("personIdTimeOff");
				personIdTimeOff1=personIdTimeOffvalue;
				String[] personIdTimeOffvalue1=personIdTimeOffvalue.split(",");
				String personIdTimeOffvalue2="";
				for(int i=0;i<personIdTimeOffvalue1.length;i++){
					String id=personIdTimeOffvalue1[i];
					AttClassGroupVO attclassgroupvo=attenceSetUCC.findAttClassGroupVObyId(id);
					if(i>0){
						personIdTimeOffvalue2+=","+attclassgroupvo.getName();
					}else{
						personIdTimeOffvalue2=attclassgroupvo.getName();
					}
				}
				personIdTimeOff=personIdTimeOffvalue2;
				personIdTimeOffDay=super.getRequestParameter("personIdTimeOffDay");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return pageInit3;
	}

	public void setPageInit3(String pageInit3) {
		this.pageInit3 = pageInit3;
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

	public String getDeptID() {
		return deptID;
	}

	public void setDeptID(String deptID) {
		this.deptID = deptID;
	}

	public String getSetStatus() {
		return setStatus;
	}

	public void setSetStatus(String setStatus) {
		this.setStatus = setStatus;
	}

	public List getPersonIdTimeOffList() {
		return personIdTimeOffList;
	}

	public void setPersonIdTimeOffList(List personIdTimeOffList) {
		this.personIdTimeOffList = personIdTimeOffList;
	}

	public String getPersonTimeOffState() {
		return personTimeOffState;
	}

	public void setPersonTimeOffState(String personTimeOffState) {
		this.personTimeOffState = personTimeOffState;
	}

	public List getListscommon() {
		return listscommon;
	}

	public void setListscommon(List listscommon) {
		this.listscommon = listscommon;
	}

	public String getPersonTimeOffDay() {
		return personTimeOffDay;
	}

	public void setPersonTimeOffDay(String personTimeOffDay) {
		this.personTimeOffDay = personTimeOffDay;
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

	public String getPersonIdTimeOff() {
		return personIdTimeOff;
	}

	public void setPersonIdTimeOff(String personIdTimeOff) {
		this.personIdTimeOff = personIdTimeOff;
	}

	public String getPersonIdTimeOffDay() {
		return personIdTimeOffDay;
	}

	public void setPersonIdTimeOffDay(String personIdTimeOffDay) {
		this.personIdTimeOffDay = personIdTimeOffDay;
	}

	public String getPersonIdTimeOff1() {
		return personIdTimeOff1;
	}

	public void setPersonIdTimeOff1(String personIdTimeOff1) {
		this.personIdTimeOff1 = personIdTimeOff1;
	}

	public String getTypeStatus() {
		return typeStatus;
	}

	public void setTypeStatus(String typeStatus) {
		this.typeStatus = typeStatus;
	}

	public String getBegindatevalueWdate2() {
		return begindatevalueWdate2;
	}

	public void setBegindatevalueWdate2(String begindatevalueWdate2) {
		this.begindatevalueWdate2 = begindatevalueWdate2;
	}

	public String getEnddatevalueWdate2() {
		return enddatevalueWdate2;
	}

	public void setEnddatevalueWdate2(String enddatevalueWdate2) {
		this.enddatevalueWdate2 = enddatevalueWdate2;
	}

	public String getDaySpan1() {
		return daySpan1;
	}

	public void setDaySpan1(String daySpan1) {
		this.daySpan1 = daySpan1;
	}

	public String getBegindatevalueWdate3() {
		return begindatevalueWdate3;
	}

	public void setBegindatevalueWdate3(String begindatevalueWdate3) {
		this.begindatevalueWdate3 = begindatevalueWdate3;
	}

	public String getEnddatevalueWdate3() {
		return enddatevalueWdate3;
	}

	public void setEnddatevalueWdate3(String enddatevalueWdate3) {
		this.enddatevalueWdate3 = enddatevalueWdate3;
	}

	public String getHolidayBegin() {
		return holidayBegin;
	}

	public void setHolidayBegin(String holidayBegin) {
		this.holidayBegin = holidayBegin;
	}

	public String getHolidayEnd() {
		return holidayEnd;
	}

	public void setHolidayEnd(String holidayEnd) {
		this.holidayEnd = holidayEnd;
	}

	public String getHolidayDaySpan() {
		return holidayDaySpan;
	}

	public void setHolidayDaySpan(String holidayDaySpan) {
		this.holidayDaySpan = holidayDaySpan;
	}

	public IUserManageUCC getUsermanageucc() {
		return usermanageucc;
	}

	public void setUsermanageucc(IUserManageUCC usermanageucc) {
		this.usermanageucc = usermanageucc;
	}
	
}
