package com.hr319wg.attence.web;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.hr319wg.attence.pojo.bo.AttExistRestBO;
import com.hr319wg.attence.pojo.bo.AttPersonArrangeBO;
import com.hr319wg.attence.pojo.bo.AttPersonArrangeItemBO;
import com.hr319wg.attence.pojo.bo.AttenceStandBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;

public class AutoRearrangeListBackingBean extends BaseBackingBean {
	private String monthCalendar;
	private String monthFeast;
	private String monthRest;
	private String monthShouldDay;
	private String orgId=super.getUserInfo().getOrgId();
	private List dateList=new ArrayList();
	private String initEdit;
	private String forecastWater;
	private String standWork;
	private String personNumber;;
	private String personNumbers;
	private String personEfficiency;
	private String workPersonRates;
	private String arrangeId;
	private String arrangeId1;
	private String pageInit;
	private IAttenceSetUCC attenceSetUCC;
	private boolean isExist=true;
	
	public boolean getIsExist() {
		return isExist;
	}

	public void setIsExist(boolean isExist) {
		this.isExist = isExist;
	}
	
	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}

	public String getPageInit() {
		if (super.getRequestParameter("arrangeId") != null && !super.getRequestParameter("arrangeId").equals("")) {
			arrangeId = super.getRequestParameter("arrangeId");
		}
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public String getArrangeId() {
		return arrangeId;
	}

	public void setArrangeId(String arrangeId) {
		this.arrangeId = arrangeId;
	}
	
	public String getInitEdit() {
		if (super.getRequestParameter("arrangeId") != null && !super.getRequestParameter("arrangeId").equals("")) {
			arrangeId1 = super.getRequestParameter("arrangeId");
		}
		existRest();
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public String getArrangeId1() {
		return arrangeId1;
	}

	public void setArrangeId1(String arrangeId1) {
		this.arrangeId1 = arrangeId1;
	}

	public List getDateList() {
		return dateList;
	}

	public void setDateList(List dateList) {
		this.dateList = dateList;
	}

	public String getForecastWater() {
		return forecastWater;
	}

	public void setForecastWater(String forecastWater) {
		this.forecastWater = forecastWater;
	}

	public String getStandWork() {
		return standWork;
	}

	public void setStandWork(String standWork) {
		this.standWork = standWork;
	}

	public String getPersonNumber() {
		return personNumber;
	}

	public void setPersonNumber(String personNumber) {
		this.personNumber = personNumber;
	}

	public String getPersonNumbers() {
		return personNumbers;
	}

	public void setPersonNumbers(String personNumbers) {
		this.personNumbers = personNumbers;
	}

	public void setExist(boolean isExist) {
		this.isExist = isExist;
	}

	public String getPersonEfficiency() {
		return personEfficiency;
	}

	public void setPersonEfficiency(String personEfficiency) {
		this.personEfficiency = personEfficiency;
	}

	public String getWorkPersonRates() {
		return workPersonRates;
	}

	public void setWorkPersonRates(String workPersonRates) {
		this.workPersonRates = workPersonRates;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String getMonthCalendar() {
		return monthCalendar;
	}

	public void setMonthCalendar(String monthCalendar) {
		this.monthCalendar = monthCalendar;
	}

	public String getMonthFeast() {
		return monthFeast;
	}

	public void setMonthFeast(String monthFeast) {
		this.monthFeast = monthFeast;
	}

	public String getMonthRest() {
		return monthRest;
	}

	public void setMonthRest(String monthRest) {
		this.monthRest = monthRest;
	}

	public String getMonthShouldDay() {
		return monthShouldDay;
	}

	public void setMonthShouldDay(String monthShouldDay) {
		this.monthShouldDay = monthShouldDay;
	}

	public void doQuery() {
		try {
			AttPersonArrangeBO attpersonarrangebo=attenceSetUCC.findAttPersonArrangeBObyId(arrangeId);
			if("-1".equals(attpersonarrangebo.getStatus().trim())){
				isExist=false;
			}else if("0".equals(attpersonarrangebo.getStatus().trim())){
				isExist=true;
			}else if("9".equals(attpersonarrangebo.getStatus().trim())){
				isExist=true;
			}

			super.getHttpSession().removeAttribute("lists");
			super.getHttpSession().removeAttribute("lists1");
			cacl(attpersonarrangebo);
			
			//预计流水值: 直接取B738701
			String ymd=attpersonarrangebo.getDuraYear()+"-"+attpersonarrangebo.getDuraMonth();
			forecastWater=attenceSetUCC.selectB738(attpersonarrangebo.getOrgId(),ymd);//流水情况
			
			//标准劳效: 直接取标准劳效(B737701)  定编人数: 直接取定编人数(B737702)
			List attencestandbolists=attenceSetUCC.findAttenceStandBO2(attpersonarrangebo.getOrgId());//标准劳效和定编人数
			if(attencestandbolists!=null && attencestandbolists.size()>0){
				AttenceStandBO attencestandbos=(AttenceStandBO)attencestandbolists.get(0);
				standWork=attencestandbos.getStandWork();//标准劳效
				personNumber=attencestandbos.getPersonNumber();//定编人数
			}
			
			//实际人数：对应班组的人数
			List personGroupLists=attenceSetUCC.findPersonsAttClassGroupVO(attpersonarrangebo.getGroupId());//在编人数
			personNumbers=""+personGroupLists.size();
			
			// 排班表出勤率：每天的出勤人数加和/（实际人数*当月天数）*100%
			String personEfficiency1="";
			String totalPersons=attenceSetUCC.countAttPersonArrangeItemBOEfficiency(arrangeId);
			int total=Integer.parseInt(totalPersons);
			if(total>0){
				String workPersons=attenceSetUCC.countAttPersonArrangeItemBOEfficiency1(arrangeId);
				float attenceRate=0;
				float totalPersonRate=0;
				float workPersonRate=0;
				totalPersonRate=Float.parseFloat(totalPersons);
				workPersonRate=Float.parseFloat(workPersons);
				attenceRate = new BigDecimal(workPersonRate * 100).divide(new BigDecimal(totalPersonRate),2,BigDecimal.ROUND_HALF_UP).floatValue();
				attenceRate = (float) (Math.round(attenceRate * 100)) / 100;
				personEfficiency=""+attenceRate+"%";
				personEfficiency1=""+attenceRate;
			}else{
				personEfficiency="";
				personEfficiency1="";
			}
			
			//预测劳效：预计流水值/(出勤率*实际人数) 保留2位
			float m=0;
			if(forecastWater!=null && !"".equals(forecastWater)){
				m=Float.parseFloat(forecastWater);
			}else{
				m=0;
			}
			float n=0;
			if(personEfficiency1!=null && !"".equals(personEfficiency1)){
				n=Float.parseFloat(personEfficiency1);
			}else{
				n=0;
			}
			float p=n*personGroupLists.size();
			float q=0;
			if(p>0){
				q = new BigDecimal(m * 100).divide(new BigDecimal(p),2,BigDecimal.ROUND_HALF_UP).floatValue();
				q = (float) (Math.round(q * 100)) / 100;
			}else{
				q=0;
			}
			workPersonRates=""+q;
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	public String cacl(AttPersonArrangeBO attpersonarrangebo) {
	try{
		String arrangeId=attpersonarrangebo.getArrangeId();
		String beginTime=attpersonarrangebo.getDuraBegin();
		String endTime=attpersonarrangebo.getDuraEnd();
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
				//String ymd=datevalue+",empty,empty";
				String ymd=datevalue;
				lists.add(ymd);
			}
		}
		
		String weekName="";
		if(lists!=null && lists.size()>0){
					String daysss=(String)lists.get(0);
					weekName=attenceSetUCC.getWeek(daysss);

		  if("0".equals(attpersonarrangebo.getStatus().trim())){
				for(int i=0;i<lists.size();i++){
					String day=(String)lists.get(i);
					String work=attenceSetUCC.countAttPersonArrangeItemBO(arrangeId,day);
					String rest=attenceSetUCC.countAttPersonArrangeItemBO1(arrangeId,day);
					String ymd=day+","+work+","+rest+","+arrangeId;
					lists.set(i,ymd);
				}
		  }else if("9".equals(attpersonarrangebo.getStatus().trim())){
				for(int i=0;i<lists.size();i++){
					String day=(String)lists.get(i);
					String work=attenceSetUCC.countAttPersonArrangeItemBO(arrangeId,day);
					String rest=attenceSetUCC.countAttPersonArrangeItemBO1(arrangeId,day);
					String ymd=day+","+work+","+rest+","+arrangeId;
					lists.set(i,ymd);
				}
		  }else{
				for(int i=0;i<lists.size();i++){
					String day=(String)lists.get(i);
					String ymd=day+",empty,empty,"+arrangeId;
					lists.set(i,ymd);
				}
		  }
		  
			//计算存休
			int sum1=attenceSetUCC.caclFeast(lists,orgId); //当月节假日天数
			int sum2=Integer.parseInt(attpersonarrangebo.getRestDay()); //当月休息天数
			int sum3=lists.size(); //当月天数
			int sum=sum3-sum2-sum1;
			monthCalendar=sum3+"";
		    monthFeast=sum1+"";
		    monthRest=sum2+"";
		    monthShouldDay=sum+"";	
		}
		
		super.getHttpSession().setAttribute("lists",lists);
		super.getHttpSession().setAttribute("lists1",weekName);
		
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
	
	public String arrangeClass(){
		try{
			AttPersonArrangeBO attpersonarrangebo=attenceSetUCC.findAttPersonArrangeBObyId(arrangeId);
			String groupId=attpersonarrangebo.getGroupId();
			List personGroupLists=attenceSetUCC.findPersonsAttClassGroupVO(groupId);//在编人数
			if(personGroupLists!=null && personGroupLists.size()>0){
				int a=personGroupLists.size();//在编人数
				String ymd=attpersonarrangebo.getDuraYear()+"-"+attpersonarrangebo.getDuraMonth();
				String b=attenceSetUCC.selectB738(attpersonarrangebo.getOrgId(),ymd);//流水情况
			  if(b!=null && !"".equals(b)){
				List attencestandbolists=attenceSetUCC.findAttenceStandBO2(attpersonarrangebo.getOrgId());//标准劳效和定编人数
				if(attencestandbolists!=null && attencestandbolists.size()>0){
					AttenceStandBO attencestandbos=(AttenceStandBO)attencestandbolists.get(0);
					int bs=0;
					if(b!=null && !"".equals(b)){
						bs=Integer.parseInt(b.trim());//流水情况
					}
					String p=attencestandbos.getStandWork();//标准劳效
					int ps=Integer.parseInt(p);
					String d=attencestandbos.getPersonNumber();//定编人数
					int ds=Integer.parseInt(d);
					int m=bs/ps;
					int c=(int)Math.floor(m);//建议出勤人数 
					int r=a-c;               //建议休息人数
					int l=(c/ds)/100;              //建议出勤率
					//自动排班计算:1.得到天数区间的集合 2.得到人数的集合 3.得到计算结果
					List daylists=(List)super.getHttpSession().getAttribute("lists");
					arrangeClassCacl(daylists,personGroupLists,attpersonarrangebo,c,r);
					//计算存休
					int sum1=attenceSetUCC.caclFeast(daylists,orgId); //当月节假日天数
					int sum2=Integer.parseInt(attpersonarrangebo.getRestDay()); //当月休息天数
					int sum3=daylists.size(); //当月天数
					int sum=sum3-sum2-sum1;
					attenceSetUCC.caclRest(personGroupLists,attpersonarrangebo,sum);
					attpersonarrangebo.setStatus("0");
					attenceSetUCC.saveorupdateAttPersonArrangeBO(attpersonarrangebo); 
				}else{
                   super.showMessageDetail("设定标准为空！");
                   return "";
				}
			  }else{
                  super.showMessageDetail("流水情况为空！");
                  return "";
			  }
			}else{
				super.showMessageDetail("手工排班中人员为空！");
				return "";
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public String arrangeClassCacl(List daylists,List personGroupLists,AttPersonArrangeBO attpersonarrangebo,int c,int r){
	try{
		if(daylists!=null && daylists.size()>0){
			List lists=personGroupLists;
//			int number=(lists.size())/3;
//			int cs=(int)Math.floor(number);
//			int p=(lists.size())-cs;//建议出勤人数
//			int q=cs;//建议休息人数
			int p=c;//建议出勤人数
			int q=r;//建议休息人数
			
            List cList=new ArrayList();
            List rList=new ArrayList();
            List c1List=new ArrayList();
			for(int i=0;i<daylists.size();i++){
				String dayvalue=(String)daylists.get(i);
				String[] dayvalues=dayvalue.split(",");
				String day=dayvalues[0];
				if(lists!=null && lists.size()>0){
					for(int j=0;j<p;j++){
						AttClassGroupVO attclassgroupvo=(AttClassGroupVO)lists.get(j);
						AttPersonArrangeItemBO attpersonarrangeitembo=new AttPersonArrangeItemBO();
						attpersonarrangeitembo.setArrangeId(attpersonarrangebo.getArrangeId());
						attpersonarrangeitembo.setPersonId(attclassgroupvo.getId());
						attpersonarrangeitembo.setCreateDay(day);
						attpersonarrangeitembo.setLinkClass(attpersonarrangebo.getLinkClass());
						attenceSetUCC.saveorupdateAttPersonArrangeItemBO(attpersonarrangeitembo);
						cList.add(attclassgroupvo);
					}
					lists.removeAll(cList);
					for(int j=0;j<q;j++){
						AttClassGroupVO attclassgroupvo=(AttClassGroupVO)lists.get(j);
						AttPersonArrangeItemBO attpersonarrangeitembo=new AttPersonArrangeItemBO();
						attpersonarrangeitembo.setArrangeId(attpersonarrangebo.getArrangeId());
						attpersonarrangeitembo.setPersonId(attclassgroupvo.getId());
						attpersonarrangeitembo.setCreateDay(day);
						attpersonarrangeitembo.setLinkClass("1");
						attenceSetUCC.saveorupdateAttPersonArrangeItemBO(attpersonarrangeitembo);
						rList.add(attclassgroupvo);
					}
					lists=new ArrayList();
				}else{
					int n=q+(q/2);
		            if(cList.size()>n){
		            	List csList=new ArrayList();
						for(int j=0;j<q;j++){
							AttClassGroupVO attclassgroupvo=(AttClassGroupVO)cList.get(j);
							AttPersonArrangeItemBO attpersonarrangeitembo=new AttPersonArrangeItemBO();
							attpersonarrangeitembo.setArrangeId(attpersonarrangebo.getArrangeId());
							attpersonarrangeitembo.setPersonId(attclassgroupvo.getId());
							attpersonarrangeitembo.setCreateDay(day);
							attpersonarrangeitembo.setLinkClass("1");
							attenceSetUCC.saveorupdateAttPersonArrangeItemBO(attpersonarrangeitembo);
							csList.add(attclassgroupvo);
						}
						cList.removeAll(csList);
						for(int j=0;j<cList.size();j++){
							AttClassGroupVO attclassgroupvo=(AttClassGroupVO)cList.get(j);
							AttPersonArrangeItemBO attpersonarrangeitembo=new AttPersonArrangeItemBO();
							attpersonarrangeitembo.setArrangeId(attpersonarrangebo.getArrangeId());
							attpersonarrangeitembo.setPersonId(attclassgroupvo.getId());
							attpersonarrangeitembo.setCreateDay(day);
							attpersonarrangeitembo.setLinkClass(attpersonarrangebo.getLinkClass());
							attenceSetUCC.saveorupdateAttPersonArrangeItemBO(attpersonarrangeitembo);
						}
			            if(rList!=null && rList.size()>0){
							for(int j=0;j<rList.size();j++){
								AttClassGroupVO attclassgroupvo=(AttClassGroupVO)rList.get(j);
								AttPersonArrangeItemBO attpersonarrangeitembo=new AttPersonArrangeItemBO();
								attpersonarrangeitembo.setArrangeId(attpersonarrangebo.getArrangeId());
								attpersonarrangeitembo.setPersonId(attclassgroupvo.getId());
								attpersonarrangeitembo.setCreateDay(day);
								attpersonarrangeitembo.setLinkClass(attpersonarrangebo.getLinkClass());
								attenceSetUCC.saveorupdateAttPersonArrangeItemBO(attpersonarrangeitembo);
							}
			            }
			            rList.addAll(csList);
		            }else{
						for(int j=0;j<cList.size();j++){
							AttClassGroupVO attclassgroupvo=(AttClassGroupVO)cList.get(j);
							AttPersonArrangeItemBO attpersonarrangeitembo=new AttPersonArrangeItemBO();
							attpersonarrangeitembo.setArrangeId(attpersonarrangebo.getArrangeId());
							attpersonarrangeitembo.setPersonId(attclassgroupvo.getId());
							attpersonarrangeitembo.setCreateDay(day);
							attpersonarrangeitembo.setLinkClass("1");
							attenceSetUCC.saveorupdateAttPersonArrangeItemBO(attpersonarrangeitembo);
						}
						
						for(int j=0;j<rList.size();j++){
							AttClassGroupVO attclassgroupvo=(AttClassGroupVO)rList.get(j);
							AttPersonArrangeItemBO attpersonarrangeitembo=new AttPersonArrangeItemBO();
							attpersonarrangeitembo.setArrangeId(attpersonarrangebo.getArrangeId());
							attpersonarrangeitembo.setPersonId(attclassgroupvo.getId());
							attpersonarrangeitembo.setCreateDay(day);
							attpersonarrangeitembo.setLinkClass(attpersonarrangebo.getLinkClass());
							attenceSetUCC.saveorupdateAttPersonArrangeItemBO(attpersonarrangeitembo);
						}
						
						List cList1=cList;
						List rList1=rList;
						cList=new ArrayList();
						rList=new ArrayList();
						cList=rList1;
						rList=cList1;
		            }
				}
			}  
            
		}else{
			//天数区间集合为空
		}
	}catch(Exception e){
		e.printStackTrace();
	}
		return "";
	}
	
	public String existRest(){
		try{
			if(dateList!=null && dateList.size()>0){
				dateList=new ArrayList();
			}
			AttPersonArrangeBO attpersonarrangebo=attenceSetUCC.findAttPersonArrangeBObyId(arrangeId1);
			String ymd=attpersonarrangebo.getDuraYear()+"-"+attpersonarrangebo.getDuraMonth();
			List personGroupLists=attenceSetUCC.findPersonsAttClassGroupVO(attpersonarrangebo.getGroupId());//在编人数
			if(personGroupLists!=null && personGroupLists.size()>0){
				for(int i=0;i<personGroupLists.size();i++){
					AttClassGroupVO attclassgroupvo=(AttClassGroupVO)personGroupLists.get(i);
                    List lists=attenceSetUCC.findAttExistRestBO(attclassgroupvo.getId(),ymd);
                    if(lists!=null && lists.size()>0){
                    	AttExistRestBO attexistrestbo=(AttExistRestBO)lists.get(0);
                    	attexistrestbo.setPersonName(attclassgroupvo.getName());
                    	dateList.add(attexistrestbo);
                    }
				}
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
}
