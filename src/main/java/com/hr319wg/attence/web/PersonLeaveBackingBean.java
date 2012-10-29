package com.hr319wg.attence.web;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.attence.pojo.bo.AttAnnualDetailAuditBO;
import com.hr319wg.attence.pojo.bo.AttAnnualItemBO;
import com.hr319wg.attence.pojo.bo.AttClassBO;
import com.hr319wg.attence.pojo.bo.AttFurloughRecBO;
import com.hr319wg.attence.pojo.bo.AttFurloughRecCollectBO;
import com.hr319wg.attence.pojo.bo.AttfurloughBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.WFNodeBO;
import com.hr319wg.sys.pojo.bo.WFProcessBO;
import com.hr319wg.sys.pojo.vo.WFTransaction;
import com.hr319wg.util.CommonFuns;
 
public class PersonLeaveBackingBean extends BaseBackingBean {
	private String holidayBegin;
	private String holidayEnd;
	private String holidayDaySpan;
	private String status1="2";
	private AttFurloughRecBO bos = new AttFurloughRecBO();
	private List persBos3 = new ArrayList();
	private String initEdit2;
	private String reason;
	private String flag;
	private String pageInit2;
	private static String NORMAL_NAME="请假";
	private static String ADD_FURLOUGHREC_NAME="续假";
	private static String ESC_FURLOUGHREC_NAME="销假";
	private PageVO mypage = new PageVO();
	private boolean isExist = false;
	private boolean isExist1 = false;
	private boolean isExist2 = false;
	private boolean isExist3 = false;
	private boolean isExist4 = true;
	private boolean isExist5 = false;
	private boolean isExist6 = false;
	private String kqglLeaverDayValue;
	private static String KQGL_LEAVE_VALUE="KQGL_001";
	private String pageInit1;
	private List flleavevaluelist=new ArrayList();
	private String flleavevalue;
	private String enddatevalue;
	private String endtimevalue;
	private String begindatevalue;
	private String begintimevalue;
	private String status;
	private AttFurloughRecBO bo1 = new AttFurloughRecBO();
	private String furloughNO;
	private String initEdit1;
	private String operID;
	private List persBos2 = new ArrayList();
	private String superID = super.getUserInfo().getOrgId();
	private List personLists;
	private List persBos1;
	private String initEdit;
	private AttFurloughRecBO bo = new AttFurloughRecBO();
	private IAttenceSetUCC attenceSetUCC;
	private String userid = super.getUserInfo().getUserId();
	private String personName = super.getUserInfo().getName();
	private String pageInit;
	private List persBos;
	private String groupvalue;
	private String begindatevalueWdate;
	private String enddatevalueWdate;
	private String deptID = super.getUserInfo().getDeptId();
	private String typeStatus="1";
	private String dateValue=CommonFuns.getSysDate("yyyy");
	private String avaDay; // 可用天数
	private String criticalAvaDay;// 临界后可用天数
	private String networkholidayvalue;
	private String networkholidayvalue1;
	private String begindatevalueWdate1;
	private String enddatevalueWdate1;
	private String daySpan;
	private String itemIdValue;
	private String begindatevalueWdate2;
	private String enddatevalueWdate2;
	private String daySpan1;
	private String itemIdValue1;
	private String begindatevalueWdate3;
	private String enddatevalueWdate3;
	public String first() {
		mypage.setCurrentPage(1);
		seePersonLeaveMessage();
		return "";
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		seePersonLeaveMessage();
		return "";
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		seePersonLeaveMessage();
		return "";
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		seePersonLeaveMessage();
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
	
	public boolean getIsExist4() {
		return isExist4;
	}
	public void setIsExist4(boolean isExist4) {
		this.isExist4 = isExist4;
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
	
	public String getPageInit1() {
		if(flleavevaluelist!=null){
			flleavevaluelist=new ArrayList();
		}
		try{
	    if(super.getRequestParameter("okID") != null
				&& !super.getRequestParameter("okID").equals("")){
	    	bo = new AttFurloughRecBO();
	    	begindatevalue="";
	    	begintimevalue="00:00";
	    	enddatevalue="";
	    	endtimevalue="23:59";
	    	kqglLeaverDayValue="";
	    	begindatevalueWdate="";
	    	enddatevalueWdate="";
	    }else if(super.getRequestParameter("furloughNO") != null
				&& !super.getRequestParameter("furloughNO").equals("")){
			furloughNO = super.getRequestParameter("furloughNO");
			bo=attenceSetUCC.findAttFurloughRecBObyId(furloughNO);
			flleavevalue=bo.getFlID();
			String[] begindate=bo.getBeginTime().split(" ");
			begindatevalue=begindate[0];
			begintimevalue=begindate[1];
			String[] enddate=bo.getEndTime().split(" ");
			enddatevalue=enddate[0];
			endtimevalue=enddate[1];
			kqglLeaverDayValue=bo.getLastDate();
	    	begindatevalueWdate=bo.getBeginTime();
	    	enddatevalueWdate=bo.getEndTime();
	    	List attannualdetailbovalue=null;
	    	if(bo.getSuperFurloughNo()!=null && !"".equals(bo.getSuperFurloughNo())){
	    		attannualdetailbovalue=attenceSetUCC.getAttAnnualDetailAuditBO(userid,bo.getSuperFurloughNo());
	    	}else{
	    		attannualdetailbovalue=attenceSetUCC.getAttAnnualDetailAuditBO(userid,furloughNO);
	    	}
	    	//List attannualdetailbovalue=attenceSetUCC.getAttAnnualDetailAuditBO(userid,furloughNO);
	    	System.out.println("计算 attannualdetailbovalue");
	    	if(attannualdetailbovalue!=null && attannualdetailbovalue.size()>0){
	    		System.out.println("计算 attannualdetailbovalue!=null && attannualdetailbovalue.size()>0");
				isExist3=true;
				isExist4=true;
	    		AttAnnualDetailAuditBO attannualdetailauditbo=(AttAnnualDetailAuditBO)attannualdetailbovalue.get(0);
	    		begindatevalueWdate1=attannualdetailauditbo.getHolidayBegin();
	    		enddatevalueWdate1=attannualdetailauditbo.getHolidayEnd();
	    		daySpan=attannualdetailauditbo.getDaySpan();
	    		itemIdValue=attannualdetailauditbo.getItemId();
	    	}else{
	    		begindatevalueWdate1=bo.getBeginTime();
	    	}
    		List attannualitembovalue=attenceSetUCC.getAttAnnualItemBO1(userid,dateValue,superID);
    		if(attannualitembovalue!=null && attannualitembovalue.size()>0){
    			AttAnnualItemBO attannualitembo=(AttAnnualItemBO)attannualitembovalue.get(0);
				   if(attannualitembo.getCriticalDate()!=null && !"".equals(attannualitembo.getCriticalDate())){
					   float sum=Float.parseFloat(attannualitembo.getAvaDay())+Float.parseFloat(attannualitembo.getCriticalAvaDay());
					   networkholidayvalue=""+sum;
					   networkholidayvalue1="您可用年假天数为：（临界日期"+attannualitembo.getCriticalDate()+"之前是"+attannualitembo.getAvaDay()+"天，之后是"+attannualitembo.getCriticalAvaDay()+"天） 合计是"+networkholidayvalue+"天";
				   }else{
					   networkholidayvalue=attannualitembo.getAvaDay();
					   networkholidayvalue1="您可用的年假天数是："+networkholidayvalue;
				   }
				   itemIdValue=attannualitembo.getItemID();
    		}else{
    			networkholidayvalue="0";
    		}
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		return pageInit1;
	}

	public void setPageInit1(String pageInit1) {
		this.pageInit1 = pageInit1;
	}

	public List getFlleavevaluelist() {
		doFlleavevaluelist();
		return flleavevaluelist;
	}

	public void setFlleavevaluelist(List flleavevaluelist) {
		this.flleavevaluelist = flleavevaluelist;
	}

	public String getFlleavevalue() {
		return flleavevalue;
	}

	public void setFlleavevalue(String flleavevalue) {
		this.flleavevalue = flleavevalue;
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

	public List getPersonLists() {
		return personLists;
	}

	public void setPersonLists(List personLists) {
		this.personLists = personLists;
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
		personLeaveAudit();
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public AttFurloughRecBO getBo() {
		return bo;
	}

	public void setBo(AttFurloughRecBO bo) {
		this.bo = bo;
	}

	public List getPersBos() {
		return persBos;
	}

	public void setPersBos(List persBos) {
		this.persBos = persBos;
	}

	public String getPageInit() {
		seePersonLeaveMessage();
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

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}
public String doFlleavevaluelist(){
	try {
		List lists=attenceSetUCC.getAllAttfurloughBO();
		if(lists!=null && lists.size()>0){
			for(int i=0;i<lists.size();i++){
				AttfurloughBO  attfurloughbo=(AttfurloughBO)lists.get(i);
				   if(!"06".equals(attfurloughbo.getFlID())){
					   SelectItem si=new  SelectItem();
		               si.setLabel(attfurloughbo.getFlName());
		               si.setValue(attfurloughbo.getFlID());
		               flleavevaluelist.add(si);
				   }
			}
		}
	} catch (Exception e) {

	}
	return "";
}
	
	public String changeflleavevalue(ValueChangeEvent event){
		try{
		   this.flleavevalue = event.getNewValue().toString();
		   if("01".equals(flleavevalue) || "02".equals(flleavevalue)){
			   isExist4=true;
			   List list=attenceSetUCC.getAttAnnualItemBO1(userid,dateValue,superID);
			   if(list!=null && list.size()>0){
				   AttAnnualItemBO attannualitembo=(AttAnnualItemBO)list.get(0);
				   itemIdValue=attannualitembo.getItemID();
				   if(attannualitembo.getCriticalDate()!=null && !"".equals(attannualitembo.getCriticalDate())){
					   float sum=Float.parseFloat(attannualitembo.getAvaDay())+Float.parseFloat(attannualitembo.getCriticalAvaDay());
					   networkholidayvalue=""+sum;
					   networkholidayvalue1="你可用年假天数为：（临界日期"+attannualitembo.getCriticalDate()+"之前是"+attannualitembo.getAvaDay()+"天,之后是"+attannualitembo.getCriticalAvaDay()+"天) 合计是"+networkholidayvalue+"天";
				   }else{
					   networkholidayvalue=attannualitembo.getAvaDay();
					   networkholidayvalue1="你可用年假天数为："+networkholidayvalue;
				   }
			   }else{
					super.showMessageDetail("你无权进行年假抵扣申请操作！");
					return "";
			   }
		   }else{
			   isExist3=false;
			   isExist4=false;
		   }
		   System.out.println("计算 flleavevalue="+flleavevalue);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public String seePersonLeaveMessage() {
		try {
			groupvalue=attenceSetUCC.getA001737(userid);
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			if(!"1".equals(status1)){
			persBos = attenceSetUCC.findAttFurloughRecBO(userid,mypage,status1);
			if (persBos != null && persBos.size() > 0) {
				for (int i = 0; i < persBos.size(); i++) {
					AttFurloughRecBO attfurloughrecbo = (AttFurloughRecBO) persBos
							.get(i);
					AttfurloughBO attfurloughbo1=(AttfurloughBO)attenceSetUCC.findAttfurloughBObyId(attfurloughrecbo.getFlID());
					attfurloughrecbo.setFlName(attfurloughbo1.getFlName());
					AttfurloughBO attfurloughbo2=(AttfurloughBO)attenceSetUCC.findAttfurloughBObyId(attfurloughrecbo.getFlIdProcess());
					attfurloughrecbo.setFlIdProcessName(attfurloughbo2.getFlName());
					if(attfurloughrecbo.getFlIdStatus()!=null && !"".equals(attfurloughrecbo.getFlIdStatus())){
						if("1".equals(attfurloughrecbo.getFlIdStatus())){
							attfurloughrecbo.setFlIdStatusName("是");
						}else{
							attfurloughrecbo.setFlIdStatusName("否");
						}
					}else{
						attfurloughrecbo.setFlIdStatusName("-");
					}
					
					//部门
					if(attfurloughrecbo.getDeptAuditResult()!=null && !"".equals(attfurloughrecbo.getDeptAuditResult())){
						if("1".equals(attfurloughrecbo.getDeptAuditResult())){
							attfurloughrecbo.setDeptAuditCausevalue("同意");
						}else{
							attfurloughrecbo.setDeptAuditCausevalue("不同意");
						}
					}
					//领导
					if(attfurloughrecbo.getLeaderAuditResult()!=null && !"".equals(attfurloughrecbo.getLeaderAuditResult())){
						if("1".equals(attfurloughrecbo.getLeaderAuditResult())){
							attfurloughrecbo.setLeaderAuditCausevalue("同意");
						}else{
							attfurloughrecbo.setLeaderAuditCausevalue("不同意");
						}
					}
					//hr
					if(attfurloughrecbo.getHrAuditResult()!=null && !"".equals(attfurloughrecbo.getHrAuditResult())){
						if("1".equals(attfurloughrecbo.getHrAuditResult())){
							attfurloughrecbo.setHrAuditResultvalue("同意");
						}else{
							attfurloughrecbo.setHrAuditResultvalue("不同意");
						}
					}
					//总监
					if(attfurloughrecbo.getZjAuditResult()!=null && !"".equals(attfurloughrecbo.getZjAuditResult())){
						if("1".equals(attfurloughrecbo.getZjAuditResult())){
							attfurloughrecbo.setZjAuditResultvalue("同意");
						}else{
							attfurloughrecbo.setZjAuditResultvalue("不同意");
						}
					}
					//总经理
					if(attfurloughrecbo.getZjlAuditResult()!=null && !"".equals(attfurloughrecbo.getZjlAuditResult())){
						if("1".equals(attfurloughrecbo.getZjlAuditResult())){
							attfurloughrecbo.setZjlAuditResultvalue("同意");
						}else{
							attfurloughrecbo.setZjlAuditResultvalue("不同意");
						}
					}
					
					
					if(attfurloughrecbo.getSuperFlId()!=null && !"".equals(attfurloughrecbo.getSuperFlId())){
                        if("1".equals(attfurloughrecbo.getSuperFlId())){
							attfurloughrecbo.setSuperFlIdName(this.NORMAL_NAME);
						}else if("2".equals(attfurloughrecbo.getSuperFlId())){
							attfurloughrecbo.setSuperFlIdName(this.ADD_FURLOUGHREC_NAME);
						}else if("3".equals(attfurloughrecbo.getSuperFlId())){
							attfurloughrecbo.setSuperFlIdName(this.ESC_FURLOUGHREC_NAME);
						}
					}
					persBos.set(i, attfurloughrecbo);
				}
			}
			}else{
			persBos= attenceSetUCC.getAttFurloughRecCollectBO(userid,mypage);
			if (persBos != null && persBos.size() > 0) {
			for (int i = 0; i < persBos.size(); i++) {
				AttFurloughRecBO attfurloughrecbo=new AttFurloughRecBO();
				AttFurloughRecCollectBO attfurloughreccollectbo = (AttFurloughRecCollectBO) persBos
						.get(i);
				AttfurloughBO attfurloughbo1=(AttfurloughBO)attenceSetUCC.findAttfurloughBObyId(attfurloughreccollectbo.getFlID());
				attfurloughrecbo.setFlIdProcessName(attfurloughbo1.getFlName());
				AttfurloughBO attfurloughbo2=(AttfurloughBO)attenceSetUCC.findAttfurloughBObyId(attfurloughreccollectbo.getFlIdProcess());
				attfurloughrecbo.setFlName(attfurloughbo2.getFlName());
				if(attfurloughreccollectbo.getFlIdStatus()!=null && !"".equals(attfurloughreccollectbo.getFlIdStatus())){
					if("1".equals(attfurloughreccollectbo.getFlIdStatus())){
						attfurloughrecbo.setFlIdStatusName("是");
					}else{
						attfurloughrecbo.setFlIdStatusName("否");
					}
				}else{
					attfurloughrecbo.setFlIdStatusName("-");
				}
				attfurloughrecbo.setFurloughCollectNO(attfurloughreccollectbo.getFurloughCollectNO());
				attfurloughrecbo.setFurloughNO(attfurloughreccollectbo.getFurloughNO());
				attfurloughrecbo.setSuperFlIdName("-");
				attfurloughrecbo.setApplyDate(attfurloughreccollectbo.getCaclDate());
				attfurloughrecbo.setBeginTime(attfurloughreccollectbo.getBeginTime());
				attfurloughrecbo.setEndTime(attfurloughreccollectbo.getEndTime());
				attfurloughrecbo.setFlID(attfurloughreccollectbo.getFlID());
				attfurloughrecbo.setStatusValue(attfurloughreccollectbo.getStatusValue());
				attfurloughrecbo.setSuperFlId(attfurloughreccollectbo.getSuperFlId());
				persBos.set(i, attfurloughrecbo);
			}
		  }
			}
		} catch (Exception e) {

		}
		return "";
	}
	
	
	public List transForAttFurRcBO(List persBos){
		
		return persBos;
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
			begindatevalueWdate1=begindatevalueWdate;
		if(!begindatevalue.equals(enddatevalue)){
			float sum=0;
			AttClassBO beginattclassbo=attenceSetUCC.changeWork1(userid,superID,oldClassValue,begindatevalue);
			if(beginattclassbo!=null){
				if("1".equals(beginattclassbo.getClassID())){
					if(!"03".equals(flleavevalue)){//区间包括双休日/节假日不计算在内（产假除外）
						sum+=0;
					}else{
			            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            Date date1 = df.parse(begindatevalue+" "+begintimevalue + ":00");
			            Date date2 = df.parse(begindatevalue+" 23:59:59");
			            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
			            w = (float) (Math.round(w * 100)) / 100;
						sum+=w;
					}
				}else if("2".equals(beginattclassbo.getClassID())){
					if(!"03".equals(flleavevalue)){
						sum+=0;	
					}else{
			            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            Date date1 = df.parse(begindatevalue+" "+begintimevalue + ":00");
			            Date date2 = df.parse(begindatevalue+" 23:59:59");
			            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
			            w = (float) (Math.round(w * 100)) / 100;
						sum+=w;
					}
				}else if("3".equals(beginattclassbo.getClassID())){
					if(!"03".equals(flleavevalue)){
						sum+=0;
					}else{
			            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            Date date1 = df.parse(begindatevalue+" "+begintimevalue + ":00");
			            Date date2 = df.parse(begindatevalue+" 23:59:59");
			            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
			            w = (float) (Math.round(w * 100)) / 100;
						sum+=w;
					}
				}else{
					String str=attenceSetUCC.cacldays(userid,begintimevalue,beginattclassbo);
					float a=Float.parseFloat(str);
					sum+=a;
				}
			}else{
				if(!"03".equals(flleavevalue)){
					sum+=0;
				}else{
		            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		            Date date1 = df.parse(begindatevalue+" "+begintimevalue + ":00");
		            Date date2 = df.parse(begindatevalue+" 23:59:59");
		            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
		            w = (float) (Math.round(w * 100)) / 100;
					sum+=w;
				}
			}
			
			
			
			List lists=attenceSetUCC.getCaclDay(begindatevalue,enddatevalue);
			if(lists!=null && lists.size()>0){
				for(int i=1;i<lists.size()-1;i++){
					String d=(String)lists.get(i);
					System.out.println("d="+d);
					AttClassBO attclassbo=attenceSetUCC.changeWork1(userid,superID,oldClassValue,d);
					if(attclassbo!=null){
						if("1".equals(attclassbo.getClassID())){
							if(!"03".equals(flleavevalue)){
								sum+=0;
							}else{
								sum+=1;
							}
						}else if("2".equals(attclassbo.getClassID())){
							if(!"03".equals(flleavevalue)){
								sum+=0;
							}else{
								sum+=1;
							}
						}else if("3".equals(attclassbo.getClassID())){
							if(!"03".equals(flleavevalue)){
								sum+=0;
							}else{
								sum+=1;
							}
						}else{
							sum+=1;
						}
//						sum+=1;
					}else{
						if(!"03".equals(flleavevalue)){
							sum+=0;
						}else{
							sum+=1;
						}
					}
				}
			}
			
			AttClassBO beginattclassbo1=attenceSetUCC.changeWork1(userid,superID,oldClassValue,enddatevalue);
			if(beginattclassbo1!=null){
				if("1".equals(beginattclassbo1.getClassID())){
					if(!"03".equals(flleavevalue)){
						sum+=0;
					}else{
			            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            Date date1 = df.parse(enddatevalue+" 00:00:00");
			            Date date2 = df.parse(enddatevalue+" "+endtimevalue + ":59");
			            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
			            w = (float) (Math.round(w * 100)) / 100;
						sum+=w;
					}
				}else if("2".equals(beginattclassbo1.getClassID())){
					if(!"03".equals(flleavevalue)){
						sum+=0;
					}else{
			            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            Date date1 = df.parse(enddatevalue+" 00:00:00");
			            Date date2 = df.parse(enddatevalue+" "+endtimevalue + ":59");
			            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
			            w = (float) (Math.round(w * 100)) / 100;
						sum+=w;
					}
				}else if("3".equals(beginattclassbo1.getClassID())){
					if(!"03".equals(flleavevalue)){
						sum+=0;
					}else{
			            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            Date date1 = df.parse(enddatevalue+" 00:00:00");
			            Date date2 = df.parse(enddatevalue+" "+endtimevalue + ":59");
			            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
			            w = (float) (Math.round(w * 100)) / 100;
						sum+=w;
					}
				}else{
					String str=attenceSetUCC.cacldays1(userid,endtimevalue,beginattclassbo1);
					float a=Float.parseFloat(str);
					sum+=a;
				}
			}else{
				if(!"03".equals(flleavevalue)){
					sum+=0;
				}else{
		            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		            Date date1 = df.parse(enddatevalue+" 00:00:00");
		            Date date2 = df.parse(enddatevalue+" "+endtimevalue + ":59");
		            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
		            w = (float) (Math.round(w * 100)) / 100;
					sum+=w;
				}
			}
			
			sum = (float) (Math.round(sum * 100)) / 100;
			kqglLeaverDayValue=sum+"";
		}else{
			float sum=0;
			float sum1=0;
			float sum2=0;
			AttClassBO beginattclassbo=attenceSetUCC.changeWork1(userid,superID,oldClassValue,begindatevalue);
			if(beginattclassbo!=null){
				if("1".equals(beginattclassbo.getClassID())){
					if(!"03".equals(flleavevalue)){
						sum1+=0;
					}else{
			            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            Date date1 = df.parse(begindatevalue+" "+begintimevalue + ":00");
			            Date date2 = df.parse(begindatevalue+" 23:59:59");
			            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
			            w = (float) (Math.round(w * 100)) / 100;
			            sum1+=w;
					}
				}else if("2".equals(beginattclassbo.getClassID())){
					if(!"03".equals(flleavevalue)){
						sum1+=0;
					}else{
			            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            Date date1 = df.parse(begindatevalue+" "+begintimevalue + ":00");
			            Date date2 = df.parse(begindatevalue+" 23:59:59");
			            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
			            w = (float) (Math.round(w * 100)) / 100;
			            sum1+=w;
					}
				}else if("3".equals(beginattclassbo.getClassID())){
					if(!"03".equals(flleavevalue)){
						sum1+=0;
					}else{
			            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            Date date1 = df.parse(begindatevalue+" "+begintimevalue + ":00");
			            Date date2 = df.parse(begindatevalue+" 23:59:59");
			            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
			            w = (float) (Math.round(w * 100)) / 100;
			            sum1+=w;
					}
				}else{
					String str=attenceSetUCC.cacldays(userid,begintimevalue,beginattclassbo);
					float a=Float.parseFloat(str);
					sum1+=a;
				}
			}else{
				if(!"03".equals(flleavevalue)){
					sum1+=0;
				}else{
		            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		            Date date1 = df.parse(begindatevalue+" "+begintimevalue + ":00");
		            Date date2 = df.parse(begindatevalue+" 23:00:00");
		            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
		            w = (float) (Math.round(w * 100)) / 100;
		            sum1+=w;
				}
			}
			
			AttClassBO beginattclassbo1=attenceSetUCC.changeWork1(userid,superID,oldClassValue,enddatevalue);
			if(beginattclassbo1!=null){
				if("1".equals(beginattclassbo1.getClassID())){
					if(!"03".equals(flleavevalue)){
						sum2+=0;
					}else{
			            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            Date date1 = df.parse(enddatevalue+" "+endtimevalue + ":00");
			            Date date2 = df.parse(enddatevalue+" 23:59:59");
			            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
			            w = (float) (Math.round(w * 100)) / 100;
			            sum2+=w;
					}
				}else if("2".equals(beginattclassbo1.getClassID())){
					if(!"03".equals(flleavevalue)){
						sum2+=0;
					}else{
			            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            Date date1 = df.parse(enddatevalue+" "+endtimevalue + ":00");
			            Date date2 = df.parse(enddatevalue+" 23:59:59");
			            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
			            w = (float) (Math.round(w * 100)) / 100;
			            sum2+=w;
					}
				}else if("3".equals(beginattclassbo1.getClassID())){
					if(!"03".equals(flleavevalue)){
						sum2+=0;
					}else{
			            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            Date date1 = df.parse(enddatevalue+" "+endtimevalue + ":00");
			            Date date2 = df.parse(enddatevalue+" 23:59:59");
			            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
			            w = (float) (Math.round(w * 100)) / 100;
			            sum2+=w;
					}
				}else{
					String str=attenceSetUCC.cacldays(userid,endtimevalue,beginattclassbo1);
					float a=Float.parseFloat(str);
					sum2+=a;
				}
			}else{
				if(!"03".equals(flleavevalue)){
					sum2+=0;
				}else{
		            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		            Date date1 = df.parse(enddatevalue+" "+endtimevalue + ":00");
		            Date date2 = df.parse(enddatevalue+" 23:59:59");
		            float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
		            w = (float) (Math.round(w * 100)) / 100;
		            sum2+=w;
				}
			}
			
			sum=Math.abs(sum1-sum2);
			sum = (float) (Math.round(sum * 100)) / 100;
			kqglLeaverDayValue=sum+"";
		}
		}catch(Exception e){
			
		}
		return "";
	}
	
	/*
	 * 确认
	 */
	public String makesure1() {
		try{
			String oldClassValue=attenceSetUCC.getA001737(userid);
			String[] begindatevalueWdatestrs=begindatevalueWdate1.split(" ");
			String begindatevalue1=begindatevalueWdatestrs[0];
			String begintimevalue1=begindatevalueWdatestrs[1];
			String[] enddatevalueWdatestrs=enddatevalueWdate1.split(" ");
			String enddatevalue1=enddatevalueWdatestrs[0];
			String endtimevalue1=enddatevalueWdatestrs[1];
		if(!begindatevalue1.equals(enddatevalue1)){
			float sum=0;
			AttClassBO beginattclassbo=attenceSetUCC.changeWork1(userid,superID,oldClassValue,begindatevalue1);
			if(beginattclassbo!=null){
				if("1".equals(beginattclassbo.getClassID())){
						sum+=0;
				}else if("2".equals(beginattclassbo.getClassID())){
						sum+=0;	
				}else if("3".equals(beginattclassbo.getClassID())){
						sum+=0;
				}else{
					String str=attenceSetUCC.cacldays(userid,begintimevalue1,beginattclassbo);
					float a=Float.parseFloat(str);
					sum+=a;
				}
			}else{
					sum+=0;
			}
			
			
			
			List lists=attenceSetUCC.getCaclDay(begindatevalue1,enddatevalue1);
			if(lists!=null && lists.size()>0){
				for(int i=1;i<lists.size()-1;i++){
					String d=(String)lists.get(i);
					System.out.println("d="+d);
					AttClassBO attclassbo=attenceSetUCC.changeWork1(userid,superID,oldClassValue,d);
					if(attclassbo!=null){
						if("1".equals(attclassbo.getClassID())){
								sum+=0;
						}else if("2".equals(attclassbo.getClassID())){
								sum+=0;
						}else if("3".equals(attclassbo.getClassID())){
								sum+=0;
						}else{
							sum+=1;
						}
					}else{
							sum+=0;
					}
				}
			}
			
			AttClassBO beginattclassbo1=attenceSetUCC.changeWork1(userid,superID,oldClassValue,enddatevalue1);
			if(beginattclassbo1!=null){
				if("1".equals(beginattclassbo1.getClassID())){
						sum+=0;
				}else if("2".equals(beginattclassbo1.getClassID())){
						sum+=0;
				}else if("3".equals(beginattclassbo1.getClassID())){
						sum+=0;
				}else{
					String str=attenceSetUCC.cacldays1(userid,endtimevalue1,beginattclassbo1);
					float a=Float.parseFloat(str);
					sum+=a;
				}
			}else{
					sum+=0;
			}
			
			sum = (float) (Math.round(sum * 100)) / 100;
			daySpan=sum+"";
		}else{
			float sum=0;
			float sum1=0;
			float sum2=0;
			AttClassBO beginattclassbo=attenceSetUCC.changeWork1(userid,superID,oldClassValue,begindatevalue1);
			if(beginattclassbo!=null){
				if("1".equals(beginattclassbo.getClassID())){
						sum1+=0;
				}else if("2".equals(beginattclassbo.getClassID())){
						sum1+=0;
				}else if("3".equals(beginattclassbo.getClassID())){
						sum1+=0;
				}else{
					String str=attenceSetUCC.cacldays(userid,begintimevalue1,beginattclassbo);
					float a=Float.parseFloat(str);
					sum1+=a;
				}
			}else{
					sum1+=0;
			}
			
			AttClassBO beginattclassbo1=attenceSetUCC.changeWork1(userid,superID,oldClassValue,enddatevalue1);
			if(beginattclassbo1!=null){
				if("1".equals(beginattclassbo1.getClassID())){
						sum2+=0;
				}else if("2".equals(beginattclassbo1.getClassID())){
						sum2+=0;
				}else if("3".equals(beginattclassbo1.getClassID())){
						sum2+=0;
				}else{
					String str=attenceSetUCC.cacldays(userid,endtimevalue1,beginattclassbo1);
					float a=Float.parseFloat(str);
					sum2+=a;
				}
			}else{
					sum2+=0;
			}
			
			sum=Math.abs(sum1-sum2);
			sum = (float) (Math.round(sum * 100)) / 100;
			daySpan=sum+"";
		}
		}catch(Exception e){
			
		}
		return "";
	}
	
	/*
	 * 确认
	 */
	public String makesure2() {
		try{
			String oldClassValue=attenceSetUCC.getA001737(userid);
			String[] begindatevalueWdatestrs=begindatevalueWdate2.split(" ");
			String begindatevalue1=begindatevalueWdatestrs[0];
			String begintimevalue1=begindatevalueWdatestrs[1];
			String[] enddatevalueWdatestrs=enddatevalueWdate2.split(" ");
			String enddatevalue1=enddatevalueWdatestrs[0];
			String endtimevalue1=enddatevalueWdatestrs[1];
		if(!begindatevalue1.equals(enddatevalue1)){
			float sum=0;
			AttClassBO beginattclassbo=attenceSetUCC.changeWork1(userid,superID,oldClassValue,begindatevalue1);
			if(beginattclassbo!=null){
				if("1".equals(beginattclassbo.getClassID())){
						sum+=0;
				}else if("2".equals(beginattclassbo.getClassID())){
						sum+=0;	
				}else if("3".equals(beginattclassbo.getClassID())){
						sum+=0;
				}else{
					String str=attenceSetUCC.cacldays(userid,begintimevalue1,beginattclassbo);
					float a=Float.parseFloat(str);
					sum+=a;
				}
			}else{
					sum+=0;
			}
			
			
			
			List lists=attenceSetUCC.getCaclDay(begindatevalue1,enddatevalue1);
			if(lists!=null && lists.size()>0){
				for(int i=1;i<lists.size()-1;i++){
					String d=(String)lists.get(i);
					System.out.println("d="+d);
					AttClassBO attclassbo=attenceSetUCC.changeWork1(userid,superID,oldClassValue,d);
					if(attclassbo!=null){
						if("1".equals(attclassbo.getClassID())){
								sum+=0;
						}else if("2".equals(attclassbo.getClassID())){
								sum+=0;
						}else if("3".equals(attclassbo.getClassID())){
								sum+=0;
						}else{
							sum+=1;
						}
					}else{
							sum+=0;
					}
				}
			}
			
			AttClassBO beginattclassbo1=attenceSetUCC.changeWork1(userid,superID,oldClassValue,enddatevalue1);
			if(beginattclassbo1!=null){
				if("1".equals(beginattclassbo1.getClassID())){
						sum+=0;
				}else if("2".equals(beginattclassbo1.getClassID())){
						sum+=0;
				}else if("3".equals(beginattclassbo1.getClassID())){
						sum+=0;
				}else{
					String str=attenceSetUCC.cacldays1(userid,endtimevalue1,beginattclassbo1);
					float a=Float.parseFloat(str);
					sum+=a;
				}
			}else{
					sum+=0;
			}
			
			sum = (float) (Math.round(sum * 100)) / 100;
			daySpan1=sum+"";
		}else{
			float sum=0;
			float sum1=0;
			float sum2=0;
			AttClassBO beginattclassbo=attenceSetUCC.changeWork1(userid,superID,oldClassValue,begindatevalue1);
			if(beginattclassbo!=null){
				if("1".equals(beginattclassbo.getClassID())){
						sum1+=0;
				}else if("2".equals(beginattclassbo.getClassID())){
						sum1+=0;
				}else if("3".equals(beginattclassbo.getClassID())){
						sum1+=0;
				}else{
					String str=attenceSetUCC.cacldays(userid,begintimevalue1,beginattclassbo);
					float a=Float.parseFloat(str);
					sum1+=a;
				}
			}else{
					sum1+=0;
			}
			
			AttClassBO beginattclassbo1=attenceSetUCC.changeWork1(userid,superID,oldClassValue,enddatevalue1);
			if(beginattclassbo1!=null){
				if("1".equals(beginattclassbo1.getClassID())){
						sum2+=0;
				}else if("2".equals(beginattclassbo1.getClassID())){
						sum2+=0;
				}else if("3".equals(beginattclassbo1.getClassID())){
						sum2+=0;
				}else{
					String str=attenceSetUCC.cacldays(userid,endtimevalue1,beginattclassbo1);
					float a=Float.parseFloat(str);
					sum2+=a;
				}
			}else{
					sum2+=0;
			}
			
			sum=Math.abs(sum1-sum2);
			sum = (float) (Math.round(sum * 100)) / 100;
			daySpan1=sum+"";
		}
		}catch(Exception e){
			
		}
		return "";
	}
	
	
	/*
	 * 请假
	 */
	public String PersonLeaveMessage() {
		bo.setPersonID(userid);
		bo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
		String begindate=begindatevalue+" "+begintimevalue;
		bo.setBeginTime(begindate);
		String enddate=enddatevalue+" "+endtimevalue;
		bo.setEndTime(enddate);
		bo.setLastDate(kqglLeaverDayValue);
		if(!"2".equals(bo.getSuperFlId()) && !"3".equals(bo.getSuperFlId())){
			bo.setFlID(flleavevalue);
			bo.setFlIdProcess(flleavevalue);
			bo.setFlIdStatus("");
			bo.setStatusValue("-1");
			bo.setSuperFurloughNo("");
			bo.setSuperFlId("1");
		}
		float sum=Float.parseFloat(kqglLeaverDayValue);
		if(sum>3){
			if("02".equals(flleavevalue) || "04".equals(flleavevalue)){
				bo.setFlIdProcess("01");
				bo.setFlIdStatus("0");
			}
		}
		if(isExist3){
			if(daySpan!=null && !"".equals(daySpan)){
				float dayspanvalue=Float.parseFloat(daySpan);
				if(dayspanvalue<=0){
					super.showMessageDetail("年假拟扣时间必须大于零。");
					return "";
				}
				System.out.println("计算 begindatevalueWdate1="+begindatevalueWdate1);
				System.out.println("计算 enddatevalueWdate1="+enddatevalueWdate1);
				System.out.println("计算 daySpan="+daySpan);
				System.out.println("计算 networkholidayvalue="+networkholidayvalue);
				System.out.println("计算 itemIdValue="+itemIdValue);
			}else{
				super.showMessageDetail("请设置年假拟扣时间。");
				return "";
			}
		}
		try {
			attenceSetUCC.saveAttFurloughRecBO(bo);
			if(isExist3){
				List attannualdetailbovalue=null;
				if(bo.getSuperFurloughNo()!=null && !"".equals(bo.getSuperFurloughNo())){
					attannualdetailbovalue=attenceSetUCC.getAttAnnualDetailAuditBO(userid,bo.getSuperFurloughNo());
					System.out.println("计算 bo.getSuperFurloughNo()="+bo.getSuperFurloughNo());
				}else{
					System.out.println("计算 bo.getFurloughNO()="+bo.getFurloughNO());
					attannualdetailbovalue=attenceSetUCC.getAttAnnualDetailAuditBO(userid,bo.getFurloughNO());
				}
				//List attannualdetailbovalue=attenceSetUCC.getAttAnnualDetailAuditBO(userid,bo.getFurloughNO());
				if(attannualdetailbovalue!=null && attannualdetailbovalue.size()>0){
					System.out.println("计算 attannualdetailbovalue!=null && attannualdetailbovalue.size()>0");
					AttAnnualDetailAuditBO attannualdetailauditbo=(AttAnnualDetailAuditBO)attannualdetailbovalue.get(0);
					attannualdetailauditbo.setItemId(itemIdValue);
					attannualdetailauditbo.setPersonID(userid);
					attannualdetailauditbo.setHolidayBegin(begindatevalueWdate1);
					attannualdetailauditbo.setHolidayEnd(enddatevalueWdate1);
					attannualdetailauditbo.setDaySpan(daySpan);
					attannualdetailauditbo.setStatusValue("-1");
					if(bo.getSuperFurloughNo()!=null && !"".equals(bo.getSuperFurloughNo())){
						attannualdetailauditbo.setFurloughno(bo.getSuperFurloughNo());
					}else{
						attannualdetailauditbo.setFurloughno(bo.getFurloughNO());
					}
					attenceSetUCC.saveorupdateAttAnnualDetailAuditBO(attannualdetailauditbo);
				}else{
					System.out.println("计算 attannualdetailbovalue");
					AttAnnualDetailAuditBO attannualdetailauditbo=new AttAnnualDetailAuditBO();
					attannualdetailauditbo.setItemId(itemIdValue);
					attannualdetailauditbo.setPersonID(userid);
					attannualdetailauditbo.setHolidayBegin(begindatevalueWdate1);
					attannualdetailauditbo.setHolidayEnd(enddatevalueWdate1);
					attannualdetailauditbo.setDaySpan(daySpan);
					attannualdetailauditbo.setStatusValue("-1");
					if(bo.getSuperFurloughNo()!=null && !"".equals(bo.getSuperFurloughNo())){
						attannualdetailauditbo.setFurloughno(bo.getSuperFurloughNo());
					}else{
						attannualdetailauditbo.setFurloughno(bo.getFurloughNO());
					}
					System.out.println("计算 attannualdetailauditbo="+attannualdetailauditbo.getHolidayEnd());
					attenceSetUCC.saveorupdateAttAnnualDetailAuditBO(attannualdetailauditbo);
				}
			}else{
				if(bo.getSuperFurloughNo()!=null && !"".equals(bo.getSuperFurloughNo())){
					List attannualdetailbovalue=attenceSetUCC.getAttAnnualDetailAuditBO(userid,bo.getSuperFurloughNo());
					if(attannualdetailbovalue!=null && attannualdetailbovalue.size()>0){
						attenceSetUCC.deleteAttAnnualDetailAuditBO1(bo.getSuperFurloughNo());
					}
				}else{
					List attannualdetailbovalue=attenceSetUCC.getAttAnnualDetailAuditBO(userid,bo.getFurloughNO());
					if(attannualdetailbovalue!=null && attannualdetailbovalue.size()>0){
						attenceSetUCC.deleteAttAnnualDetailAuditBO1(bo.getFurloughNO());
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
	public String PersonLeaveMessageAudit() {
		try {
			if (furloughNO != null) {
				AttFurloughRecBO attfurloughrecbo=attenceSetUCC.findAttFurloughRecBObyId(furloughNO);
				attfurloughrecbo.setStatusValue("0");
				attenceSetUCC.saveAttFurloughRecBO(attfurloughrecbo);
				WFTransaction wt = new WFTransaction();
				wt.setLinkID(furloughNO);
				wt.setOperID("0525");
				wt.setUser(super.getUserInfo());
				wt.setWfType(KQGL_LEAVE_VALUE);
				wt.setConValue(attfurloughrecbo.getLastDate());  //请假天数
				wt.setStatusValue("0"); //审批状态
				wt.setWffunction("att_WorkFlowFurloughService");
				attenceSetUCC.processTrans(wt);
			}
		} catch (Exception e) {
              e.printStackTrace();
		}
		return "";
	}
	
	/*
	 * 请假，并报批。
	 */
	public String PersonLeaveMessageAndPersonLeaveMessageAudit() {
		bo.setPersonID(userid);
		bo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
		String begindate=begindatevalue+" "+begintimevalue;
		bo.setBeginTime(begindate);
		String enddate=enddatevalue+" "+endtimevalue;
		bo.setEndTime(enddate);
		bo.setLastDate(kqglLeaverDayValue);
		if(!"2".equals(bo.getSuperFlId()) && !"3".equals(bo.getSuperFlId())){
			bo.setFlID(flleavevalue);
			bo.setFlIdProcess(flleavevalue);
			bo.setFlIdStatus("");
			bo.setStatusValue("-1");
			bo.setSuperFurloughNo("");
			bo.setSuperFlId("1");
		}
		float sum=Float.parseFloat(kqglLeaverDayValue);
		if(sum>3){
			if("02".equals(flleavevalue) || "04".equals(flleavevalue)){
				bo.setFlIdProcess("01");
				bo.setFlIdStatus("0");
			}
		}
		if(isExist3){
			if(daySpan!=null && !"".equals(daySpan)){
				float dayspanvalue=Float.parseFloat(daySpan);
				if(dayspanvalue<=0){
					super.showMessageDetail("年假拟扣时间必须大于零。");
					return "";
				}
				System.out.println("计算 begindatevalueWdate1="+begindatevalueWdate1);
				System.out.println("计算 enddatevalueWdate1="+enddatevalueWdate1);
				System.out.println("计算 daySpan="+daySpan);
				System.out.println("计算 networkholidayvalue="+networkholidayvalue);
				System.out.println("计算 itemIdValue="+itemIdValue);
			}else{
				super.showMessageDetail("请设置年假拟扣时间。");
				return "";
			}
		}
		try {
			attenceSetUCC.saveAttFurloughRecBO(bo);
//			WFTransaction wt = new WFTransaction();
//			wt.setLinkID(bo.getFurloughNO());
//			wt.setOperID("0525");
//			wt.setUser(super.getUserInfo());
//			wt.setWfType(KQGL_LEAVE_VALUE);
//			wt.setConValue("");
//			wt.setStatusValue("");
//			attenceSetUCC.processTrans(wt);
			if(isExist3){
				List attannualdetailbovalue=null;
				if(bo.getSuperFurloughNo()!=null && !"".equals(bo.getSuperFurloughNo())){
					attannualdetailbovalue=attenceSetUCC.getAttAnnualDetailAuditBO(userid,bo.getSuperFurloughNo());
					System.out.println("计算 bo.getSuperFurloughNo()="+bo.getSuperFurloughNo());
				}else{
					System.out.println("计算 bo.getFurloughNO()="+bo.getFurloughNO());
					attannualdetailbovalue=attenceSetUCC.getAttAnnualDetailAuditBO(userid,bo.getFurloughNO());
				}
				//List attannualdetailbovalue=attenceSetUCC.getAttAnnualDetailAuditBO(userid,bo.getFurloughNO());
				if(attannualdetailbovalue!=null && attannualdetailbovalue.size()>0){
					System.out.println("计算 attannualdetailbovalue!=null && attannualdetailbovalue.size()>0");
					AttAnnualDetailAuditBO attannualdetailauditbo=(AttAnnualDetailAuditBO)attannualdetailbovalue.get(0);
					attannualdetailauditbo.setItemId(itemIdValue);
					attannualdetailauditbo.setPersonID(userid);
					attannualdetailauditbo.setHolidayBegin(begindatevalueWdate1);
					attannualdetailauditbo.setHolidayEnd(enddatevalueWdate1);
					attannualdetailauditbo.setDaySpan(daySpan);
					attannualdetailauditbo.setStatusValue("-1");
					if(bo.getSuperFurloughNo()!=null && !"".equals(bo.getSuperFurloughNo())){
						attannualdetailauditbo.setFurloughno(bo.getSuperFurloughNo());
					}else{
						attannualdetailauditbo.setFurloughno(bo.getFurloughNO());
					}
					attenceSetUCC.saveorupdateAttAnnualDetailAuditBO(attannualdetailauditbo);
				}else{
					System.out.println("计算 attannualdetailbovalue");
					AttAnnualDetailAuditBO attannualdetailauditbo=new AttAnnualDetailAuditBO();
					attannualdetailauditbo.setItemId(itemIdValue);
					attannualdetailauditbo.setPersonID(userid);
					attannualdetailauditbo.setHolidayBegin(begindatevalueWdate1);
					attannualdetailauditbo.setHolidayEnd(enddatevalueWdate1);
					attannualdetailauditbo.setDaySpan(daySpan);
					attannualdetailauditbo.setStatusValue("-1");
					if(bo.getSuperFurloughNo()!=null && !"".equals(bo.getSuperFurloughNo())){
						attannualdetailauditbo.setFurloughno(bo.getSuperFurloughNo());
					}else{
						attannualdetailauditbo.setFurloughno(bo.getFurloughNO());
					}
					System.out.println("计算 attannualdetailauditbo="+attannualdetailauditbo.getHolidayEnd());
					attenceSetUCC.saveorupdateAttAnnualDetailAuditBO(attannualdetailauditbo);
				}
			}else{
				if(bo.getSuperFurloughNo()!=null && !"".equals(bo.getSuperFurloughNo())){
					List attannualdetailbovalue=attenceSetUCC.getAttAnnualDetailAuditBO(userid,bo.getSuperFurloughNo());
					if(attannualdetailbovalue!=null && attannualdetailbovalue.size()>0){
						attenceSetUCC.deleteAttAnnualDetailAuditBO1(bo.getSuperFurloughNo());
					}
				}else{
					List attannualdetailbovalue=attenceSetUCC.getAttAnnualDetailAuditBO(userid,bo.getFurloughNO());
					if(attannualdetailbovalue!=null && attannualdetailbovalue.size()>0){
						attenceSetUCC.deleteAttAnnualDetailAuditBO1(bo.getFurloughNO());
					}
				}
			}
			
			if (bo.getFurloughNO() != null) {
				AttFurloughRecBO attfurloughrecbo=attenceSetUCC.findAttFurloughRecBObyId(bo.getFurloughNO());
				attfurloughrecbo.setStatusValue("0");
				attenceSetUCC.saveAttFurloughRecBO(attfurloughrecbo);
				WFTransaction wt = new WFTransaction();
				wt.setLinkID(bo.getFurloughNO());
				wt.setOperID("0525");
				wt.setUser(super.getUserInfo());
				wt.setWfType(KQGL_LEAVE_VALUE);
				wt.setConValue(attfurloughrecbo.getLastDate());  //请假天数
				wt.setStatusValue("0"); //审批状态
				wt.setWffunction("att_WorkFlowFurloughService");
				attenceSetUCC.processTrans(wt);
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}
	
	/*
	 * 审批
	 */
	public String personLeaveAudit() {
		 PersonBO person=null;
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
						persBos1 = attenceSetUCC.getAttFurloughRecBO1(superID,mypage,isExist1,operID,deptID,super.getUserInfo());
						if (persBos1 != null && persBos1.size() > 0) {
						  if(isExist1){
							for (int j = 0; j < persBos1.size(); j++) {
								AttFurloughRecBO attfurloughrecbo1 = (AttFurloughRecBO) persBos1
										.get(j);
								 person =SysCacheTool.findPersonById(attfurloughrecbo1.getPersonID());
								attfurloughrecbo1.setPersonName(person.getName());
								if("3".equals(attfurloughrecbo1.getStatusValue())){
									attfurloughrecbo1.setStatusValueName("审批通过");
								}else{
									attfurloughrecbo1.setStatusValueName("审批中");
								}
								AttfurloughBO attfurloughbo1=(AttfurloughBO)attenceSetUCC.findAttfurloughBObyId(attfurloughrecbo1.getFlID());
								attfurloughrecbo1.setFlName(attfurloughbo1.getFlName());
								AttfurloughBO attfurloughbo2=(AttfurloughBO)attenceSetUCC.findAttfurloughBObyId(attfurloughrecbo1.getFlIdProcess());
								attfurloughrecbo1.setFlIdProcessName(attfurloughbo2.getFlName());
								if(attfurloughrecbo1.getFlIdStatus()!=null && !"".equals(attfurloughrecbo1.getFlIdStatus())){
									if("1".equals(attfurloughrecbo1.getFlIdStatus())){
										attfurloughrecbo1.setFlIdStatusName("是");
									}else{
										attfurloughrecbo1.setFlIdStatusName("否");
									}
								}else{
									attfurloughrecbo1.setFlIdStatusName("-");
								}
								System.out.println(attfurloughrecbo1.getFurloughNO());
								WFNodeBO currentnode = attenceSetUCC
										.getCurrentNode(attfurloughrecbo1
												.getFurloughNO());
								System.out.println(currentnode);
								if (currentnode != null) {
									if (currentnode.getOperID().equals(operID)) {
										attfurloughrecbo1.setFlagvalue("yes");
									} else {
										attfurloughrecbo1.setFlagvalue("no");
									}
								}
								if(attfurloughrecbo1.getSuperFlId()!=null && !"".equals(attfurloughrecbo1.getSuperFlId())){
                                    if("1".equals(attfurloughrecbo1.getSuperFlId())){
										attfurloughrecbo1.setSuperFlIdName(this.NORMAL_NAME);
									}else if("2".equals(attfurloughrecbo1.getSuperFlId())){
										attfurloughrecbo1.setSuperFlIdName(this.ADD_FURLOUGHREC_NAME);
									}else if("3".equals(attfurloughrecbo1.getSuperFlId())){
										attfurloughrecbo1.setSuperFlIdName(this.ESC_FURLOUGHREC_NAME);
									}
								}
								persBos2.add(attfurloughrecbo1);
							}
						}else{	
							for (int j = 0; j < persBos1.size(); j++) {
								AttFurloughRecBO attfurloughrecbo1 = (AttFurloughRecBO) persBos1
										.get(j);
								WFNodeBO currentnode = attenceSetUCC
								.getCurrentNode(attfurloughrecbo1
										.getFurloughNO());
						System.out.println(currentnode);
						if (currentnode != null) {
							if (currentnode.getOperID().equals(operID)) {
								 person =SysCacheTool.findPersonById(attfurloughrecbo1.getPersonID());
								attfurloughrecbo1.setPersonName(person.getName());
								if("3".equals(attfurloughrecbo1.getStatusValue())){
									attfurloughrecbo1.setStatusValueName("审批通过");
								}else{
									attfurloughrecbo1.setStatusValueName("审批中");
								}
								AttfurloughBO attfurloughbo1=(AttfurloughBO)attenceSetUCC.findAttfurloughBObyId(attfurloughrecbo1.getFlID());
								attfurloughrecbo1.setFlName(attfurloughbo1.getFlName());
								AttfurloughBO attfurloughbo2=(AttfurloughBO)attenceSetUCC.findAttfurloughBObyId(attfurloughrecbo1.getFlIdProcess());
								attfurloughrecbo1.setFlIdProcessName(attfurloughbo2.getFlName());
								if(attfurloughrecbo1.getFlIdStatus()!=null && !"".equals(attfurloughrecbo1.getFlIdStatus())){
									if("1".equals(attfurloughrecbo1.getFlIdStatus())){
										attfurloughrecbo1.setFlIdStatusName("是");
									}else{
										attfurloughrecbo1.setFlIdStatusName("否");
									}
								}else{
									attfurloughrecbo1.setFlIdStatusName("-");
								}
								System.out.println(attfurloughrecbo1.getFurloughNO());

									
										attfurloughrecbo1.setFlagvalue("yes");
								
								if(attfurloughrecbo1.getSuperFlId()!=null && !"".equals(attfurloughrecbo1.getSuperFlId())){
                                    if("1".equals(attfurloughrecbo1.getSuperFlId())){
										attfurloughrecbo1.setSuperFlIdName(this.NORMAL_NAME);
									}else if("2".equals(attfurloughrecbo1.getSuperFlId())){
										attfurloughrecbo1.setSuperFlIdName(this.ADD_FURLOUGHREC_NAME);
									}else if("3".equals(attfurloughrecbo1.getSuperFlId())){
										attfurloughrecbo1.setSuperFlIdName(this.ESC_FURLOUGHREC_NAME);
									}
								}
								persBos2.add(attfurloughrecbo1);
						       }
						      }
							} 
						}
			}          
						AttFurloughRecBO attf = null ;
                        for(int i = 0 ; i < persBos2.size() ; i++){
                        	attf = (AttFurloughRecBO)persBos2.get(i);
                        	System.out.println("operID="+operID);
				            System.out.println("StatusValue = "+attf.getStatusValue()+"Flagvalue = "+attf.getFlagvalue());
			            }
						
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "";
	}

	public String getInitEdit1() {
		try {
		holidayBegin="";
		holidayEnd="";
		holidayDaySpan="";
		if (super.getRequestParameter("furloughNO") != null
				&& !super.getRequestParameter("furloughNO").equals("") && super.getRequestParameter("operID") != null
				&& !super.getRequestParameter("operID").equals("")) {
			operID=super.getRequestParameter("operID");
			furloughNO = super.getRequestParameter("furloughNO");
			bo1=attenceSetUCC.findAttFurloughRecBObyId(furloughNO);
			AttfurloughBO attfurloughbo1=(AttfurloughBO)attenceSetUCC.findAttfurloughBObyId(bo1.getFlID());
			bo1.setFlName(attfurloughbo1.getFlName());
			String name=SysCacheTool.findPersonById(bo1.getPersonID()).getName();
			String a="";
			//if ("ORACLE".equals(Constants.DB_TYPE)) {
				//a=new String(name.getBytes("iso-8859-1"), "GBK");	
			//}else{
				a=name;
			//}
			bo1.setPersonName(a);
			//部门 
			if(bo1.getDeptAuditResult()!=null && !"".equals(bo1.getDeptAuditResult())){
				if("1".equals(bo1.getDeptAuditResult())){
					bo1.setDeptAuditCausevalue("同意");
				}else{
					bo1.setDeptAuditCausevalue("不同意");
				}
			}
			//部门领导
			if(bo1.getLeaderAuditResult()!=null && !"".equals(bo1.getLeaderAuditResult())){
				if("1".equals(bo1.getLeaderAuditResult())){
					bo1.setLeaderAuditCausevalue("同意");
				}else{
					bo1.setLeaderAuditCausevalue("不同意");
				}
			}
			//人力资源
			if(bo1.getHrAuditResult()!=null && !"".equals(bo1.getHrAuditResult())){
				if("1".equals(bo1.getHrAuditResult())){
					bo1.setHrAuditResultvalue("同意");
				}else{
					bo1.setHrAuditResultvalue("不同意");
				}
			}
			//总监
			System.out.println("总监:"+bo1.getZjAuditResult());
			if(bo1.getZjAuditResult()!=null && !"".equals(bo1.getZjAuditResult())){
				if("1".equals(bo1.getZjAuditResult())){
					bo1.setZjAuditResultvalue("同意");
				}else{
					bo1.setZjAuditResultvalue("不同意");
				}
			}
			//总经理
			System.out.println("总经理:"+bo1.getZjlAuditResult());
			if(bo1.getZjlAuditResult()!=null && !"".equals(bo1.getZjlAuditResult())){
				if("1".equals(bo1.getZjAuditResult())){
					bo1.setZjlAuditResultvalue("同意");
				}else{
					bo1.setZjlAuditResultvalue("不同意");
				}
			}
			
			if(bo1.getSuperFlId()!=null && !"".equals(bo1.getSuperFlId())){
				if("1".equals(bo1.getSuperFlId())){
					bo1.setSuperFlIdName(this.NORMAL_NAME);
				}else if("2".equals(bo1.getSuperFlId())){
					bo1.setSuperFlIdName(this.ADD_FURLOUGHREC_NAME);
				}else if("3".equals(bo1.getSuperFlId())){
					bo1.setSuperFlIdName(this.ESC_FURLOUGHREC_NAME);
				}
			}
			
			//年假抵扣信息查看
			List listvalue=attenceSetUCC.getAllAttAnnualDetailAuditBO(bo1.getFurloughNO());
			if(listvalue!=null && listvalue.size()>0){
				AttAnnualDetailAuditBO attannualdetailauditbo=(AttAnnualDetailAuditBO)listvalue.get(0);
				holidayBegin=attannualdetailauditbo.getHolidayBegin();
				holidayEnd=attannualdetailauditbo.getHolidayEnd();
				holidayDaySpan=attannualdetailauditbo.getDaySpan();
				isExist6=true;
			}
			
			//请假历史记录信息
			if(bo1.getSuperFurloughNo()!=null && !"".equals(bo1.getSuperFurloughNo())){
				furloughNO=bo1.getSuperFurloughNo();
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

	public String getFurloughNO() {
		return furloughNO;
	}

	public void setFurloughNO(String furloughNO) {
		this.furloughNO = furloughNO;
	}
	
	/*
	 *部门经理审批结果 
	 */
	public String PersonLeaveAudit1(){
		if("1".equals(status)){
			bo1.setStatusValue("1");
		}else if("2".equals(status)){
			bo1.setStatusValue("2");
		}
		bo1.setDeptAuditResult(status);
		bo1.setDeptAuditOper(personName);
		bo1.setDeptAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try {
			attenceSetUCC.saveAttFurloughRecBO(bo1);
			WFTransaction wt = new WFTransaction();
			wt.setLinkID(bo1.getFurloughNO());
			//wt.setOperID("0530");
			wt.setOperID(operID);
			wt.setUser(super.getUserInfo());
			wt.setWfType(KQGL_LEAVE_VALUE);
			wt.setConValue(bo1.getLastDate());  //请假天数
			wt.setStatusValue(status); //审批状态
			wt.setWffunction("att_WorkFlowFurloughService");
			attenceSetUCC.processTrans(wt);
			} catch (SysException e) {
				e.printStackTrace();
			}
		return "success";
	}

	/*
	 *主管领导审批结果 
	 */
	public String PersonLeaveAudit2(){
		if("1".equals(status)){
			bo1.setStatusValue("1");
		}else if("2".equals(status)){
			bo1.setStatusValue("2");
		}
		bo1.setLeaderAuditResult(status);
		bo1.setLeaderAuditOper(personName);
		bo1.setLeaderAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try {
			attenceSetUCC.saveAttFurloughRecBO(bo1);
			WFTransaction wt = new WFTransaction();
			wt.setLinkID(bo1.getFurloughNO());
			//wt.setOperID("0530");
			wt.setOperID(operID);
			wt.setUser(super.getUserInfo());
			wt.setWfType(KQGL_LEAVE_VALUE);
			wt.setConValue(bo1.getLastDate());  //请假天数
			wt.setStatusValue(status); //审批状态
			wt.setWffunction("att_WorkFlowFurloughService");
			attenceSetUCC.processTrans(wt);
			} catch (SysException e) {
				e.printStackTrace();
			}
		return "success";
	}
	
	/*
	 *人力资源部门审批结果 
	 */
	public String PersonLeaveAudit3(){
		if("1".equals(status)){
			bo1.setStatusValue("1");
		}else if("2".equals(status)){
			bo1.setStatusValue("2");
		}
		bo1.setHrAuditResult(status);
		bo1.setHrAuditOper(personName);
		bo1.setHrAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try {
			attenceSetUCC.saveAttFurloughRecBO(bo1);
			 //if("2".equals(status)){
					WFTransaction wt = new WFTransaction();
					wt.setLinkID(bo1.getFurloughNO());
					//wt.setOperID("0530");
					wt.setOperID(operID);
					wt.setUser(super.getUserInfo());
					wt.setWfType(KQGL_LEAVE_VALUE);
					wt.setConValue(bo1.getLastDate());  //请假天数
					wt.setStatusValue(status); //审批状态
					wt.setWffunction("att_WorkFlowFurloughService");
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
	public String PersonLeaveAudit4(){
		if("1".equals(status)){
			bo1.setStatusValue("1");
		}else if("2".equals(status)){
			bo1.setStatusValue("2");
		}
		bo1.setZjAuditResult(status);
		bo1.setZjAuditOper(personName);
		bo1.setZjAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try {
			attenceSetUCC.saveAttFurloughRecBO(bo1);
					WFTransaction wt = new WFTransaction();
					wt.setLinkID(bo1.getFurloughNO());
					wt.setOperID(operID);
					wt.setUser(super.getUserInfo());
					wt.setWfType(KQGL_LEAVE_VALUE);
					wt.setConValue(bo1.getLastDate());  //请假天数
					wt.setStatusValue(status); //审批状态
					wt.setWffunction("att_WorkFlowFurloughService");
					attenceSetUCC.processTrans(wt);
			} catch (SysException e) {
				e.printStackTrace();
			}
		return "success";
	}
	
	/*
	 *总经理审批结果 
	 */
	public String PersonLeaveAudit5(){
		if("1".equals(status)){
			bo1.setStatusValue("1");
		}else if("2".equals(status)){
			bo1.setStatusValue("2");
		}
		bo1.setZjlAuditResult(status);
		bo1.setZjlAuditOper(personName);
		bo1.setZjlAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try {
			attenceSetUCC.saveAttFurloughRecBO(bo1);
					WFTransaction wt = new WFTransaction();
					wt.setLinkID(bo1.getFurloughNO());
					wt.setOperID(operID);
					wt.setUser(super.getUserInfo());
					wt.setWfType(KQGL_LEAVE_VALUE);
					wt.setConValue(bo1.getLastDate());  //请假天数
					wt.setStatusValue(status); //审批状态
					wt.setWffunction("att_WorkFlowFurloughService");
					attenceSetUCC.processTrans(wt);
			} catch (SysException e) {
				e.printStackTrace();
			}
		return "success";
	}
	public AttFurloughRecBO getBo1() {
		return bo1;
	}

	public void setBo1(AttFurloughRecBO bo1) {
		this.bo1 = bo1;
	}

	public AttFurloughRecBO getBos() {
		return bos;
	}

	public void setBos(AttFurloughRecBO bos) {
		this.bos = bos;
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

	public String getKqglLeaverDayValue() {
		return kqglLeaverDayValue;
	}

	public void setKqglLeaverDayValue(String kqglLeaverDayValue) {
		this.kqglLeaverDayValue = kqglLeaverDayValue;
	}
	public void changeNowYearValue(ValueChangeEvent event){
        this.isExist="true".equals(event.getNewValue().toString());
        getPageInit();
    }
	public void changeNowYearValue1(ValueChangeEvent event){
        this.isExist1="true".equals(event.getNewValue().toString());
        getInitEdit();
    }
	public void changeNowYearValue2(ValueChangeEvent event){
        this.isExist3="true".equals(event.getNewValue().toString());
        System.out.println("计算 isExist3="+isExist3);
    }
	public String delete(){
		try{
			if (furloughNO != null) {
				attenceSetUCC.deleteAttFurloughRecBO(furloughNO);
				WFProcessBO wfprocessbo=attenceSetUCC.findWFProcessBO(furloughNO);
				if(wfprocessbo!=null){
					attenceSetUCC.deleteWFLogBO(wfprocessbo.getProcessID());
					attenceSetUCC.deleteSysInProcessBO(wfprocessbo.getProcessID());
					attenceSetUCC.deleteWFProcessBO(wfprocessbo.getProcessID());
				}
				attenceSetUCC.deleteAttAnnualDetailAuditBO1(furloughNO);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}

	public String getPageInit2() {
		try{
		if(super.getRequestParameter("furloughNO") != null
				&& !super.getRequestParameter("furloughNO").equals("") && super.getRequestParameter("flag") != null
				&& !super.getRequestParameter("flag").equals("") && super.getRequestParameter("furloughCollectNO") != null && !super.getRequestParameter("furloughCollectNO").equals("")){
			furloughNO = super.getRequestParameter("furloughNO");
			flag= super.getRequestParameter("flag");
			String furloughCollectNO= super.getRequestParameter("furloughCollectNO");
			bos=attenceSetUCC.findAttFurloughRecBObyId(furloughNO);
//			String[] begindate=bos.getBeginTime().split(" ");
//			begindatevalue=begindate[0];
//			begintimevalue=begindate[1];
//			kqglLeaverDayValue=bo.getLastDate();
//			reason=bo.getReason();
			AttFurloughRecCollectBO attfurloughreccollectbo=attenceSetUCC.findAttFurloughRecCollectBObyId(furloughCollectNO);
			AttfurloughBO attfurloughbo1=(AttfurloughBO)attenceSetUCC.findAttfurloughBObyId(attfurloughreccollectbo.getFlIdProcess());
			flleavevalue=attfurloughbo1.getFlName();
			if("2".equals(flag)){
				//String[] enddate=attfurloughreccollectbo.getEndTime().split(" ");
				//begindatevalue=enddate[0];
				//begintimevalue=enddate[1];
				begindatevalueWdate=attfurloughreccollectbo.getEndTime();
				enddatevalueWdate="";
				begindatevalueWdate3=attfurloughreccollectbo.getBeginTime();
				enddatevalueWdate3=attfurloughreccollectbo.getEndTime();
				kqglLeaverDayValue="";
			}else if("3".equals(flag)){
				begindatevalueWdate="";
				enddatevalueWdate="";
				begindatevalueWdate3=attfurloughreccollectbo.getBeginTime();
				enddatevalueWdate3=attfurloughreccollectbo.getEndTime();
				kqglLeaverDayValue=bos.getLastDate();
			}else{
				//begindatevalue="";
				//begintimevalue="00:00";
				begindatevalueWdate="";
				enddatevalueWdate="";
			}
			//endtimevalue="23:59";
			
			//年假补扣信息
			typeStatus="1";
			isExist5=false;
    		begindatevalueWdate2="";
    		enddatevalueWdate2="";
    		daySpan1="";
    		itemIdValue1="";
			List attannualdetailbovalue=attenceSetUCC.getAttAnnualDetailAuditBO(attfurloughreccollectbo.getPersonID(),attfurloughreccollectbo.getFurloughNO());
			if(attannualdetailbovalue!=null && attannualdetailbovalue.size()>0){
				isExist5=true;
				AttAnnualDetailAuditBO attannualdetailauditbo=(AttAnnualDetailAuditBO)attannualdetailbovalue.get(0);
	    		begindatevalueWdate2=attannualdetailauditbo.getHolidayBegin();
	    		enddatevalueWdate2=attannualdetailauditbo.getHolidayEnd();
	    		daySpan1=attannualdetailauditbo.getDaySpan();
	    		itemIdValue1=attannualdetailauditbo.getItemId();
			}
			
			//请假历史记录信息
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

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}
	
	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	/*
	 * 补假、续假。
	 */
	public String PersonLeaveMessages() {
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
    			super.showMessageDetail("续/销请假的开始时间必须大于等于原始请假的开始时间");
    			return "";
            }
            if("3".equals(flag)){
                if(date1.getTime()>date4.getTime()){
        			super.showMessageDetail("续/销请假的开始时间必须小于等于原始请假的结束时间");
        			return "";
                }
                if(date2.getTime()<date3.getTime()){
        			super.showMessageDetail("续/销请假的结束时间必须大于等于原始请假的开始时间");
        			return "";
                }
                if(date2.getTime()>date4.getTime()){
        			super.showMessageDetail("续/销请假的结束时间必须小于等于原始请假的结束时间");
        			return "";
                }
            }
		}else{
			super.showMessageDetail("请选择续/销请假时间");
			return "";
		}
		AttFurloughRecBO attfurloughrecbo=new AttFurloughRecBO();
		attfurloughrecbo.setPersonID(userid);
		attfurloughrecbo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
		attfurloughrecbo.setBeginTime(begindate);		
		attfurloughrecbo.setEndTime(enddate);
		attfurloughrecbo.setFlID(bos.getFlID());
		attfurloughrecbo.setLastDate(kqglLeaverDayValue);
		attfurloughrecbo.setReason(reason);
		attfurloughrecbo.setStatusValue("-1");
		attfurloughrecbo.setSuperFurloughNo(bos.getFurloughNO());
		attfurloughrecbo.setSuperFlId(flag);
		attfurloughrecbo.setFlIdProcess(bos.getFlID());
		attfurloughrecbo.setFlIdStatus("");
		
			attenceSetUCC.saveAttFurloughRecBO(attfurloughrecbo);
			if(isExist5){
				if("1".equals(typeStatus)){
					System.out.println("计算 typeStatus1="+typeStatus);
					attenceSetUCC.deleteAttAnnualDetailAuditBO1(bos.getFurloughNO());
				}else if("2".equals(typeStatus)){
					System.out.println("计算 typeStatus2="+typeStatus);
					List attannualdetailbovalue=attenceSetUCC.getAttAnnualDetailAuditBO(userid,bos.getFurloughNO());
					if(attannualdetailbovalue!=null && attannualdetailbovalue.size()>0){
						AttAnnualDetailAuditBO attannualdetailauditbo=(AttAnnualDetailAuditBO)attannualdetailbovalue.get(0);
						attannualdetailauditbo.setItemId(itemIdValue1);
						attannualdetailauditbo.setHolidayBegin(begindatevalueWdate2);
						attannualdetailauditbo.setHolidayEnd(enddatevalueWdate2);
						attannualdetailauditbo.setDaySpan(daySpan1);
						attannualdetailauditbo.setStatusValue("-1");
						attannualdetailauditbo.setFurloughno(bos.getFurloughNO());
						attenceSetUCC.saveorupdateAttAnnualDetailAuditBO(attannualdetailauditbo);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	/*
	 * 补假、续假，并报批。
	 */
	public String PersonLeaveMessagesAndPersonLeaveMessageAudit() {
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
    			super.showMessageDetail("续/销请假的开始时间必须大于等于原始请假的开始时间");
    			return "";
            }
            if("3".equals(flag)){
                if(date1.getTime()>date4.getTime()){
        			super.showMessageDetail("续/销请假的开始时间必须小于等于原始请假的结束时间");
        			return "";
                }
                if(date2.getTime()<date3.getTime()){
        			super.showMessageDetail("续/销请假的结束时间必须大于等于原始请假的开始时间");
        			return "";
                }
                if(date2.getTime()>date4.getTime()){
        			super.showMessageDetail("续/销请假的结束时间必须小于等于原始请假的结束时间");
        			return "";
                }
            }
		}else{
			super.showMessageDetail("请选择续/销请假时间");
			return "";
		}
		AttFurloughRecBO attfurloughrecbo=new AttFurloughRecBO();
		attfurloughrecbo.setPersonID(userid);
		attfurloughrecbo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
		attfurloughrecbo.setBeginTime(begindate);
		attfurloughrecbo.setEndTime(enddate);
		attfurloughrecbo.setFlID(bos.getFlID());
		attfurloughrecbo.setLastDate(kqglLeaverDayValue);
		attfurloughrecbo.setReason(reason);
		attfurloughrecbo.setStatusValue("-1");
		attfurloughrecbo.setSuperFurloughNo(bos.getFurloughNO());
		attfurloughrecbo.setSuperFlId(flag);
		attfurloughrecbo.setFlIdProcess(bos.getFlID());
		attfurloughrecbo.setFlIdStatus("");
		
			attenceSetUCC.saveAttFurloughRecBO(attfurloughrecbo);
			if(isExist5){
				if("1".equals(typeStatus)){
					System.out.println("计算 typeStatus1="+typeStatus);
					attenceSetUCC.deleteAttAnnualDetailAuditBO1(bos.getFurloughNO());
				}else if("2".equals(typeStatus)){
					System.out.println("计算 typeStatus2="+typeStatus);
					List attannualdetailbovalue=attenceSetUCC.getAttAnnualDetailAuditBO(userid,bos.getFurloughNO());
					if(attannualdetailbovalue!=null && attannualdetailbovalue.size()>0){
						AttAnnualDetailAuditBO attannualdetailauditbo=(AttAnnualDetailAuditBO)attannualdetailbovalue.get(0);
						attannualdetailauditbo.setItemId(itemIdValue1);
						attannualdetailauditbo.setHolidayBegin(begindatevalueWdate2);
						attannualdetailauditbo.setHolidayEnd(enddatevalueWdate2);
						attannualdetailauditbo.setDaySpan(daySpan1);
						attannualdetailauditbo.setStatusValue("-1");
						attannualdetailauditbo.setFurloughno(bos.getFurloughNO());
						attenceSetUCC.saveorupdateAttAnnualDetailAuditBO(attannualdetailauditbo);
					}
				}
			}
			
			if (attfurloughrecbo.getFurloughNO() != null) {
				AttFurloughRecBO attfurloughrecbo1=attenceSetUCC.findAttFurloughRecBObyId(attfurloughrecbo.getFurloughNO());
				attfurloughrecbo1.setStatusValue("0");
				attenceSetUCC.saveAttFurloughRecBO(attfurloughrecbo1);
				WFTransaction wt = new WFTransaction();
				wt.setLinkID(attfurloughrecbo.getFurloughNO());
				wt.setOperID("0525");
				wt.setUser(super.getUserInfo());
				wt.setWfType(KQGL_LEAVE_VALUE);
				wt.setConValue(attfurloughrecbo1.getLastDate());  //请假天数
				wt.setStatusValue("0"); //审批状态
				wt.setWffunction("att_WorkFlowFurloughService");
				attenceSetUCC.processTrans(wt);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}
	
	public String getInitEdit2() {
		if(super.getRequestParameter("furloughNO") != null
				&& !super.getRequestParameter("furloughNO").equals("")){
			furloughNO = super.getRequestParameter("furloughNO");
		}
		doQuery();
		return initEdit2;
	}

	public void setInitEdit2(String initEdit2) {
		this.initEdit2 = initEdit2;
	}
	
	public List getPersBos3() {
		return persBos3;
	}

	public void setPersBos3(List persBos3) {
		this.persBos3 = persBos3;
	}

	public String doQuery(){
		try{
			if(persBos3!=null && persBos3.size()>0){
				persBos3=new ArrayList();
			}
			List list=attenceSetUCC.findAttFurloughRecBO(furloughNO);
			if(list!=null && list.size()>0){
				for(int i=0;i<list.size();i++){
					AttFurloughRecBO attfurloughrecbo=(AttFurloughRecBO)list.get(i);
					AttfurloughBO attfurloughbo1=(AttfurloughBO)attenceSetUCC.findAttfurloughBObyId(attfurloughrecbo.getFlID());
					attfurloughrecbo.setFlName(attfurloughbo1.getFlName());
					AttfurloughBO attfurloughbo2=(AttfurloughBO)attenceSetUCC.findAttfurloughBObyId(attfurloughrecbo.getFlIdProcess());
					attfurloughrecbo.setFlIdProcessName(attfurloughbo2.getFlName());
					if(attfurloughrecbo.getFlIdStatus()!=null && !"".equals(attfurloughrecbo.getFlIdStatus())){
						if("1".equals(attfurloughrecbo.getFlIdStatus())){
							attfurloughrecbo.setFlIdStatusName("是");
						}else{
							attfurloughrecbo.setFlIdStatusName("否");
						}
					}else{
						attfurloughrecbo.setFlIdStatusName("-");
					}
					if(attfurloughrecbo.getDeptAuditResult()!=null && !"".equals(attfurloughrecbo.getDeptAuditResult())){
						if("1".equals(attfurloughrecbo.getDeptAuditResult())){
							attfurloughrecbo.setDeptAuditCausevalue("同意");
						}else{
							attfurloughrecbo.setDeptAuditCausevalue("不同意");
						}
					}
					if(attfurloughrecbo.getLeaderAuditResult()!=null && !"".equals(attfurloughrecbo.getLeaderAuditResult())){
						if("1".equals(attfurloughrecbo.getLeaderAuditResult())){
							attfurloughrecbo.setLeaderAuditCausevalue("同意");
						}else{
							attfurloughrecbo.setLeaderAuditCausevalue("不同意");
						}
					}
					if(attfurloughrecbo.getHrAuditResult()!=null && !"".equals(attfurloughrecbo.getHrAuditResult())){
						if("1".equals(attfurloughrecbo.getHrAuditResult())){
							attfurloughrecbo.setHrAuditResultvalue("同意");
						}else{
							attfurloughrecbo.setHrAuditResultvalue("不同意");
						}
					}
					if(attfurloughrecbo.getZjAuditResult()!=null && !"".equals(attfurloughrecbo.getZjAuditResult())){
						if("1".equals(attfurloughrecbo.getZjAuditResult())){
							attfurloughrecbo.setZjAuditResultvalue("同意");
						}else{
							attfurloughrecbo.setZjAuditResultvalue("不同意");
						}
					}
					if(attfurloughrecbo.getZjlAuditResult()!=null && !"".equals(attfurloughrecbo.getZjlAuditResult())){
						if("1".equals(attfurloughrecbo.getZjAuditResult())){
							attfurloughrecbo.setZjlAuditResultvalue("同意");
						}else{
							attfurloughrecbo.setZjlAuditResultvalue("不同意");
						}
					}
					if(attfurloughrecbo.getSuperFlId()!=null && !"".equals(attfurloughrecbo.getSuperFlId())){
                        if("1".equals(attfurloughrecbo.getSuperFlId())){
							attfurloughrecbo.setSuperFlIdName(this.NORMAL_NAME);
						}else if("2".equals(attfurloughrecbo.getSuperFlId())){
							attfurloughrecbo.setSuperFlIdName(this.ADD_FURLOUGHREC_NAME);
						}else if("3".equals(attfurloughrecbo.getSuperFlId())){
							attfurloughrecbo.setSuperFlIdName(this.ESC_FURLOUGHREC_NAME);
						}
					}
					persBos3.add(attfurloughrecbo);
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
			if (furloughNO != null) {
				AttFurloughRecBO attfurloughrecbo=attenceSetUCC.findAttFurloughRecBObyId(furloughNO);
				attfurloughrecbo.setStatusValue("-1");
				attenceSetUCC.saveAttFurloughRecBO(attfurloughrecbo);
				WFProcessBO wfprocessbo=attenceSetUCC.findWFProcessBO(furloughNO);
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
	
	public String getStatus1() {
		return status1;
	}

	public void setStatus1(String status1) {
		this.status1 = status1;
	}

	public void changeStatus1(ValueChangeEvent event){
		   this.status1 = event.getNewValue().toString();
		}
	
	/*
	 * 确认证明
	 */
	public String makeDemonstrate(){
		try{
			AttFurloughRecBO attfurloughrecbo=attenceSetUCC.findAttFurloughRecBObyId(furloughNO);
			attfurloughrecbo.setFlIdProcess(attfurloughrecbo.getFlID());
			attfurloughrecbo.setFlIdStatus("1");
			attenceSetUCC.saveAttFurloughRecBO(attfurloughrecbo);
			List list=attenceSetUCC.findAttFurloughRecCollectBO(furloughNO);
			if(list!=null && list.size()>0){
				for(int i=0;i<list.size();i++){
					AttFurloughRecCollectBO attfurloughreccollectbo=(AttFurloughRecCollectBO)list.get(i);
					attfurloughreccollectbo.setFlID(attfurloughreccollectbo.getFlIdProcess());
					attfurloughreccollectbo.setFlIdStatus("1");
					attenceSetUCC.saveAttFurloughRecCollectBO(attfurloughreccollectbo);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
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

	public String getTypeStatus() {
		System.out.println("getTypeStatus="+typeStatus);
		return typeStatus;
	}

	public void setTypeStatus(String typeStatus) {
		System.out.println("setTypeStatus="+typeStatus);
		this.typeStatus = typeStatus;
	}

	public String getDateValue() {
		return dateValue;
	}

	public void setDateValue(String dateValue) {
		this.dateValue = dateValue;
	}

	public String getAvaDay() {
		return avaDay;
	}

	public void setAvaDay(String avaDay) {
		this.avaDay = avaDay;
	}

	public String getCriticalAvaDay() {
		return criticalAvaDay;
	}

	public void setCriticalAvaDay(String criticalAvaDay) {
		this.criticalAvaDay = criticalAvaDay;
	}

	public String getNetworkholidayvalue() {
		return networkholidayvalue;
	}

	public void setNetworkholidayvalue(String networkholidayvalue) {
		this.networkholidayvalue = networkholidayvalue;
	}

	public String getNetworkholidayvalue1() {
		return networkholidayvalue1;
	}

	public void setNetworkholidayvalue1(String networkholidayvalue1) {
		this.networkholidayvalue1 = networkholidayvalue1;
	}

	public String getBegindatevalueWdate1() {
		return begindatevalueWdate1;
	}

	public void setBegindatevalueWdate1(String begindatevalueWdate1) {
		this.begindatevalueWdate1 = begindatevalueWdate1;
	}

	public String getEnddatevalueWdate1() {
		return enddatevalueWdate1;
	}

	public void setEnddatevalueWdate1(String enddatevalueWdate1) {
		this.enddatevalueWdate1 = enddatevalueWdate1;
	}

	public String getDaySpan() {
		return daySpan;
	}

	public void setDaySpan(String daySpan) {
		this.daySpan = daySpan;
	}

	public String getItemIdValue() {
		return itemIdValue;
	}

	public void setItemIdValue(String itemIdValue) {
		this.itemIdValue = itemIdValue;
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

	public String getItemIdValue1() {
		return itemIdValue1;
	}

	public void setItemIdValue1(String itemIdValue1) {
		this.itemIdValue1 = itemIdValue1;
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
	
}
