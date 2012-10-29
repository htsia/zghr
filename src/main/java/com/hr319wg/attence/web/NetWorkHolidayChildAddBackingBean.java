package com.hr319wg.attence.web;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.faces.event.ValueChangeEvent;
import com.hr319wg.attence.pojo.bo.AttAnnualDetailAuditBO;
import com.hr319wg.attence.pojo.bo.AttAnnualDetailBO;
import com.hr319wg.attence.pojo.bo.AttAnnualItemBO;
import com.hr319wg.attence.pojo.bo.AttAnnualRecordBO;
import com.hr319wg.attence.pojo.bo.AttClassBO;
import com.hr319wg.attence.pojo.bo.AttenceSecondDayLogBO;
import com.hr319wg.attence.ucc.IAttAnnualUCC;
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
import com.hr319wg.util.SequenceGenerator;

public class NetWorkHolidayChildAddBackingBean extends BaseBackingBean {
	private String detailIdValue;
	private String itemIds;
	private String status;
	private String superID = super.getUserInfo().getOrgId();
	private List persBos1;
	private List persBos2 = new ArrayList();
	private String operID;
	private String initEdit1;
	private String initEdit2;
	private static String KQGL_YEAR_VALUE="KQGL_005";
	private AttAnnualDetailAuditBO bo=new AttAnnualDetailAuditBO();
	private AttAnnualDetailAuditBO bo1=new AttAnnualDetailAuditBO();
	private static String itemIdValues;
	private String initEdit;
	private String begindatevalue;
	private String begintimevalue;
	private String enddatevalue;
	private String endtimevalue;
	private String annDay;
	private String useDay;
	private String avaDay;
	private String daySpan;
	private String userid = super.getUserInfo().getUserId();
	private String personName = super.getUserInfo().getName();
	private String itemID;
	private List lists=new ArrayList();
	private String detailId;
	private String detailIds;
	private String pageInit;
	private IAttAnnualUCC attAnnualUcc;
	private PageVO mypage = new PageVO();
	private boolean isExist = false;
	private String groupvalue;
	private String cricalDate ;//临界日期
	private String cricalBefore ;//临界前休息天数
	private String cricalAfter ;//临界后休息天数
	private String yearStart  ; //年假开始日期
	private String yearEnd ;//年假结束日期
	private String begindatevalueWdate;
	private String enddatevalueWdate;
	private String deptID = super.getUserInfo().getDeptId();
    private IAttenceSetUCC attenceSetUCC;
    private String personValue;

    public String getPersonValue() {
        return personValue;
    }

    public void setPersonValue(String personValue) {
        this.personValue = personValue;
    }

    public IAttAnnualUCC getAttAnnualUcc() {
        return attAnnualUcc;
    }

    public void setAttAnnualUcc(IAttAnnualUCC attAnnualUcc) {
        this.attAnnualUcc = attAnnualUcc;
    }

    public boolean getIsExist() {
		return isExist;
	}

	public void setIsExist(boolean isExist) {
		this.isExist = isExist;
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
		if(lists!=null && lists.size()>0){
			lists=new ArrayList();
		}
		if (super.getRequestParameter("itemID") != null
				&& !super.getRequestParameter("itemID").equals("")) {
			itemID = super.getRequestParameter("itemID");
		}
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public String getDetailId() {
		return detailId;
	}

	public void setDetailId(String detailId) {
		this.detailId = detailId;
	}

	public List getLists() {
		return lists;
	}

	public void setLists(List lists) {
		this.lists = lists;
	}

	public String getItemID() {
		return itemID;
	}

	public void setItemID(String itemID) {
		this.itemID = itemID;
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
	
	public String getDetailIdValue() {
		return detailIdValue;
	}

	public void setDetailIdValue(String detailIdValue) {
		this.detailIdValue = detailIdValue;
	}

	public String getInitEdit() {
		try{
		if (super.getRequestParameter("itemId") != null && !super.getRequestParameter("itemId").equals("")) {
			itemIds = super.getRequestParameter("itemId");
			itemIdValues=itemIds;
			AttAnnualItemBO attannualitembo=attAnnualUcc.findAttAnnualItemBObyId(itemIds);
			if(attannualitembo!=null){
				annDay=attannualitembo.getAnnDay();
				useDay=attannualitembo.getUseDay();
				AttAnnualRecordBO attannualrecordbo = attAnnualUcc.findAttAnnualRecordBOById(attannualitembo.getRecID());
				
				if(attannualrecordbo != null){
					yearStart = attannualrecordbo.getYearBegin() ;  
				    yearEnd =  attannualrecordbo.getYearEnd();
				}
				
				//有临界日期
				cricalDate = attannualitembo.getCriticalDate() ;
				if(cricalDate != null && !"".equals(cricalDate)){
					String avgDate = attannualitembo.getAnnDay();
					if(avgDate == null || "".equals(avgDate)){
						avgDate = "0" ;
					}
					avaDay = "临界日期是"+cricalDate+"；当申请开始时间<="+cricalDate+"时，最多可休 "+ avgDate +" 天；当申请开始时间>"+cricalDate+" 时，最多可休假"+attannualitembo.getCriticalAvaDay()+" 天。";
				    cricalAfter = attannualitembo.getCriticalAnnDay(); //后
					cricalBefore = attannualitembo.getAnnDay();//临界前休息天数
				}else{
					avaDay = attannualitembo.getAvaDay();
					cricalAfter = "" ; //后
					cricalBefore = attannualitembo.getAnnDay();//临界后休息天数
				}
		    	begindatevalue="";
		    	begintimevalue="00:00";
		    	enddatevalue="";
		    	endtimevalue="23:59";
			}
		}else if (super.getRequestParameter("detailId") != null && !super.getRequestParameter("detailId").equals("")) {
			detailIdValue = super.getRequestParameter("detailId");
			bo=attAnnualUcc.findAttAnnualDetailAuditBObyId(detailIdValue);
			String a=bo.getHolidayBegin();
			String[] as=a.split(" ");
	    	begindatevalue=as[0];
	    	begintimevalue=as[1];
			String b=bo.getHolidayEnd();
			String[] bs=b.split(" ");
	    	enddatevalue=bs[0];
	    	endtimevalue=bs[1];
	    	daySpan=bo.getDaySpan();
	    	AttAnnualItemBO attannualitembo=attAnnualUcc.findAttAnnualItemBObyId(bo.getItemId());
			annDay=attannualitembo.getAnnDay();
			useDay=attannualitembo.getUseDay();
			avaDay=attannualitembo.getAvaDay();
			itemIds=bo.getItemId();
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
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

	public String getAnnDay() {
		return annDay;
	}

	public void setAnnDay(String annDay) {
		this.annDay = annDay;
	}

	public String getUseDay() {
		return useDay;
	}

	public void setUseDay(String useDay) {
		this.useDay = useDay;
	}

	public String getAvaDay() {
		return avaDay;
	}

	public void setAvaDay(String avaDay) {
		this.avaDay = avaDay;
	}

	public String getDaySpan() {
		return daySpan;
	}

	public void setDaySpan(String daySpan) {
		this.daySpan = daySpan;
	}

	public String getOperID() {
		return operID;
	}

	public void setOperID(String operID) {
		this.operID = operID;
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

	public String getItemIds() {
		return itemIds;
	}

	public void setItemIds(String itemIds) {
		this.itemIds = itemIds;
	}

	public String getDetailIds() {
		return detailIds;
	}

	public void setDetailIds(String detailIds) {
		this.detailIds = detailIds;
	}

	public AttAnnualDetailAuditBO getBo1() {
		return bo1;
	}

	public void setBo1(AttAnnualDetailAuditBO bo1) {
		this.bo1 = bo1;
	}

	public String getInitEdit1() {
		if (super.getRequestParameter("OperID") != null
				&& !super.getRequestParameter("OperID").equals("")) {
			operID = super.getRequestParameter("OperID");
		}
		if (persBos2 != null) {
			persBos2 = new ArrayList();
		}
		doQueryAudit();
		return initEdit1;
	}

	public void setInitEdit1(String initEdit1) {
		this.initEdit1 = initEdit1;
	}

	public String getInitEdit2() {
		try {
			if (super.getRequestParameter("detailId") != null
					&& !super.getRequestParameter("detailId").equals("") && super.getRequestParameter("operID") != null
					&& !super.getRequestParameter("operID").equals("")) {
				operID=super.getRequestParameter("operID");
				detailIds = super.getRequestParameter("detailId");
				bo1=attAnnualUcc.findAttAnnualDetailAuditBObyId(detailIds);
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
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	return initEdit2;
	}

	public void setInitEdit2(String initEdit2) {
		this.initEdit2 = initEdit2;
	}

	public AttAnnualDetailAuditBO getBo() {
		return bo;
	}

	public void setBo(AttAnnualDetailAuditBO bo) {
		this.bo = bo;
	}

	public String getSuperID() {
		return superID;
	}

	public void setSuperID(String superID) {
		this.superID = superID;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String doQuery() {
		try {
			groupvalue=attAnnualUcc.getA001737(userid);
			List listvalue = attAnnualUcc.getAttAnnualDetailAuditBO(itemID);
			if (listvalue != null && listvalue.size() > 0) {
				for (int i = 0; i < listvalue.size(); i++) {
					AttAnnualDetailAuditBO attannualdetailauditbo=(AttAnnualDetailAuditBO)listvalue.get(i);
				  if(attannualdetailauditbo.getFurloughno()!=null && !"".equals(attannualdetailauditbo.getFurloughno())){
					  
				  }else{
						if(attannualdetailauditbo.getDeptAuditResult()!=null && !"".equals(attannualdetailauditbo.getDeptAuditResult())){
							if("1".equals(attannualdetailauditbo.getDeptAuditResult())){
								attannualdetailauditbo.setDeptAuditCausevalue("同意");
							}else{
								attannualdetailauditbo.setDeptAuditCausevalue("不同意");
							}
						}
						if(attannualdetailauditbo.getLeaderAuditResult()!=null && !"".equals(attannualdetailauditbo.getLeaderAuditResult())){
							if("1".equals(attannualdetailauditbo.getLeaderAuditResult())){
								attannualdetailauditbo.setLeaderAuditCausevalue("同意");
							}else{
								attannualdetailauditbo.setLeaderAuditCausevalue("不同意");
							}
						}
						if(attannualdetailauditbo.getHrAuditResult()!=null && !"".equals(attannualdetailauditbo.getHrAuditResult())){
							if("1".equals(attannualdetailauditbo.getHrAuditResult())){
								attannualdetailauditbo.setHrAuditResultvalue("同意");
							}else{
								attannualdetailauditbo.setHrAuditResultvalue("不同意");
							}
						}
						if(attannualdetailauditbo.getHileaderAuditResult()!=null && !"".equals(attannualdetailauditbo.getHileaderAuditResult())){
							if("1".equals(attannualdetailauditbo.getHileaderAuditResult())){
								attannualdetailauditbo.setHileaderAuditResultvalue("同意");
							}else{
								attannualdetailauditbo.setHileaderAuditResultvalue("不同意");
							}
						}
						if(attannualdetailauditbo.getManAuditResult()!=null && !"".equals(attannualdetailauditbo.getManAuditResult())){
							if("1".equals(attannualdetailauditbo.getManAuditResult())){
								attannualdetailauditbo.setManAuditResultvalue("同意");
							}else{
								attannualdetailauditbo.setManAuditResultvalue("不同意");
							}
						}
						lists.add(attannualdetailauditbo);
				  }
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "";
		}	
	
	/*
	 * 年假删除
	 */
	public String delete(){
		try{
			if (detailId != null) {
				attAnnualUcc.deleteAttAnnualDetailAuditBO(detailId);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	/*
	 * 确认
	 */
	public String makesure() {
		try{
			String oldClassValue=attAnnualUcc.getA001737(userid);
			String[] begindatevalueWdatestrs=begindatevalueWdate.split(" ");
			begindatevalue=begindatevalueWdatestrs[0];
			begintimevalue=begindatevalueWdatestrs[1];
			String[] enddatevalueWdatestrs=enddatevalueWdate.split(" ");
			enddatevalue=enddatevalueWdatestrs[0];
			endtimevalue=enddatevalueWdatestrs[1];
		if(!begindatevalue.equals(enddatevalue)){
			float sum=0;
			AttClassBO beginattclassbo=attenceSetUCC.changeWork1(userid,superID,oldClassValue,begindatevalue);
			if(beginattclassbo!=null){
				if("1".equals(beginattclassbo.getClassID())){
						sum+=0;
				}else if("2".equals(beginattclassbo.getClassID())){
						sum+=0;	
				}else if("3".equals(beginattclassbo.getClassID())){
						sum+=0;
				}else{
					String str=attenceSetUCC.cacldays(userid,begintimevalue,beginattclassbo);
					float a=Float.parseFloat(str);
					sum+=a;
				}
			}else{
					sum+=0;
			}
			
			
			
			List lists=attenceSetUCC.getCaclDay(begindatevalue,enddatevalue);
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
			
			AttClassBO beginattclassbo1=attenceSetUCC.changeWork1(userid,superID,oldClassValue,enddatevalue);
			if(beginattclassbo1!=null){
				if("1".equals(beginattclassbo1.getClassID())){
						sum+=0;
				}else if("2".equals(beginattclassbo1.getClassID())){
						sum+=0;
				}else if("3".equals(beginattclassbo1.getClassID())){
						sum+=0;
				}else{
					String str=attenceSetUCC.cacldays1(userid,endtimevalue,beginattclassbo1);
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
			AttClassBO beginattclassbo=attenceSetUCC.changeWork1(userid,superID,oldClassValue,begindatevalue);
			if(beginattclassbo!=null){
				if("1".equals(beginattclassbo.getClassID())){
						sum1+=0;
				}else if("2".equals(beginattclassbo.getClassID())){
						sum1+=0;
				}else if("3".equals(beginattclassbo.getClassID())){
						sum1+=0;
				}else{
					String str=attenceSetUCC.cacldays(userid,begintimevalue,beginattclassbo);
					float a=Float.parseFloat(str);
					sum1+=a;
				}
			}else{
					sum1+=0;
			}
			
			AttClassBO beginattclassbo1=attenceSetUCC.changeWork1(userid,superID,oldClassValue,enddatevalue);
			if(beginattclassbo1!=null){
				if("1".equals(beginattclassbo1.getClassID())){
						sum2+=0;
				}else if("2".equals(beginattclassbo1.getClassID())){
						sum2+=0;
				}else if("3".equals(beginattclassbo1.getClassID())){
						sum2+=0;
				}else{
					String str=attenceSetUCC.cacldays(userid,endtimevalue,beginattclassbo1);
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
	 * 年假申请
	 */
	public String save(){
		try{
			SimpleDateFormat ds = new SimpleDateFormat("yyyy-MM-dd");
			Date begain = ds.parse(yearStart);
			Date end = ds.parse(yearEnd);
			Calendar caBegain = Calendar.getInstance();//年度开始日期
			Calendar caEnd = Calendar.getInstance();//年度结束日期
			caBegain.setTime(begain);
			caEnd.setTime(end);
			
			Calendar beCalendar = Calendar.getInstance();//休假开始日期
			Calendar endCalendar = Calendar.getInstance();//休假结束日期
			if(begindatevalue!=null && !"".equals(begindatevalue) && enddatevalue!=null && !"".equals(enddatevalue)){
			 Date attBegain = ds.parse(begindatevalue);
			 beCalendar.setTime(attBegain);
			 Date attEnd = ds.parse(enddatevalue);
			 endCalendar.setTime(attEnd);
			}else{
				super.showMessageDetail("您申请年假的开始日期或结束日期为空！");
				return "";
			}
			
			if(!beCalendar.after(caBegain) || ! beCalendar.before(caEnd) ){//申请开始日期
				super.showMessageDetail("您申请年假的开始年假日期超出了本年度范围！");
				return "";
			}
			if(!endCalendar.after(caBegain) || ! endCalendar.before(caEnd) ){//申请结束日期
				super.showMessageDetail("您申请年假的年假的结束日期超出本年度范围。");
				return "";
			}
			
			String statusValue=attenceSetUCC.findAttAnnualDetailAuditBOStatusValue(userid);
			if(statusValue!=null && !"".endsWith(statusValue)){
				super.showMessageDetail("您申请年假的历史列表中，有未审批通过的记录，即本次不能申请。");
				return "";
			}
			float avadayfloat=0;//临界前休假
			float dayspanfloat=0;//实际申请天数
			float hou  =0 ;//临界日期后休假天数
			
			if(cricalBefore!=null && !"".equals(cricalBefore)){
				avadayfloat=Float.parseFloat(cricalBefore);//临界前休假
			}
			if(daySpan!=null && !"".equals(daySpan)){//申请天数
				dayspanfloat=Float.parseFloat(daySpan);
			}
		    if(cricalAfter != null && !"".equals(cricalAfter)){
		    	hou = Float.parseFloat(cricalAfter);//临界日期后休假天数
		    }
			 
			
			
			
			
			
			
			//存在临界日期
			if(cricalDate!= null && !"".equals(cricalDate)){//在有临界日期的情况下直接和应该应休天数比较和临界后日期有天数比较
				Date  date1 = ds.parse(cricalDate);
				Calendar cricalDt = Calendar.getInstance();
				cricalDt.setTime(date1);
				
				if(beCalendar.after(cricalDt)){//申请的年假日期在临界日期之后 
					if(dayspanfloat > hou  ){
						super.showMessageDetail("你申请的年假天数，超出了临界日期后的休假范围！");
						return "" ;
					}else if(dayspanfloat < hou){
						super.showMessageDetail("你申请的年假天数，在临界日期后的休假范围内，必须一次性申请完毕！");
						return "" ;
					}
				}else{//申请的年假日期在临界日期之前
					if(cricalBefore == null || "".equals(cricalBefore)||"0".equals(cricalBefore)){
						super.showMessageDetail("在临界日期之前您没有可用的休假天数。");
						return "" ;
					}
					if(dayspanfloat > avadayfloat){
						super.showMessageDetail("你申请的年假天数，超出了临界日期前的休假范围！");
						return "" ;
					}else if(dayspanfloat < avadayfloat){
						super.showMessageDetail("你申请的年假天数，在临界日期后的休假范围内，必须一次性申请完毕！");
						return "" ;
					}
				}
			}else{//没有临界日期的情况下直接和应该应休天数比较
				if(dayspanfloat > avadayfloat){
					super.showMessageDetail(" 休假天数超过了最大休假值。");
					return "" ;
				}else if(dayspanfloat < avadayfloat){
					super.showMessageDetail("你申请的年假天数，在休假范围内，必须一次性申请完毕！");
					return "" ;
				}
			}
				bo.setItemId(itemIds);
				bo.setPersonID(userid);
				String begindate=begindatevalue+" "+begintimevalue;
				bo.setHolidayBegin(begindate);
				String enddate=enddatevalue+" "+endtimevalue;
				bo.setHolidayEnd(enddate);
				bo.setDaySpan(daySpan);
				bo.setStatusValue("-1");
				attenceSetUCC.saveorupdateAttAnnualDetailAuditBO(bo);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	
	/*
	 * 报批
	 */
	public String saveoraudit(){
		try{
			if (detailId != null) {
				AttAnnualDetailAuditBO attannualdetailauditbo=this.attAnnualUcc.findAttAnnualDetailAuditBObyId(detailId);
				attannualdetailauditbo.setStatusValue("0");
				attenceSetUCC.saveorupdateAttAnnualDetailAuditBO(attannualdetailauditbo);
				WFTransaction wt = new WFTransaction();
				wt.setLinkID(detailId);
				wt.setOperID("0525");
				wt.setUser(super.getUserInfo());
				wt.setWfType(KQGL_YEAR_VALUE);
				wt.setConValue(attannualdetailauditbo.getDaySpan());  //年假天数
				wt.setStatusValue("0"); //审批状态
				wt.setWffunction("att_WorkFlowNetWorkHolidayService");
				attenceSetUCC.processTrans(wt);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	/*
	 * 年假申请，并报批。
	 */
	public String saveAndAudit(){
		try{
			SimpleDateFormat ds = new SimpleDateFormat("yyyy-MM-dd");
			Date begain = ds.parse(yearStart);
			Date end = ds.parse(yearEnd);
			Calendar caBegain = Calendar.getInstance();//年度开始日期
			Calendar caEnd = Calendar.getInstance();//年度结束日期
			caBegain.setTime(begain);
			caEnd.setTime(end);
			
			Calendar beCalendar = Calendar.getInstance();//休假开始日期
			Calendar endCalendar = Calendar.getInstance();//休假结束日期
			if(begindatevalue!=null && !"".equals(begindatevalue) && enddatevalue!=null && !"".equals(enddatevalue)){
			 Date attBegain = ds.parse(begindatevalue);
			 beCalendar.setTime(attBegain);
			 Date attEnd = ds.parse(enddatevalue);
			 endCalendar.setTime(attEnd);
			}else{
				super.showMessageDetail("您申请年假的开始日期或结束日期为空。");
				return "";
			}
			
			if(!beCalendar.after(caBegain) || ! beCalendar.before(caEnd) ){//申请开始日期
				super.showMessageDetail("您申请年假的开始年假日期超出了本年度范围。");
				return "";
			}
			if(!endCalendar.after(caBegain) || ! endCalendar.before(caEnd) ){//申请结束日期
				super.showMessageDetail("您申请年假的结束年假日期超出了本年度范围。");
				return "";
			}
			
			String statusValue=attenceSetUCC.findAttAnnualDetailAuditBOStatusValue(userid);
			if(statusValue!=null && !"".endsWith(statusValue)){
				super.showMessageDetail("您申请年假的历史列表中，有未审批通过的记录，即本次不能申请。");
				return "";
			}
			float avadayfloat=0;//临界前休假
			float dayspanfloat=0;//实际申请天数
			float hou  =0 ;//临界日期后休假天数
			
			if(cricalBefore!=null && !"".equals(cricalBefore)){
				avadayfloat=Float.parseFloat(cricalBefore);//临界前休假
			}
			if(daySpan!=null && !"".equals(daySpan)){//申请天数
				dayspanfloat=Float.parseFloat(daySpan);
			}
		    if(cricalAfter != null && !"".equals(cricalAfter)){
		    	hou = Float.parseFloat(cricalAfter);//临界日期后休假天数
		    }
			 
			
			
			
			
			
			
			//存在临界日期
			if(cricalDate!= null && !"".equals(cricalDate)){//在有临界日期的情况下直接和应该应休天数比较和临界后日期有天数比较
				Date  date1 = ds.parse(cricalDate);
				Calendar cricalDt = Calendar.getInstance();
				cricalDt.setTime(date1);
				
				if(beCalendar.after(cricalDt)){//申请的年假日期在临界日期之后 
					if(dayspanfloat > hou  ){
						super.showMessageDetail("你申请的年假天数，超出了临界日期后的休假范围！");
						return "" ;
					}else if(dayspanfloat < hou){
						super.showMessageDetail("你申请的年假天数，在临界日期后的休假范围内，必须一次性申请完毕！");
						return "" ;
					}
				}else{//申请的年假日期在临界日期之前
					if(cricalBefore == null || "".equals(cricalBefore)||"0".equals(cricalBefore)){
						super.showMessageDetail("在临界日期之前您没有可用的休假天数。");
						return "" ;
					}
					if(dayspanfloat > avadayfloat){
						super.showMessageDetail("你申请的年假天数，超出了临界日期前的休假范围！");
						return "" ;
					}else if(dayspanfloat < avadayfloat){
						super.showMessageDetail("你申请的年假天数，在临界日期后的休假范围内，必须一次性申请完毕！");
						return "" ;
					}
				}
			}else{//没有临界日期的情况下直接和应该应休天数比较
				if(dayspanfloat > avadayfloat){
					super.showMessageDetail(" 休假天数超过了最大休假值。");
					return "" ;
				}else if(dayspanfloat < avadayfloat){
					super.showMessageDetail("你申请的年假天数，在休假范围内，必须一次性申请完毕！");
					return "" ;
				}
			}
				bo.setItemId(itemIds);
				bo.setPersonID(userid);
				String begindate=begindatevalue+" "+begintimevalue;
				bo.setHolidayBegin(begindate);
				String enddate=enddatevalue+" "+endtimevalue;
				bo.setHolidayEnd(enddate);
				bo.setDaySpan(daySpan);
				bo.setStatusValue("-1");
				attenceSetUCC.saveorupdateAttAnnualDetailAuditBO(bo);
			
				if (bo.getDetailId() != null) {
					AttAnnualDetailAuditBO attannualdetailauditbo=this.attAnnualUcc.findAttAnnualDetailAuditBObyId(bo.getDetailId());
					attannualdetailauditbo.setStatusValue("0");
					attenceSetUCC.saveorupdateAttAnnualDetailAuditBO(attannualdetailauditbo);
					WFTransaction wt = new WFTransaction();
					wt.setLinkID(bo.getDetailId());
					wt.setOperID("0525");
					wt.setUser(super.getUserInfo());
					wt.setWfType(KQGL_YEAR_VALUE);
					wt.setConValue(attannualdetailauditbo.getDaySpan());  //年假天数
					wt.setStatusValue("0"); //审批状态
					wt.setWffunction("att_WorkFlowNetWorkHolidayService");
					attenceSetUCC.processTrans(wt);
				}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	
	/*
	 * 审批
	 */
	public String doQueryAudit(){
		PersonBO person=null;
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
            if(null==personValue){
                personValue="";
            }
			persBos1 = attenceSetUCC.getAttAnnualDetailAuditBO(superID,mypage,isExist,operID,deptID,super.getUserInfo(),personValue);
			if (persBos1 != null && persBos1.size() > 0) {
			  if(isExist){
				for (int j = 0; j < persBos1.size(); j++) {
					AttAnnualDetailAuditBO attannualdetailauditbo=(AttAnnualDetailAuditBO)persBos1.get(j);
					person =SysCacheTool.findPersonById(attannualdetailauditbo.getPersonID());
					attannualdetailauditbo.setPersonName(person.getName());
					WFNodeBO currentnode = attenceSetUCC
					.getCurrentNode(attannualdetailauditbo.getDetailId());
			      if (currentnode != null) {
				      if (currentnode.getOperID().equals(operID)) {
					   attannualdetailauditbo.setFlagvalue("yes");
				      } else {
					   attannualdetailauditbo.setFlagvalue("no");
				      }
			       }
			       persBos2.add(attannualdetailauditbo);
			   }
			  }else{
					for (int j = 0; j < persBos1.size(); j++) {
						AttAnnualDetailAuditBO attannualdetailauditbo=(AttAnnualDetailAuditBO)persBos1.get(j);
						WFNodeBO currentnode = attenceSetUCC
						.getCurrentNode(attannualdetailauditbo.getDetailId());
				        if (currentnode != null) {
					       if (currentnode.getOperID().equals(operID)) {
						person =SysCacheTool.findPersonById(attannualdetailauditbo.getPersonID());
						attannualdetailauditbo.setPersonName(person.getName());
						attannualdetailauditbo.setFlagvalue("yes");
				       persBos2.add(attannualdetailauditbo);
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
  * 部门经理审批年假
  */
	public String saveoraudit1(){
		if("1".equals(status)){
			bo1.setStatusValue("1");
		}else if("2".equals(status)){
			bo1.setStatusValue("2");
		}
		bo1.setDeptAuditResult(status);
		bo1.setDeptAuditOper(personName);
		bo1.setDeptAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try{
			attenceSetUCC.saveorupdateAttAnnualDetailAuditBO(bo1);
			WFTransaction wt = new WFTransaction();
			wt.setLinkID(bo1.getDetailId());
			wt.setOperID(operID);
			wt.setUser(super.getUserInfo());
			wt.setWfType(KQGL_YEAR_VALUE);
			wt.setConValue(bo1.getDaySpan());  //年假天数
			wt.setStatusValue(status); //审批状态
			wt.setWffunction("att_WorkFlowNetWorkHolidayService");
			attenceSetUCC.processTrans(wt);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	
	/*
	 * 主管领导审批年假
	 */
	public String saveoraudit2(){
		if("1".equals(status)){
			bo1.setStatusValue("1");
		}else if("2".equals(status)){
			bo1.setStatusValue("2");
		}
		bo1.setLeaderAuditResult(status);
		bo1.setLeaderAuditOper(personName);
		bo1.setLeaderAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try{
			attenceSetUCC.saveorupdateAttAnnualDetailAuditBO(bo1);
			WFTransaction wt = new WFTransaction();
			wt.setLinkID(bo1.getDetailId());
			wt.setOperID(operID);
			wt.setUser(super.getUserInfo());
			wt.setWfType(KQGL_YEAR_VALUE);
			wt.setConValue(bo1.getDaySpan());  //年假天数
			wt.setStatusValue(status); //审批状态
			wt.setWffunction("att_WorkFlowNetWorkHolidayService");
			attenceSetUCC.processTrans(wt);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	
	/*
	 * 人力资源审批年假
	 */
	public String saveoraudit3(){
		if("1".equals(status)){
			bo1.setStatusValue("3");
		}else if("2".equals(status)){
			bo1.setStatusValue("2");
		}
		bo1.setHrAuditResult(status);
		bo1.setHrAuditOper(personName);
		bo1.setHrAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try{
			attenceSetUCC.saveorupdateAttAnnualDetailAuditBO(bo1);
			WFTransaction wt = new WFTransaction();
			wt.setLinkID(bo1.getDetailId());
			wt.setOperID(operID);
			wt.setUser(super.getUserInfo());
			wt.setWfType(KQGL_YEAR_VALUE);
			wt.setConValue(bo1.getDaySpan());  //年假天数
			wt.setStatusValue(status); //审批状态
			wt.setWffunction("att_WorkFlowNetWorkHolidayService");
			attenceSetUCC.processTrans(wt);
		  }catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	/*
	 *总监审批结果 
	 */
	public String saveoraudit4(){
		if("1".equals(status)){
			bo1.setStatusValue("1");
		}else if("2".equals(status)){
			bo1.setStatusValue("2");
		}
		bo1.setHileaderAuditResult(status);
		bo1.setHileaderAuditOper(personName);
		bo1.setHileaderAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try {
			attenceSetUCC.saveorupdateAttAnnualDetailAuditBO(bo1);
			WFTransaction wt = new WFTransaction();
			wt.setLinkID(bo1.getDetailId());
			//wt.setOperID("0530");
			wt.setOperID(operID);
			wt.setUser(super.getUserInfo());
			wt.setWfType(KQGL_YEAR_VALUE);
			wt.setConValue(bo1.getDaySpan());  //年假天数
			wt.setStatusValue(status); //审批状态
			wt.setWffunction("att_WorkFlowNetWorkHolidayService");
			attenceSetUCC.processTrans(wt);
			} catch (SysException e) {
				e.printStackTrace();
			}
		return "success";
	}
	/*
	 *总经理审批结果 
	 */
	public String saveoraudit5(){
		if("1".equals(status)){
			bo1.setStatusValue("1");
		}else if("2".equals(status)){
			bo1.setStatusValue("2");
		}
		bo1.setManAuditResult(status);
		bo1.setManAuditOper(personName);
		bo1.setManAuditDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
		try {
			attenceSetUCC.saveorupdateAttAnnualDetailAuditBO(bo1);
			WFTransaction wt = new WFTransaction();
			wt.setLinkID(bo1.getDetailId());
			//wt.setOperID("0530");
			wt.setOperID(operID);
			wt.setUser(super.getUserInfo());
			wt.setWfType(KQGL_YEAR_VALUE);
			wt.setConValue(bo1.getDaySpan());  //年假天数
			wt.setStatusValue(status); //审批状态
			wt.setWffunction("att_WorkFlowNetWorkHolidayService");
			attenceSetUCC.processTrans(wt);
			} catch (SysException e) {
				e.printStackTrace();
			}
		return "success";
	}
	public void changeNowYearValue(ValueChangeEvent event){
        this.isExist="true".equals(event.getNewValue().toString());
        getInitEdit1();
    }
	
	public void changeStatus(ValueChangeEvent event){
		   this.status = event.getNewValue().toString();
		}
	
	/*
	 * 天数区间集合计算
	 */
	public String cacl(AttAnnualDetailBO attannualdetailbo,AttAnnualItemBO attannualitembo) {
		try{
			String holidaybegin=attannualdetailbo.getHolidayBegin();
			String holidayend=attannualdetailbo.getHolidayEnd();
			String[] holidaybegins=holidaybegin.split(" ");
			String[] holidayends=holidayend.split(" ");
			String beginTime=holidaybegins[0];
			String endTime=holidayends[0];
			String beginyear = beginTime.substring(0, 4);
			String beginmonth = beginTime.substring(5, 7);
			String beginday = beginTime.substring(8, 10);
			String beginday1 = beginTime.substring(8, 9);
			String beginday2 = beginTime.substring(9, 10);
			String endTimeyear = endTime.substring(0, 4);
			String endTimemonth = endTime.substring(5, 7);
			String endTimeday = endTime.substring(8, 10);
			String endTimeday1 = endTime.substring(8, 9);
			String endTimeday2 = endTime.substring(9, 10);
			List lists = new ArrayList();
			if (!beginmonth.equals(endTimemonth)) {
				int m = 0;
				int n = 0;
				if (!"0".equals(beginday1)) {
					m = Integer.parseInt(beginday);
				} else {
					m = Integer.parseInt(beginday2);
				}
				if (!"0".equals(endTimeday1)) {
					n = Integer.parseInt(endTimeday);
				} else {
					n = Integer.parseInt(endTimeday2);
				}
				Integer.parseInt(endTimeday2);
				int mn = MonthDays(Integer.parseInt(beginmonth), Integer
						.parseInt(beginmonth));
				for (int i = m; i <= mn; i++) {
					String datevalue = new String();
					if (i >= 10) {
						datevalue = beginyear + "-" + beginmonth + "-" + i;
					} else {
						datevalue = beginyear + "-" + beginmonth + "-0" + i;
					}
					String ymd=datevalue;
					lists.add(ymd);
				}
				List lists1 = new ArrayList();
				for (int i = 1; i <= n; i++) {
					String datevalue = new String();
					if (i >= 10) {
						datevalue = endTimeyear + "-" + endTimemonth + "-" + i;
					} else {
						datevalue = endTimeyear + "-" + endTimemonth + "-0" + i;
					}
					String ymd=datevalue;
					lists1.add(ymd);
				}
				lists.addAll(lists1);
			} else {
				int m = 0;
				int n = 0;
				if (!"0".equals(beginday1)) {
					m = Integer.parseInt(beginday);
				} else {
					m = Integer.parseInt(beginday2);
				}
				if (!"0".equals(endTimeday1)) {
					n = Integer.parseInt(endTimeday);
				} else {
					n = Integer.parseInt(endTimeday2);
				}
				for (int i = m; i <= n; i++) {
					String datevalue = new String();
					if (i >= 10) {
						datevalue = beginyear + "-" + beginmonth + "-" + i;
					} else {
						datevalue = beginyear + "-" + beginmonth + "-0" + i;
					}
					String ymd=datevalue;
					lists.add(ymd);
				}
			}
			
			//向日分汇总A807数据表中，添加年假信息值。
			if(lists!=null && lists.size()>0){
				for(int j=0;j<lists.size();j++){
					String daysss=(String)lists.get(j);
					attenceSetUCC.deleteAttenceSecondDayLogBO(attannualitembo.getPersonID(),daysss);//先删除
					AttenceSecondDayLogBO attenceseconddaylogbo=new AttenceSecondDayLogBO();
					attenceseconddaylogbo.setPersonId(attannualitembo.getPersonID());
					attenceseconddaylogbo.setSubID(SequenceGenerator.getKeyId("A807"));
					attenceseconddaylogbo.setRecord(Constants.NO);
					attenceseconddaylogbo.setSecondDay("1");
					attenceseconddaylogbo.setAttenceDate(daysss);
					attenceseconddaylogbo.setRealityTime("0");
					attenceseconddaylogbo.setShouldTime("1");
					attenceseconddaylogbo.setAttenceRate("0");
					attenceseconddaylogbo.setLeaveYear("1");
					attenceSetUCC.saveAttenceSecondDayLogBO(attenceseconddaylogbo);//后增加，避免重复数据的添加
				}
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
			return "";
		}
	
	public static boolean LeapYear(int year) {
		if (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) {
			return true;
		} else {
			return false;
		}
	}

	public static int MonthDays(int Month, int year) {
		switch (Month) {
		case 1:
		case 3:
		case 5:
		case 7:
		case 8:
		case 10:
		case 12:
			return 31;
		case 2:
			if (LeapYear(year)) {
				return 29;
			} else {
				return 28;
			}
		default:
			return 30;

		}
	}

	public String getGroupvalue() {
		return groupvalue;
	}

	public void setGroupvalue(String groupvalue) {
		this.groupvalue = groupvalue;
	}

	public String getCricalDate() {
		return cricalDate;
	}

	public void setCricalDate(String cricalDate) {
		this.cricalDate = cricalDate;
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
	
}
