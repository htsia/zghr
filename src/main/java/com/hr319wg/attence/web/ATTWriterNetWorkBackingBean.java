package com.hr319wg.attence.web;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.hr319wg.attence.pojo.bo.AttAnnualDetailBO;
import com.hr319wg.attence.pojo.bo.AttAnnualItemBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.ucc.IAttAnnualUCC;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;

public class ATTWriterNetWorkBackingBean extends BaseBackingBean {
	private String reasonValue;
	private String itemID;
	private String cricalDate;
	private String annDay;
	private String useDay;
	private String avgDate;
	private List listscommon=new ArrayList();
	private String pageInit;
	private String kqglLeaverDayValue;
	private String begindatevalueWdate;
	private String enddatevalueWdate;
	private IAttAnnualUCC attAnnualUcc;

    public IAttAnnualUCC getAttAnnualUcc() {
        return attAnnualUcc;
    }

    public void setAttAnnualUcc(IAttAnnualUCC attAnnualUcc) {
        this.attAnnualUcc = attAnnualUcc;
    }

    public String getKqglLeaverDayValue() {
		return kqglLeaverDayValue;
	}

	public void setKqglLeaverDayValue(String kqglLeaverDayValue) {
		this.kqglLeaverDayValue = kqglLeaverDayValue;
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

	public String getPageInit() {
		find();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public List getListscommon() {
		return listscommon;
	}

	public void setListscommon(List listscommon) {
		this.listscommon = listscommon;
	}

	public String getAvgDate() {
		return avgDate;
	}

	public void setAvgDate(String avgDate) {
		this.avgDate = avgDate;
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

	public String getCricalDate() {
		return cricalDate;
	}

	public void setCricalDate(String cricalDate) {
		this.cricalDate = cricalDate;
	}

	public String getItemID() {
		return itemID;
	}

	public void setItemID(String itemID) {
		this.itemID = itemID;
	}

	public String getReasonValue() {
		return reasonValue;
	}

	public void setReasonValue(String reasonValue) {
		this.reasonValue = reasonValue;
	}

	public String find(){
		try{
			if(listscommon!=null && listscommon.size()>0){
				listscommon=new ArrayList();
			}
            List list1=(List)super.getHttpSession().getAttribute("perIdListsCommon");
            if(list1!=null && list1.size()>0){
            	if(list1.size()>1){
            		super.getHttpSession().removeAttribute("perIdListsCommon");
					super.showMessageDetail("年假录入只限于单人录入！");
					return "";
            	}else{
                	for(int i=0;i<list1.size();i++){
                		String id=(String)list1.get(i);
    					AttClassGroupVO attclassgroupvo=attAnnualUcc.findAttClassGroupVObyId(id);
                        PersonBO pbo=SysCacheTool.findPersonById(id);
    					OrgBO a=SysCacheTool.findOrgById(pbo.getDeptId());
    					attclassgroupvo.setDeptName(a.getName());
    					OrgBO b1 = SysCacheTool.findOrgById(pbo.getOrgId());
    					attclassgroupvo.setOrgName(b1.getName());
    					listscommon.add(attclassgroupvo);
                	}
            	}
            	if(kqglLeaverDayValue!=null && !"".equals(kqglLeaverDayValue)){
            		makesure();
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
	
	/*
	 * 确认
	 */
		public String makesure(){
			try{
				List list=(List)super.getHttpSession().getAttribute("perIdListsCommon");
				if(list!=null && list.size()>0){
						DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						Date date1 = df.parse(begindatevalueWdate+":00");
						Date date2 = df.parse(enddatevalueWdate+":00");
						float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
						w = (float) (Math.round(w * 100)) / 100;
						kqglLeaverDayValue=""+w;
						
						String id=(String)list.get(0);
						PersonBO pb = SysCacheTool.findPersonById(id);
						 Calendar ca = Calendar.getInstance();
					     int year = ca.get(Calendar.YEAR);//获取年份
					     String datevalue=""+year;
						AttAnnualItemBO attannualitembo=attAnnualUcc.findEqualsAttAnnualItemBO(id,pb.getOrgId(),datevalue.trim());
						if(attannualitembo!=null){
							itemID=attannualitembo.getItemID();
							cricalDate = attannualitembo.getCriticalDate() ;
							if(cricalDate != null && !"".equals(cricalDate)){
								if(attannualitembo.getAvaDay() != null && !"".equals(attannualitembo.getAvaDay())){
									annDay=attannualitembo.getAvaDay();
								}else{
									annDay = "0" ;
								}
								if(attannualitembo.getCriticalAvaDay()!=null && !"".equals(attannualitembo.getCriticalAvaDay())){
									useDay = attannualitembo.getCriticalAvaDay();
								}else{
									useDay="0";
								}
								avgDate = "临界日期"+cricalDate+"前，可休假 "+ annDay +" 天；临界日期"+cricalDate+"后，可休假 "+useDay+" 天。";
							}else{
								if(attannualitembo.getAvaDay() != null && !"".equals(attannualitembo.getAvaDay())){
									annDay=attannualitembo.getAvaDay();
								}else{
									annDay = "0" ;
								}
								avgDate=annDay;
							}
						}else{
							annDay="0";
							useDay="0";
							avgDate="0";
							itemID="";
						}
				}else{
					begindatevalueWdate="";
					enddatevalueWdate="";
					kqglLeaverDayValue="";
					annDay="";
					useDay="";
					avgDate="";
					super.showMessageDetail("请选择人员！");
					return "";
				}

			}catch(Exception e){
				e.printStackTrace();
			}
			return "";
		}
		
		public String save(){
			try{
				if(itemID==null || "".equals(itemID)){
					super.showMessageDetail("年度管理中没有此记录！");
					return "";
				}
				List list=(List)super.getHttpSession().getAttribute("perIdListsCommon");
				if(list!=null && list.size()>0){
					String id=(String)list.get(0);
					AttAnnualItemBO attannualitembo=attAnnualUcc.findAttAnnualItemBObyId(itemID);
					if(attannualitembo.getCriticalDate()!=null && !"".equals(attannualitembo.getCriticalDate())){
						String systemdayvalue=attannualitembo.getCriticalDate();
						DateFormat systemdayvaluedf = new SimpleDateFormat("yyyy-MM-dd");
						String[] begindatevalueWdatestrs=begindatevalueWdate.split(" ");
						String begindatevalue=begindatevalueWdatestrs[0];
						String beginDateValue=begindatevalue;
			            Date s1 = systemdayvaluedf.parse(systemdayvalue);
			            Date s2 = systemdayvaluedf.parse(beginDateValue);
			            if(s1.getTime()<s2.getTime()){
							String annDay=attannualitembo.getCriticalAnnDay(); // 临界后假期天数
							String useDay=attannualitembo.getCalcAnnDay(); // 临界后已休天数
							String avaDay=attannualitembo.getCriticalAvaDay(); // 临界后可用天数
							String daySpan=kqglLeaverDayValue;
							float annDayNumber=Float.parseFloat(annDay);
							float useDayNumber=Float.parseFloat(useDay);
							float avaDayNumber=Float.parseFloat(avaDay);
							float daySpanNumber=Float.parseFloat(daySpan);
							if(daySpanNumber>avaDayNumber){
								super.showMessageDetail("你所申请的年假天数大于可用年假天数！");
								return "";
							}else if(daySpanNumber==0){
								super.showMessageDetail("你所申请的年假天数必须大于零！");
								return "";
							}else{
								String uses=(useDayNumber+daySpanNumber)+"";
								String avas=(avaDayNumber-daySpanNumber)+"";
								attannualitembo.setCalcAnnDay(uses);
								attannualitembo.setCriticalAvaDay(avas);  
								attAnnualUcc.saveAttAnnualItemBO(attannualitembo);
								
								AttAnnualDetailBO attannualdetailbo=new AttAnnualDetailBO();
								attannualdetailbo.setItemID(itemID);
								attannualdetailbo.setHolidayBegin(begindatevalueWdate);
								attannualdetailbo.setHolidayEnd(enddatevalueWdate);
								attannualdetailbo.setDaySpan(kqglLeaverDayValue);
								attAnnualUcc.saveAttAnnualDetailBO(attannualdetailbo);
							}
			            }else{
							String annDay="0";
							if(attannualitembo.getAnnDay()!=null && !"".equals(attannualitembo.getAnnDay())){
								annDay=attannualitembo.getAnnDay();
							}
							String useDay="0";
							if(attannualitembo.getUseDay()!=null && !"".equals(attannualitembo.getUseDay())){
								useDay=attannualitembo.getUseDay();
							}
							String avaDay="0";
							if(attannualitembo.getAvaDay()!=null && !"".equals(attannualitembo.getAvaDay())){
								avaDay=attannualitembo.getAvaDay();
							}
							String daySpan=kqglLeaverDayValue;
							float annDayNumber=Float.parseFloat(annDay);
							float useDayNumber=Float.parseFloat(useDay);
							float avaDayNumber=Float.parseFloat(avaDay);
							float daySpanNumber=Float.parseFloat(daySpan);
							if(daySpanNumber>avaDayNumber){
								super.showMessageDetail("你所申请的年假天数大于可用年假天数！");
								return "";
							}else if(daySpanNumber==0){
								super.showMessageDetail("你所申请的年假天数必须大于零！");
								return "";
							}else{
								String uses=(useDayNumber+daySpanNumber)+"";
								String avas=(avaDayNumber-daySpanNumber)+"";
								attannualitembo.setUseDay(uses);
								attannualitembo.setAvaDay(avas);
								attAnnualUcc.saveAttAnnualItemBO(attannualitembo);
								
								AttAnnualDetailBO attannualdetailbo=new AttAnnualDetailBO();
								attannualdetailbo.setItemID(itemID);
								attannualdetailbo.setHolidayBegin(begindatevalueWdate);
								attannualdetailbo.setHolidayEnd(enddatevalueWdate);
								attannualdetailbo.setDaySpan(kqglLeaverDayValue);
								attAnnualUcc.saveAttAnnualDetailBO(attannualdetailbo);
							}
			            }
					}else{
						String annDay=attannualitembo.getAnnDay();
						String useDay=attannualitembo.getUseDay();
						String avaDay=attannualitembo.getAvaDay();
						String daySpan=kqglLeaverDayValue;
						float annDayNumber=Float.parseFloat(annDay);
						float useDayNumber=Float.parseFloat(useDay);
						float avaDayNumber=Float.parseFloat(avaDay);
						float daySpanNumber=Float.parseFloat(daySpan);
						if(daySpanNumber>avaDayNumber){
							super.showMessageDetail("你所申请的年假天数大于可用年假天数！");
							return "";
						}else if(daySpanNumber==0){
							super.showMessageDetail("你所申请的年假天数必须大于零！");
							return "";
						}else{
							String uses=(useDayNumber+daySpanNumber)+"";
							String avas=(avaDayNumber-daySpanNumber)+"";
							attannualitembo.setUseDay(uses);
							attannualitembo.setAvaDay(avas);
							attAnnualUcc.saveAttAnnualItemBO(attannualitembo);
							
							AttAnnualDetailBO attannualdetailbo=new AttAnnualDetailBO();
							attannualdetailbo.setItemID(itemID);
							attannualdetailbo.setHolidayBegin(begindatevalueWdate);
							attannualdetailbo.setHolidayEnd(enddatevalueWdate);
							attannualdetailbo.setDaySpan(kqglLeaverDayValue);
							attAnnualUcc.saveAttAnnualDetailBO(attannualdetailbo);
						}
					}
					begindatevalueWdate="";
					enddatevalueWdate="";
					kqglLeaverDayValue="";
					annDay="";
					useDay="";
					avgDate="";
					super.getHttpSession().removeAttribute("perIdListsCommon");
					super.showMessageDetail("操作成功！");
				}else{
					super.showMessageDetail("请选择人员！");
					return "";
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			return "";
		}
}
