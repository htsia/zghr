package com.hr319wg.attence.web;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Hashtable;
import java.util.List;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.attence.pojo.bo.AttClassGroupBO;
import com.hr319wg.attence.pojo.bo.AttManagerArgumentBO;
import com.hr319wg.attence.pojo.bo.AttManagerArrangeBO;
import com.hr319wg.attence.pojo.bo.AttPersonArrangeItemBO;
import com.hr319wg.attence.pojo.bo.AttenceWaterBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;

public class AutoClassManagerListBackingBean extends BaseBackingBean {
	private String tableType="1";
	private List orgValuelist=new ArrayList();
	private String orgValue;
	private String orgId=super.getUserInfo().getOrgId();
	private String amaId;
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

	public String getAmaId() {
		return amaId;
	}

	public void setAmaId(String amaId) {
		this.amaId = amaId;
	}

	public String getPageInit() {
		if (super.getRequestParameter("amaId") != null && !super.getRequestParameter("amaId").equals("")) {
			amaId = super.getRequestParameter("amaId");
		}
		//orgValue=orgId;
	    doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String getOrgValue() {
		return orgValue;
	}

	public void setOrgValue(String orgValue) {
		this.orgValue = orgValue;
	}

	public List getOrgValuelist() {
		doQueryOrgValue();
		return orgValuelist;
	}

	public void setOrgValuelist(List orgValuelist) {
		this.orgValuelist = orgValuelist;
	}

	public String getTableType() {
		return tableType;
	}

	public void setTableType(String tableType) {
		this.tableType = tableType;
	}

	public void doQuery() {
		try {
			AttManagerArrangeBO attmanagerarrangebo=attenceSetUCC.findAttManagerArrangeBObyId(amaId);
			if("-1".equals(attmanagerarrangebo.getStatus().trim())){
				isExist=false;
			}else if("0".equals(attmanagerarrangebo.getStatus().trim())){
				isExist=false;
			}else if("9".equals(attmanagerarrangebo.getStatus().trim())){
				isExist=true;
			}
			
			super.getHttpSession().removeAttribute("lists");
			super.getHttpSession().removeAttribute("lists1");
			super.getHttpSession().removeAttribute("lists2");
			super.getHttpSession().removeAttribute("hashTableValuelist1");
			super.getHttpSession().removeAttribute("hashTableValuelist2");
			super.getHttpSession().removeAttribute("hashTableValuelist3");
			
			if(orgValue==null || "".equals(orgValue)){
				List orgValuelists=attenceSetUCC.getAllAttManagerArgumentBO(orgId);
				if(orgValuelists!=null && orgValuelists.size()>0){
					AttManagerArgumentBO attmanagerargumentbo=(AttManagerArgumentBO)orgValuelists.get(0);
					String orgIdstr=attmanagerargumentbo.getOrgId();
					orgValue=orgIdstr;
				}
			}
			
			cacl(attmanagerarrangebo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String cacl(AttManagerArrangeBO attmanagerarrangebo) {
		try{
			String amaId=attmanagerarrangebo.getAmaId();
			String duraYearMonth=attmanagerarrangebo.getDuraYearMonth().trim();
			 Calendar c=Calendar.getInstance();
			 String[] duraYearMonthStr=duraYearMonth.split("-");
			 int yearvalue=Integer.parseInt(duraYearMonthStr[0]);
			 int monthvalue=Integer.parseInt(duraYearMonthStr[1]);
			 c.set(yearvalue,monthvalue-1,1);
			 int sum=c.getActualMaximum(Calendar.DAY_OF_MONTH);
			 String sumstr="";
			 if(sum>=10){
				 sumstr=""+sum;
			 }else{
				 sumstr="0"+sum;
			 }
			String beginTime=duraYearMonth+"-01";
			String endTime=duraYearMonth+"-"+sumstr.trim();
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
			List lists2 = new ArrayList();
			Hashtable hashTablelist1=new Hashtable();
			Hashtable hashTablelist2=new Hashtable();
			Hashtable hashTablelist3=new Hashtable();
			if(lists!=null && lists.size()>0){
						String daysss=(String)lists.get(0);
						weekName=attenceSetUCC.getWeek(daysss);

			  if("0".equals(attmanagerarrangebo.getStatus().trim())){
					for(int i=0;i<lists.size();i++){
						String day=(String)lists.get(i);
						lists2.add(day);
						String weekName1=attenceSetUCC.getWeek(day);
						String worknamelist="";
						String restnamelist="";
						String work="0";
						String rest="0";
						hashTablelist1.put(day, weekName1);
						List workvaluelist=attenceSetUCC.findCountAttPersonArrangeItemBO1(amaId,day,orgValue);
						if(workvaluelist!=null && workvaluelist.size()>0){
							for(int j=0;j<workvaluelist.size();j++){
								AttClassGroupVO attclassgroupvo=(AttClassGroupVO)workvaluelist.get(j);
								if(j<=0){
									worknamelist=attclassgroupvo.getName();
								}else{
									worknamelist=worknamelist+","+attclassgroupvo.getName();
								}
							}
							hashTablelist2.put(day, worknamelist);
							work=""+workvaluelist.size();
						}else{
							hashTablelist2.put(day, "-");
						}
						List restvaluelist=attenceSetUCC.findCountAttPersonArrangeItemBO2(amaId,day,orgValue);
						if(restvaluelist!=null && restvaluelist.size()>0){
							for(int j=0;j<restvaluelist.size();j++){
								AttClassGroupVO attclassgroupvo=(AttClassGroupVO)restvaluelist.get(j);
								if(j<=0){
									restnamelist=attclassgroupvo.getName();
								}else{
									restnamelist=restnamelist+","+attclassgroupvo.getName();
								}
							}
							hashTablelist3.put(day, restnamelist);
							rest=""+restvaluelist.size();
						}else{
							hashTablelist3.put(day, "-");
						}
//						String work=attenceSetUCC.countAttPersonArrangeItemBO3(amaId,day,orgValue);
//						String rest=attenceSetUCC.countAttPersonArrangeItemBO4(amaId,day,orgValue);
						String ymd=day+","+work+","+rest+","+amaId;
						lists.set(i,ymd);
					}
			  }else if("9".equals(attmanagerarrangebo.getStatus().trim())){
					for(int i=0;i<lists.size();i++){
						String day=(String)lists.get(i);
						lists2.add(day);
						String weekName1=attenceSetUCC.getWeek(day);
						String worknamelist="";
						String restnamelist="";
						String work="0";
						String rest="0";
						hashTablelist1.put(day, weekName1);
						List workvaluelist=attenceSetUCC.findCountAttPersonArrangeItemBO1(amaId,day,orgValue);
						if(workvaluelist!=null && workvaluelist.size()>0){
							for(int j=0;j<workvaluelist.size();j++){
								AttClassGroupVO attclassgroupvo=(AttClassGroupVO)workvaluelist.get(j);
								if(j<=0){
									worknamelist=attclassgroupvo.getName();
								}else{
									worknamelist=worknamelist+","+attclassgroupvo.getName();
								}
							}
							hashTablelist2.put(day, worknamelist);
							work=""+workvaluelist.size();
						}else{
							hashTablelist2.put(day, "-");
						}
						List restvaluelist=attenceSetUCC.findCountAttPersonArrangeItemBO2(amaId,day,orgValue);
						if(restvaluelist!=null && restvaluelist.size()>0){
							for(int j=0;j<restvaluelist.size();j++){
								AttClassGroupVO attclassgroupvo=(AttClassGroupVO)restvaluelist.get(j);
								if(j<=0){
									restnamelist=attclassgroupvo.getName();
								}else{
									restnamelist=restnamelist+","+attclassgroupvo.getName();
								}
							}
							hashTablelist3.put(day, restnamelist);
							rest=""+restvaluelist.size();
						}else{
							hashTablelist3.put(day, "-");
						}
//						String work=attenceSetUCC.countAttPersonArrangeItemBO3(amaId,day,orgValue);
//						String rest=attenceSetUCC.countAttPersonArrangeItemBO4(amaId,day,orgValue);
						String ymd=day+","+work+","+rest+","+amaId;
						lists.set(i,ymd);
					}
			  }else{
					for(int i=0;i<lists.size();i++){
						String day=(String)lists.get(i);
						lists2.add(day);
						String weekName1=attenceSetUCC.getWeek(day);
						hashTablelist1.put(day, weekName1);
						hashTablelist2.put(day, "-");
						hashTablelist3.put(day, "-");
						String ymd=day+",empty,empty,"+amaId;
						lists.set(i,ymd);
					}
			  }
		  }
			  
			super.getHttpSession().setAttribute("lists",lists);
			super.getHttpSession().setAttribute("lists1",weekName);
			super.getHttpSession().setAttribute("lists2",lists2);
			super.getHttpSession().setAttribute("hashTableValuelist1",hashTablelist1);
			super.getHttpSession().setAttribute("hashTableValuelist2",hashTablelist2);
			super.getHttpSession().setAttribute("hashTableValuelist3",hashTablelist3);
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
			AttManagerArrangeBO attmanagerarrangebo=attenceSetUCC.findAttManagerArrangeBObyId(amaId);//发放列表信息
			String duraYearMonth=attmanagerarrangebo.getDuraYearMonth().trim();//发放年月
			
			List daylists=(List)super.getHttpSession().getAttribute("lists");//当月天数集合
			int sum1=attenceSetUCC.caclFeast(daylists,orgId); //当月节假日天数
			
			List orgValuelists=attenceSetUCC.getAllAttManagerArgumentBO(orgId);//自动排班计算规则信息
			if(orgValuelists!=null && orgValuelists.size()>0){
				List classgrouplists=attenceSetUCC.getAllAttClassGroupBOType1(orgId);//查询本机构的班组信息
				if(classgrouplists!=null && classgrouplists.size()>0){
					AttClassGroupBO attclassgroupbo=(AttClassGroupBO)classgrouplists.get(0);
			        for(int i=0;i<orgValuelists.size();i++){
			          AttManagerArgumentBO attmanagerargumentbo=(AttManagerArgumentBO)orgValuelists.get(i);
				      String orgIdstr=attmanagerargumentbo.getOrgId();//部门ID
				      OrgBO b = SysCacheTool.findOrgById(orgIdstr.trim());
				      String formula=attmanagerargumentbo.getFormula();//套用公式
				      
				      List attPersonArrangeItemLists=attenceSetUCC.getAllAttPersonArrangeItemBO2(attmanagerarrangebo.getAmaId(),attmanagerargumentbo.getOrgId());
				      if(attPersonArrangeItemLists!=null && attPersonArrangeItemLists.size()>0){
				    	  attenceSetUCC.deleteAttPersonArrangeItemBO(attmanagerarrangebo.getAmaId(),attmanagerargumentbo.getOrgId());
				      }
				      
					  int sum2=Integer.parseInt(attmanagerargumentbo.getRestDay()); //当月休息天数
					  int sum3=daylists.size(); //当月天数
					  int sum=sum3-sum2-sum1;
					  float sum4 = new BigDecimal(sum * 100).divide(new BigDecimal(sum3),BigDecimal.ROUND_HALF_UP).floatValue();
					  sum4 = (float) (Math.round(sum4 * 100)) / 100;//当月出勤率					  
				      System.out.println("attmanagerargumentbo.getOrgId()="+orgIdstr);
				      System.out.println("b.getName()="+b.getName());
				      System.out.println("sum4="+sum4);
				      List personGroupLists=attenceSetUCC.findPersonsAttClassGroupVO(attclassgroupbo.getGroupNo(),orgIdstr);//在编人数
				      if(personGroupLists!=null && personGroupLists.size()>0){
				    	  int a=personGroupLists.size();//在编人数
				    	  List attencewaterbolists=attenceSetUCC.findAttenceWaterBO2(orgIdstr,duraYearMonth);
				    	  if(attencewaterbolists!=null && attencewaterbolists.size()>0){
				    		  AttenceWaterBO attencewaterbo=(AttenceWaterBO)attencewaterbolists.get(0);
				    		  System.out.println("attencewaterbo.getMonthVolume()="+attencewaterbo.getMonthVolume());
				    		  System.out.println("attencewaterbo.getMonthProduce()="+attencewaterbo.getMonthProduce());
				    		  if("1".equals(formula)){
				    			  System.out.println("formula=1");
				    			  float monthVolumefloat=Float.parseFloat(attencewaterbo.getMonthVolume());
				    			  float monthCalendarfloat=daylists.size();
				    			//第一步：预估每月总客流量
				    			//已录入：monthVolumefloat
				    			//第二步：求每天总客流量
				    			  float everydayVolumefloat=monthVolumefloat/monthCalendarfloat;
				    			//第三步：求每天每餐总客流量
				    			  String lunchRate=attmanagerargumentbo.getLunchRate();
				    			  String supperRate=attmanagerargumentbo.getSuperRate();
								  float lunchRatefloat=Float.parseFloat(lunchRate);
								  float supperRatefloat=Float.parseFloat(supperRate);
								  float lunchRatefloatvalue=(float)(everydayVolumefloat*lunchRatefloat*0.01);
								  float supperRatefloatvalue=(float)(everydayVolumefloat*supperRatefloat*0.01);
								//第四步：求需要多少员工接待
								  String waiter=attmanagerargumentbo.getWaiter();//服务员待客量
								  float workperson=0;
								  float waiterfloat=Float.parseFloat(waiter);
								  if(supperRatefloatvalue>=lunchRatefloatvalue){
										workperson=supperRatefloatvalue/waiterfloat;
								  }else{
										workperson=lunchRatefloatvalue/waiterfloat;
								  }
								  float allperson=(float)(workperson/(sum4*0.01));
								  float cfloat=new BigDecimal(allperson).setScale(0, BigDecimal.ROUND_HALF_UP).floatValue();
								  System.out.println("a="+a);
								  System.out.println("allperson="+allperson);
								  System.out.println("workperson="+workperson);
								  if(cfloat>a){
										super.showMessageDetail("计算出来的"+b.getName()+"定编人数大于在编人数，请核对数据。");
										return "";
								  }
								  float c=new BigDecimal(workperson).setScale(0, BigDecimal.ROUND_HALF_UP).floatValue();
								//第五步：求需要一拖三小组的数量
								//略
								  int afloat=(int)cfloat;
								  int d=(int)c;
								  int r=afloat-d;
								  System.out.println("afloat="+afloat);
								  System.out.println("d="+d);
								  System.out.println("r="+r);
								  
								  List personGroupList=new ArrayList();
								  for(int j=0;j<afloat;j++){
								    AttClassGroupVO attclassgroupvo=(AttClassGroupVO)personGroupLists.get(j);
								    personGroupList.add(attclassgroupvo);
								  }
								  arrangeClassCacl(daylists,personGroupList,attmanagerarrangebo,attmanagerargumentbo,d,r);
								  
								  attmanagerarrangebo.setStatus("0");
								  attenceSetUCC.saveorupdateAttManagerArrangeBO(attmanagerarrangebo); 
				    		  }else if("2".equals(formula)){
				    			  System.out.println("formula=2");
				    			  float monthProducefloat=Float.parseFloat(attencewaterbo.getMonthProduce());
				    			  float monthCalendarfloat=daylists.size();
				    			//第一步：预算小组每月总出品量
				    			  String monthProduceRate=attmanagerargumentbo.getProduceRate();
				    			  float monthProduceRatefloat=Float.parseFloat(monthProduceRate);
				    			  float everydaymonthProducefloat=(float)(monthProducefloat*monthProduceRatefloat*0.01);
				    			  System.out.println("everydaymonthProducefloat="+everydaymonthProducefloat);
				    			//第二步：求小组每天总出品量
				    			  float everydayVolumefloat=everydaymonthProducefloat/monthCalendarfloat;
				    			  System.out.println("everydayVolumefloat="+everydayVolumefloat);
				    			//第三步：求小组每天每餐出品量
								  float supperRatefloatvalue=(float)(everydayVolumefloat*0.6);
								  System.out.println("supperRatefloatvalue="+supperRatefloatvalue);
				    			//第四步：求需要几人完成出品任务
								  String waiter=attmanagerargumentbo.getProduceRoad();//人均每餐出品道
								  float workperson=0;
								  float waiterfloat=Float.parseFloat(waiter);
								  workperson=supperRatefloatvalue/waiterfloat;
								  float allperson=(float)(workperson/(sum4*0.01));
								  float cfloat=new BigDecimal(allperson).setScale(0, BigDecimal.ROUND_HALF_UP).floatValue();
								  System.out.println("a="+a);
								  System.out.println("allperson="+allperson);
								  System.out.println("workperson="+workperson);
								  if(cfloat>a){
										super.showMessageDetail("计算出来的"+b.getName()+"定编人数大于在编人数，请核对数据。");
										return "";
								  }
								  float c=new BigDecimal(workperson).setScale(0, BigDecimal.ROUND_HALF_UP).floatValue();
								//第五步：求需要热菜小组数
								//略
								  int afloat=(int)cfloat;
								  int d=(int)c;
								  int r=afloat-d;
								  System.out.println("afloat="+afloat);
								  System.out.println("d="+d);
								  System.out.println("r="+r);
								  
								  List personGroupList=new ArrayList();
								  for(int j=0;j<afloat;j++){
								    AttClassGroupVO attclassgroupvo=(AttClassGroupVO)personGroupLists.get(j);
								    personGroupList.add(attclassgroupvo);
								  }
								  arrangeClassCacl(daylists,personGroupList,attmanagerarrangebo,attmanagerargumentbo,d,r);
								  
								  attmanagerarrangebo.setStatus("0");
								  attenceSetUCC.saveorupdateAttManagerArrangeBO(attmanagerarrangebo); 
				    		  }else if("3".equals(formula)){
				    			  System.out.println("formula=3");
				    			  float monthVolumefloat=Float.parseFloat(attencewaterbo.getMonthVolume());
				    			  float monthProducefloat=Float.parseFloat(attencewaterbo.getMonthProduce());
				    			  float monthCalendarfloat=daylists.size();
				    			//第一步：预估月总客流量、预估月总出品量
				    			//已录入：monthVolumefloat
				    			//已录入：monthProducefloat
				    			//第二步：求月清洗餐具量
				    			  String bigTableWare=attmanagerargumentbo.getBigTableWare();
				    			  String smallTableWare=attmanagerargumentbo.getSmallTableWare();
				    			  String bonePlate=attmanagerargumentbo.getBonePlate();
				    			  float bigTableWarefloat=Float.parseFloat(bigTableWare);
				    			  float smallTableWarefloat=Float.parseFloat(smallTableWare);
				    			  float bonePlatefloat=Float.parseFloat(bonePlate);
				    			  float everydaybigTableWarefloat=(float)(monthProducefloat*bigTableWarefloat);
				    			  float everydaysmallTableWarefloat=(float)(monthVolumefloat*smallTableWarefloat);
				    			  float everydaybonePlatefloat=(float)(monthVolumefloat*bonePlatefloat);
				    			  float everydaymonthProducefloat=everydaybigTableWarefloat+everydaysmallTableWarefloat+everydaybonePlatefloat;
				    			  System.out.println("everydaymonthProducefloat="+everydaymonthProducefloat);
				    			//第三步：求每天清洗餐具量
								  float everydayVolumefloat=everydaymonthProducefloat/monthCalendarfloat;
								  System.out.println("everydayVolumefloat="+everydayVolumefloat);
				    			//第四步：求每餐清洗餐具量
								  float supperRatefloatvalue=(float)(everydayVolumefloat*0.6);
								  System.out.println("supperRatefloatvalue="+supperRatefloatvalue);
				    			//第五步：求洗碗组所需人员数量
								  String cleanNumber=attmanagerargumentbo.getCleanNumber();
								  float workperson=0;
								  float cleanNumberfloat=Float.parseFloat(cleanNumber);
								  workperson=supperRatefloatvalue/cleanNumberfloat;
								  float allperson=(float)(workperson/(sum4*0.01));
								  float cfloat=new BigDecimal(allperson).setScale(0, BigDecimal.ROUND_HALF_UP).floatValue();
								  System.out.println("a="+a);
								  System.out.println("allperson="+allperson);
								  System.out.println("workperson="+workperson);
								  if(cfloat>a){
										super.showMessageDetail("计算出来的"+b.getName()+"定编人数大于在编人数，请核对数据。");
										return "";
								  }
								  float c=new BigDecimal(workperson).setScale(0, BigDecimal.ROUND_HALF_UP).floatValue();
								  
								  int afloat=(int)cfloat;
								  int d=(int)c;
								  int r=afloat-d;
								  System.out.println("afloat="+afloat);
								  System.out.println("d="+d);
								  System.out.println("r="+r);
								  
								  List personGroupList=new ArrayList();
								  for(int j=0;j<afloat;j++){
								    AttClassGroupVO attclassgroupvo=(AttClassGroupVO)personGroupLists.get(j);
								    personGroupList.add(attclassgroupvo);
								  }
								  
								  System.out.println("personGroupLists.size()="+personGroupLists.size());
								  for(int j=0;j<personGroupLists.size();j++){
									    AttClassGroupVO attclassgroupvo=(AttClassGroupVO)personGroupLists.get(j);
									    System.out.println("personGroupLists="+attclassgroupvo.getName());
							      }
								  
								  System.out.println("personGroupList.size()="+personGroupList.size());
								  for(int j=0;j<personGroupList.size();j++){
									    AttClassGroupVO attclassgroupvo=(AttClassGroupVO)personGroupList.get(j);
									    System.out.println("personGroupList="+attclassgroupvo.getName());
								  }
								  
								  arrangeClassCacl(daylists,personGroupList,attmanagerarrangebo,attmanagerargumentbo,d,r);
								  
								  attmanagerarrangebo.setStatus("0");
								  attenceSetUCC.saveorupdateAttManagerArrangeBO(attmanagerarrangebo); 
				    		  }
				    	  }else{
				    		  super.showMessageDetail("请录入"+duraYearMonth+"参数。");
							  return "";
				    	  }
				      }else{
							super.showMessageDetail("手工排班中，"+b.getName()+"人员为空！");
							return "";
				      }
				    }
				}else{
					super.showMessageDetail("请先设置本单位的手工排班班组！");
					return "";
				}
			}else{
				super.showMessageDetail("请先设置自动排班计算规则！");
				return "";
			}
			
			super.showMessageDetail("排班计算成功！");
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public String arrangeClassCacl(List daylists,List personGroupLists,AttManagerArrangeBO attmanagerarrangebo,AttManagerArgumentBO attmanagerargumentbo,int c,int r){
		try{
			if(daylists!=null && daylists.size()>0){
				List lists=personGroupLists;
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
							attpersonarrangeitembo.setArrangeId(attmanagerarrangebo.getAmaId());
							attpersonarrangeitembo.setPersonId(attclassgroupvo.getId());
							attpersonarrangeitembo.setCreateDay(day);
							attpersonarrangeitembo.setLinkClass(attmanagerargumentbo.getLinkClass());
							attenceSetUCC.saveorupdateAttPersonArrangeItemBO(attpersonarrangeitembo);
							cList.add(attclassgroupvo);
						}
						lists.removeAll(cList);
						for(int j=0;j<q;j++){
							AttClassGroupVO attclassgroupvo=(AttClassGroupVO)lists.get(j);
							AttPersonArrangeItemBO attpersonarrangeitembo=new AttPersonArrangeItemBO();
							attpersonarrangeitembo.setArrangeId(attmanagerarrangebo.getAmaId());
							attpersonarrangeitembo.setPersonId(attclassgroupvo.getId());
							attpersonarrangeitembo.setCreateDay(day);
							attpersonarrangeitembo.setLinkClass("1");
							attenceSetUCC.saveorupdateAttPersonArrangeItemBO(attpersonarrangeitembo);
							rList.add(attclassgroupvo);
						}
						lists=new ArrayList();
					}else{
                       if(p>q){
			            	List csList=new ArrayList();
							for(int j=0;j<q;j++){
								AttClassGroupVO attclassgroupvo=(AttClassGroupVO)cList.get(j);
								AttPersonArrangeItemBO attpersonarrangeitembo=new AttPersonArrangeItemBO();
								attpersonarrangeitembo.setArrangeId(attmanagerarrangebo.getAmaId());
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
								attpersonarrangeitembo.setArrangeId(attmanagerarrangebo.getAmaId());
								attpersonarrangeitembo.setPersonId(attclassgroupvo.getId());
								attpersonarrangeitembo.setCreateDay(day);
								attpersonarrangeitembo.setLinkClass(attmanagerargumentbo.getLinkClass());
								attenceSetUCC.saveorupdateAttPersonArrangeItemBO(attpersonarrangeitembo);
							}
				            if(rList!=null && rList.size()>0){
								for(int j=0;j<rList.size();j++){
									AttClassGroupVO attclassgroupvo=(AttClassGroupVO)rList.get(j);
									AttPersonArrangeItemBO attpersonarrangeitembo=new AttPersonArrangeItemBO();
									attpersonarrangeitembo.setArrangeId(attmanagerarrangebo.getAmaId());
									attpersonarrangeitembo.setPersonId(attclassgroupvo.getId());
									attpersonarrangeitembo.setCreateDay(day);
									attpersonarrangeitembo.setLinkClass(attmanagerargumentbo.getLinkClass());
									attenceSetUCC.saveorupdateAttPersonArrangeItemBO(attpersonarrangeitembo);
								}
				            }
				            cList.addAll(rList);
							rList=new ArrayList();
							rList=csList;
                       }else if(p<q){
   						 for(int j=0;j<p;j++){
								AttClassGroupVO attclassgroupvo=(AttClassGroupVO)cList.get(j);
								AttPersonArrangeItemBO attpersonarrangeitembo=new AttPersonArrangeItemBO();
								attpersonarrangeitembo.setArrangeId(attmanagerarrangebo.getAmaId());
								attpersonarrangeitembo.setPersonId(attclassgroupvo.getId());
								attpersonarrangeitembo.setCreateDay(day);
								attpersonarrangeitembo.setLinkClass("1");
								attenceSetUCC.saveorupdateAttPersonArrangeItemBO(attpersonarrangeitembo);
						 }
   						 List csList=new ArrayList();
							for(int j=0;j<p;j++){
								AttClassGroupVO attclassgroupvo=(AttClassGroupVO)rList.get(j);
								AttPersonArrangeItemBO attpersonarrangeitembo=new AttPersonArrangeItemBO();
								attpersonarrangeitembo.setArrangeId(attmanagerarrangebo.getAmaId());
								attpersonarrangeitembo.setPersonId(attclassgroupvo.getId());
								attpersonarrangeitembo.setCreateDay(day);
								attpersonarrangeitembo.setLinkClass(attmanagerargumentbo.getLinkClass());
								attenceSetUCC.saveorupdateAttPersonArrangeItemBO(attpersonarrangeitembo);
								csList.add(attclassgroupvo);
							}
							rList.removeAll(csList);
							for(int j=0;j<rList.size();j++){
								AttClassGroupVO attclassgroupvo=(AttClassGroupVO)rList.get(j);
								AttPersonArrangeItemBO attpersonarrangeitembo=new AttPersonArrangeItemBO();
								attpersonarrangeitembo.setArrangeId(attmanagerarrangebo.getAmaId());
								attpersonarrangeitembo.setPersonId(attclassgroupvo.getId());
								attpersonarrangeitembo.setCreateDay(day);
								attpersonarrangeitembo.setLinkClass("1");
								attenceSetUCC.saveorupdateAttPersonArrangeItemBO(attpersonarrangeitembo);
							}
							rList.addAll(cList);
							cList=new ArrayList();
							cList=csList;
                       }else{
							for(int j=0;j<cList.size();j++){
								AttClassGroupVO attclassgroupvo=(AttClassGroupVO)cList.get(j);
								AttPersonArrangeItemBO attpersonarrangeitembo=new AttPersonArrangeItemBO();
								attpersonarrangeitembo.setArrangeId(attmanagerarrangebo.getAmaId());
								attpersonarrangeitembo.setPersonId(attclassgroupvo.getId());
								attpersonarrangeitembo.setCreateDay(day);
								attpersonarrangeitembo.setLinkClass("1");
								attenceSetUCC.saveorupdateAttPersonArrangeItemBO(attpersonarrangeitembo);
							}
							
							for(int j=0;j<rList.size();j++){
								AttClassGroupVO attclassgroupvo=(AttClassGroupVO)rList.get(j);
								AttPersonArrangeItemBO attpersonarrangeitembo=new AttPersonArrangeItemBO();
								attpersonarrangeitembo.setArrangeId(attmanagerarrangebo.getAmaId());
								attpersonarrangeitembo.setPersonId(attclassgroupvo.getId());
								attpersonarrangeitembo.setCreateDay(day);
								attpersonarrangeitembo.setLinkClass(attmanagerargumentbo.getLinkClass());
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
	
	public String find(){
		try{
			AttManagerArrangeBO attmanagerarrangebo=attenceSetUCC.findAttManagerArrangeBObyId(amaId);
			if("-1".equals(attmanagerarrangebo.getStatus().trim())){
				isExist=false;
			}else if("0".equals(attmanagerarrangebo.getStatus().trim())){
				isExist=false;
			}else if("9".equals(attmanagerarrangebo.getStatus().trim())){
				isExist=true;
			}
			
			super.getHttpSession().removeAttribute("lists");
			super.getHttpSession().removeAttribute("lists1");
			super.getHttpSession().removeAttribute("lists2");
			super.getHttpSession().removeAttribute("hashTableValuelist1");
			super.getHttpSession().removeAttribute("hashTableValuelist2");
			super.getHttpSession().removeAttribute("hashTableValuelist3");
			
			cacl(attmanagerarrangebo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public void doQueryOrgValue() {
		try{
			if(orgValuelist!=null && orgValuelist.size()>0){
				orgValuelist=new ArrayList();
			}
			List orgValuelists=attenceSetUCC.getAllAttManagerArgumentBO(orgId);
			if(orgValuelists!=null && orgValuelists.size()>0){
				for(int i=0;i<orgValuelists.size();i++){
					AttManagerArgumentBO attmanagerargumentbo=(AttManagerArgumentBO)orgValuelists.get(i);
					String orgIdstr=attmanagerargumentbo.getOrgId();
					OrgBO b = SysCacheTool.findOrgById(orgIdstr.trim());
					SelectItem si = new SelectItem();
					si.setLabel(b.getName());
					si.setValue(orgIdstr);
					orgValuelist.add(si);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void changeOrgValue(ValueChangeEvent event) {
		this.orgValue = event.getNewValue().toString();
	}
}
