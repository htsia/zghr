package com.hr319wg.attence.web;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.hr319wg.attence.pojo.bo.AttAnnualDetailBO;
import com.hr319wg.attence.pojo.bo.AttAnnualItemBO;
import com.hr319wg.attence.pojo.bo.AttAnnualRecordBO;
import com.hr319wg.attence.pojo.bo.AttenceSecondDayLogBO;
import com.hr319wg.attence.ucc.IAttAnnualUCC;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.util.SequenceGenerator;

public class AnnualMgrListChildBackingBean extends BaseBackingBean {
	private String personId;
	private String enddatevalue;
	private String endtimevalue;
	private String begindatevalue;
	private String begintimevalue;
	private boolean isExist;
	private String detailID;
	private List lists;
	private String itemID;
	private String pageInit;
	private String annDay;
	private String useDay;
	private String avaDay;
	private AttAnnualDetailBO bo=new AttAnnualDetailBO();
	private String initEdit;
	private String cricalDate ;//�ٽ�����
	private String cricalBefore ;//�ٽ�ǰ��Ϣ����
	private String cricalAfter ;//�ٽ����Ϣ����
	private String yearStart  ; //��ٿ�ʼ����
	private String yearEnd ;//��ٽ�������

    private IAttAnnualUCC attAnnualUcc;

    public IAttAnnualUCC getAttAnnualUcc() {
        return attAnnualUcc;
    }

    public void setAttAnnualUcc(IAttAnnualUCC attAnnualUcc) {
        this.attAnnualUcc = attAnnualUcc;
    }

    /*
      * ȷ��
      */
	public String makesure() {
		try {
		            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		            Date beDate = df.parse(begindatevalue+" "+begintimevalue + ":00");
		            Date enDate = df.parse(enddatevalue+" "+endtimevalue + ":00");
					float sum=((float)(enDate.getTime() - beDate.getTime())) / (1000 * 60 * 60 * 24);
					sum = (float) (Math.round(sum * 100)) / 100;
					bo.setDaySpan(sum+"");
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return "";
	}
	
	
	
	public boolean getIsExist() {
		return isExist;
	}

	public void setIsExist(boolean isExist) {
		this.isExist = isExist;
	}
	
	public String getInitEdit() {
		try{
		if (super.getRequestParameter("itemID") != null
				&& !super.getRequestParameter("itemID").equals("")) {
			itemID = super.getRequestParameter("itemID");
			AttAnnualItemBO attannualitembo=attAnnualUcc.findAttAnnualItemBObyId(itemID);
			AttAnnualRecordBO attannualrecordbo = attAnnualUcc.findAttAnnualRecordBOById(attannualitembo.getRecID());
			if(attannualrecordbo != null){
				yearStart = attannualrecordbo.getYearBegin() ;  
			    yearEnd =  attannualrecordbo.getYearEnd();
			}
			cricalDate = attannualitembo.getCriticalDate() ;
			System.out.println("�ٽ����� ��"+cricalDate);
			if(cricalDate != null && !"".equals(cricalDate)){
				String avgDate = attannualitembo.getAnnDay() ;
				if(avgDate == null || "".equals(avgDate)){
					avgDate = "0" ;
				}
				avaDay = cricalDate+" ֮ǰ���ݼ� "+ avgDate +" ��֮����ݼ�"+attannualitembo.getCriticalAnnDay()+" ��";
			    cricalAfter = attannualitembo.getCriticalAnnDay(); //��
				cricalBefore = attannualitembo.getAnnDay();//�ٽ�ǰ��Ϣ����
				System.out.println(avaDay);
			}else{
				avaDay = " "+ attannualitembo.getAnnDay()+ " ��";
				cricalAfter = "" ; //��
				cricalBefore = attannualitembo.getAnnDay();//�ٽ����Ϣ����
			}
		 
			useDay=attannualitembo.getUseDay();
			bo.setDetailID(null);
			bo.setItemID(itemID);
			bo.setHolidayBegin("");
			bo.setHolidayEnd("");
			bo.setDaySpan("");
	    	begindatevalue="";
	    	begintimevalue="00:00";
	    	enddatevalue="";
	    	endtimevalue="23:59";
			isExist=true;
		}else if (super.getRequestParameter("detailID") != null
				&& !super.getRequestParameter("detailID").equals("")) {
			detailID = super.getRequestParameter("detailID");
			bo=attAnnualUcc.findAttAnnualDetailBObyId(detailID);
			bo.setDaySpans(bo.getDaySpan());
			String[] begindate=bo.getHolidayBegin().split(" ");
			begindatevalue=begindate[0];
			begintimevalue=begindate[1];
			String[] enddate=bo.getHolidayEnd().split(" ");
			enddatevalue=enddate[0];
			endtimevalue=enddate[1];
			AttAnnualItemBO attannualitembo=attAnnualUcc.findAttAnnualItemBObyId(bo.getItemID());
		    annDay=attannualitembo.getAnnDay();
	        useDay=attannualitembo.getUseDay();
	        avaDay=attannualitembo.getAvaDay();
	        personId=attannualitembo.getPersonID();
	        isExist=false;
		}
		}catch(Exception e){
			
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public AttAnnualDetailBO getBo() {
		return bo;
	}

	public void setBo(AttAnnualDetailBO bo) {
		this.bo = bo;
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
	
	public String getPersonId() {
		return personId;
	}

	public void setPersonId(String personId) {
		this.personId = personId;
	}

	public String save(){
		try{
			   float avadayfloat = 0;//�ٽ�ǰ�ݼ�
			   float dayspanfloat = 0;//ʵ����������
			   float hou  = 0 ;//�ٽ����ں��ݼ�����
			   SimpleDateFormat ds = new SimpleDateFormat("yyyy-MM-dd");
				Date begain = ds.parse(yearStart);
				Date end = ds.parse(yearEnd);
				Calendar caBegain = Calendar.getInstance();//��ȿ�ʼ����
				Calendar caEnd = Calendar.getInstance();//��Ƚ�������
				caBegain.setTime(begain);
				caEnd.setTime(end);
			
			
				Date attBegain = ds.parse(begindatevalue);
				Calendar beCalendar = Calendar.getInstance();//�ݼٿ�ʼ����
				beCalendar.setTime(attBegain);
				
				Date attEnd = ds.parse(enddatevalue);
				Calendar endCalendar = Calendar.getInstance();//�ݼٽ�������
				endCalendar.setTime(attEnd);
				
				if(!beCalendar.after(caBegain) || ! beCalendar.before(caEnd) ){//���뿪ʼ����
					super.showMessageDetail("��������ٵĿ�ʼ������ڳ����˱���ȷ�Χ��");
					return "";
				}
				if(!endCalendar.after(caBegain) || ! endCalendar.before(caEnd) ){//�����������
					super.showMessageDetail("��������ٵ���ٽ������ڳ�������ȷ�Χ��");
					return "";
				}
		 
			String shiijiDay =  bo.getDaySpan();//
			if(shiijiDay != null && !"".equals(shiijiDay)){
				dayspanfloat = Float.parseFloat(shiijiDay);//ʵ����������
			}
			if(cricalBefore!=null && !"".equals(cricalBefore)){
				avadayfloat=Float.parseFloat(cricalBefore);//�ٽ�ǰ�ݼ�
			}
		    if(cricalAfter != null && !"".equals(cricalAfter)){
		    	hou = Float.parseFloat(cricalAfter);//�ٽ����ں��ݼ�����
		    }
		    
			
			//�����ٽ�����
			if(cricalDate!= null && !"".equals(cricalDate)){//�����ٽ����ڵ������ֱ�Ӻ�Ӧ��Ӧ�������ȽϺ��ٽ�������������Ƚ�
				Date  date1 = ds.parse(cricalDate);
				Calendar cricalDt = Calendar.getInstance();
				cricalDt.setTime(date1);
				
				if(beCalendar.after(cricalDt)){//���������������ٽ�����֮�� 
					if(dayspanfloat > hou  ){
						super.showMessageDetail("�����õ���������������ݼٷ�Χ��");
						return "" ;
					}
				}else{//���������������ٽ�����֮ǰ
					if(cricalBefore == null || "".equals(cricalBefore)||"0".equals(cricalBefore)){
						super.showMessageDetail("����������֮ǰ��û�п��õ��ݼ�������");
						return "" ;
					}
					if(dayspanfloat > avadayfloat){
						super.showMessageDetail("�����õ���������������ݼٷ�Χ��");
						return "" ;
					}
				}
			}else{//û���ٽ����ڵ������ֱ�Ӻ�Ӧ��Ӧ�������Ƚ�
				if(dayspanfloat > avadayfloat){
					super.showMessageDetail(" �����ݼ���������������ݼ�ֵ��");
					return "" ;
				}
			}
		 
			String begindate=begindatevalue+" "+begintimevalue;
			bo.setHolidayBegin(begindate);
			String enddate=enddatevalue+" "+endtimevalue;
			bo.setHolidayEnd(enddate);
			attAnnualUcc.saveAttAnnualDetailBO(bo);
			
			AttAnnualItemBO attannualitembo=attAnnualUcc.findAttAnnualItemBObyId(itemID);
			if(attannualitembo.getCriticalDate()!=null && !"".equals(attannualitembo.getCriticalDate())){
				String systemdayvalue=attannualitembo.getCriticalDate();
				DateFormat systemdayvaluedf = new SimpleDateFormat("yyyy-MM-dd");
				String beginDateValue=begindatevalue;
	            Date s1 = systemdayvaluedf.parse(systemdayvalue);
	            Date s2 = systemdayvaluedf.parse(beginDateValue);
	            if(s1.getTime()<s2.getTime()){
					String annDay=attannualitembo.getCriticalAnnDay(); // �ٽ���������
					String useDay=attannualitembo.getCalcAnnDay(); // �ٽ����������
					String avaDay=attannualitembo.getCriticalAvaDay(); // �ٽ���������
					String daySpan=bo.getDaySpan();
					float annDayNumber=Float.parseFloat(annDay);
					float useDayNumber=Float.parseFloat(useDay);
					float avaDayNumber=Float.parseFloat(avaDay);
					float daySpanNumber=Float.parseFloat(daySpan);
					String uses=(useDayNumber+daySpanNumber)+"";
					String avas=(avaDayNumber-daySpanNumber)+"";
					attannualitembo.setCalcAnnDay(uses);
					attannualitembo.setCriticalAvaDay(avas);  
					attAnnualUcc.saveAttAnnualItemBO(attannualitembo);
	            }else{
					String annDay=attannualitembo.getAnnDay();
					String useDay=attannualitembo.getUseDay();
					String avaDay=attannualitembo.getAvaDay();
					String daySpan=bo.getDaySpan();
					float annDayNumber=Float.parseFloat(annDay);
					float useDayNumber=Float.parseFloat(useDay);
					float avaDayNumber=Float.parseFloat(avaDay);
					float daySpanNumber=Float.parseFloat(daySpan);
					String uses=(useDayNumber+daySpanNumber)+"";
					String avas=(avaDayNumber-daySpanNumber)+"";
					attannualitembo.setUseDay(uses);
					attannualitembo.setAvaDay(avas);
					attAnnualUcc.saveAttAnnualItemBO(attannualitembo);
	            }
			}else{
				String annDay=attannualitembo.getAnnDay();
				String useDay=attannualitembo.getUseDay();
				String avaDay=attannualitembo.getAvaDay();
				String daySpan=bo.getDaySpan();
				float annDayNumber=Float.parseFloat(annDay);
				float useDayNumber=Float.parseFloat(useDay);
				float avaDayNumber=Float.parseFloat(avaDay);
				float daySpanNumber=Float.parseFloat(daySpan);
				String uses=(useDayNumber+daySpanNumber)+"";
				String avas=(avaDayNumber-daySpanNumber)+"";
				attannualitembo.setUseDay(uses);
				attannualitembo.setAvaDay(avas);
				attAnnualUcc.saveAttAnnualItemBO(attannualitembo);
			}
			cacl(bo,attannualitembo);//���շֻ���A807���ݱ��У���������Ϣֵ��
		}catch(Exception e){
			
		}
		return "success";
	}

	public String saves(){
		try{
			AttAnnualDetailBO attannualdetailbo=attAnnualUcc.findAttAnnualDetailBObyId(bo.getDetailID());
			deleteCacl(attannualdetailbo,personId);//�Ƴ��շֻ���A807���ݱ��У������Ϣֵ��			
			String begindate=begindatevalue+" "+begintimevalue;
			bo.setHolidayBegin(begindate);
			String enddate=enddatevalue+" "+endtimevalue;
			bo.setHolidayEnd(enddate);
			attAnnualUcc.saveAttAnnualDetailBO(bo);
			AttAnnualItemBO attannualitembo=attAnnualUcc.findAttAnnualItemBObyId(bo.getItemID());
			if(attannualitembo.getCriticalDate()!=null && !"".equals(attannualitembo.getCriticalDate())){
				String systemdayvalue=attannualitembo.getCriticalDate();
				DateFormat systemdayvaluedf = new SimpleDateFormat("yyyy-MM-dd");
				String beginDateValue=begindatevalue;
	            Date s1 = systemdayvaluedf.parse(systemdayvalue);
	            Date s2 = systemdayvaluedf.parse(beginDateValue);
	            if(s1.getTime()<s2.getTime()){
					String annDay=attannualitembo.getCriticalAnnDay(); // �ٽ���������
					String useDay=attannualitembo.getCalcAnnDay(); // �ٽ����������
					String avaDay=attannualitembo.getCriticalAvaDay(); // �ٽ���������
					String daySpan=bo.getDaySpan();
					String daySpans=bo.getDaySpans();
					float annDayNumber=Float.parseFloat(annDay);
					float useDayNumber=Float.parseFloat(useDay);
					float avaDayNumber=Float.parseFloat(avaDay);
					float daySpanNumber=Float.parseFloat(daySpan);
					float daySpansNumber=Float.parseFloat(daySpans);
					String uses="";
					String avas="";
					if(daySpanNumber>=daySpansNumber){
						uses=(useDayNumber+(daySpanNumber-daySpansNumber))+"";
						avas=(avaDayNumber-(daySpanNumber-daySpansNumber))+"";
					}else{
						uses=(useDayNumber-(daySpansNumber-daySpanNumber))+"";
						avas=(avaDayNumber+(daySpansNumber-daySpanNumber))+"";
					}
					attannualitembo.setCalcAnnDay(uses);
					attannualitembo.setCriticalAvaDay(avas);  
					attAnnualUcc.saveAttAnnualItemBO(attannualitembo);
	            }else{
					String annDay=attannualitembo.getAnnDay();
					String useDay=attannualitembo.getUseDay();
					String avaDay=attannualitembo.getAvaDay();
					String daySpan=bo.getDaySpan();
					String daySpans=bo.getDaySpans();
					float annDayNumber=Float.parseFloat(annDay);
					float useDayNumber=Float.parseFloat(useDay);
					float avaDayNumber=Float.parseFloat(avaDay);
					float daySpanNumber=Float.parseFloat(daySpan);
					float daySpansNumber=Float.parseFloat(daySpans);
					String uses="";
					String avas="";
					if(daySpanNumber>=daySpansNumber){
						uses=(useDayNumber+(daySpanNumber-daySpansNumber))+"";
						avas=(avaDayNumber-(daySpanNumber-daySpansNumber))+"";
					}else{
						uses=(useDayNumber-(daySpansNumber-daySpanNumber))+"";
						avas=(avaDayNumber+(daySpansNumber-daySpanNumber))+"";
					}
					attannualitembo.setUseDay(uses);
					attannualitembo.setAvaDay(avas);
					attAnnualUcc.saveAttAnnualItemBO(attannualitembo);
	            }
			}else{
				String annDay=attannualitembo.getAnnDay();
				String useDay=attannualitembo.getUseDay();
				String avaDay=attannualitembo.getAvaDay();
				String daySpan=bo.getDaySpan();
				String daySpans=bo.getDaySpans();
				float annDayNumber=Float.parseFloat(annDay);
				float useDayNumber=Float.parseFloat(useDay);
				float avaDayNumber=Float.parseFloat(avaDay);
				float daySpanNumber=Float.parseFloat(daySpan);
				float daySpansNumber=Float.parseFloat(daySpans);
				String uses="";
				String avas="";
				if(daySpanNumber>=daySpansNumber){
					uses=(useDayNumber+(daySpanNumber-daySpansNumber))+"";
					avas=(avaDayNumber-(daySpanNumber-daySpansNumber))+"";
				}else{
					uses=(useDayNumber-(daySpansNumber-daySpanNumber))+"";
					avas=(avaDayNumber+(daySpansNumber-daySpanNumber))+"";
				}
				attannualitembo.setUseDay(uses);
				attannualitembo.setAvaDay(avas);
				attAnnualUcc.saveAttAnnualItemBO(attannualitembo);
			}
			cacl(bo,attannualitembo);//���շֻ���A807���ݱ��У���������Ϣֵ��
		}catch(Exception e){
			
		}
		return "success";
	}
	
	public String getItemID() {
		return itemID;
	}

	public void setItemID(String itemID) {
		this.itemID = itemID;
	}

	public List getLists() {
		return lists;
	}

	public void setLists(List lists) {
		this.lists = lists;
	}

	public String getDetailID() {
		return detailID;
	}

	public void setDetailID(String detailID) {
		this.detailID = detailID;
	}

	public String getPageInit() {
		try{
		if (super.getRequestParameter("itemID") != null
				&& !super.getRequestParameter("itemID").equals("")) {
			itemID = super.getRequestParameter("itemID");
			AttAnnualItemBO attannualitembo=attAnnualUcc.findAttAnnualItemBObyId(itemID);
			avaDay=attannualitembo.getAvaDay();
		}
		}catch(Exception e){
			
		}
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	
	public String doQuery(){
		try {
			lists = attAnnualUcc.getAllAttAnnualDetailBOByItemId(itemID);
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					AttAnnualDetailBO attannualdetailbo=(AttAnnualDetailBO)lists.get(i);
					lists.set(i, attannualdetailbo);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public String delete(){
		try{
			if(detailID!=null && !"".equals(detailID)){
				AttAnnualDetailBO attannualdetailbo=attAnnualUcc.findAttAnnualDetailBObyId(detailID);
				String daySpan=attannualdetailbo.getDaySpan();
				AttAnnualItemBO attannualitembo=attAnnualUcc.findAttAnnualItemBObyId(attannualdetailbo.getItemID());
				if(attannualitembo.getCriticalDate()!=null && !"".equals(attannualitembo.getCriticalDate())){ //�����ٽ�����
					//�ٽ�����ǰ����ֵ
					if(attannualitembo.getAnnDay()!=null && !"".equals(attannualitembo.getAnnDay()) && attannualitembo.getCriticalAnnDay()!=null && !"".equals(attannualitembo.getCriticalAnnDay())){
						String systemdayvalue=attannualitembo.getCriticalDate();
						DateFormat systemdayvaluedf = new SimpleDateFormat("yyyy-MM-dd");
						String beginDateValue=attannualdetailbo.getHolidayBegin().substring(0,10);
			            Date s1 = systemdayvaluedf.parse(systemdayvalue);
			            Date s2 = systemdayvaluedf.parse(beginDateValue);
			            if(s1.getTime()<s2.getTime()){
							String annDay=attannualitembo.getCriticalAnnDay(); // �ٽ���������
							String useDay=attannualitembo.getCalcAnnDay(); // �ٽ����������
							String avaDay=attannualitembo.getCriticalAvaDay(); // �ٽ���������
							float annDayNumber=Float.parseFloat(annDay);
							float useDayNumber=Float.parseFloat(useDay);
							float avaDayNumber=Float.parseFloat(avaDay);
							float daySpanNumber=Float.parseFloat(daySpan);
							String uses=(useDayNumber-daySpanNumber)+"";
							String avas=(avaDayNumber+daySpanNumber)+"";
							attannualitembo.setCalcAnnDay(uses);
							attannualitembo.setCriticalAvaDay(avas);  
			            }else{
							String annDay=attannualitembo.getAnnDay(); // ��������
							String useDay=attannualitembo.getUseDay(); // ��������
							String avaDay=attannualitembo.getAvaDay(); // �������� 
							float annDayNumber=Float.parseFloat(annDay);
							float useDayNumber=Float.parseFloat(useDay);
							float avaDayNumber=Float.parseFloat(avaDay);
							float daySpanNumber=Float.parseFloat(daySpan);
							String uses=(useDayNumber-daySpanNumber)+"";
							String avas=(avaDayNumber+daySpanNumber)+"";
							attannualitembo.setUseDay(uses);
							attannualitembo.setAvaDay(avas);  
			            }
					}else{
						if(attannualitembo.getAnnDay()!=null && !"".equals(attannualitembo.getAnnDay())){ //ֻ���ٽ�����ǰ��ֵ
							String annDay=attannualitembo.getAnnDay(); // ��������
							String useDay=attannualitembo.getUseDay(); // ��������
							String avaDay=attannualitembo.getAvaDay(); // �������� 
							float annDayNumber=Float.parseFloat(annDay);
							float useDayNumber=Float.parseFloat(useDay);
							float avaDayNumber=Float.parseFloat(avaDay);
							float daySpanNumber=Float.parseFloat(daySpan);
							String uses=(useDayNumber-daySpanNumber)+"";
							String avas=(avaDayNumber+daySpanNumber)+"";
							attannualitembo.setUseDay(uses);
							attannualitembo.setAvaDay(avas);  
						}else{ //ֻ���ٽ����ں���ֵ
							String annDay=attannualitembo.getCriticalAnnDay(); // �ٽ���������
							String useDay=attannualitembo.getCalcAnnDay(); // �ٽ����������
							String avaDay=attannualitembo.getCriticalAvaDay(); // �ٽ���������
							float annDayNumber=Float.parseFloat(annDay);
							float useDayNumber=Float.parseFloat(useDay);
							float avaDayNumber=Float.parseFloat(avaDay);
							float daySpanNumber=Float.parseFloat(daySpan);
							String uses=(useDayNumber-daySpanNumber)+"";
							String avas=(avaDayNumber+daySpanNumber)+"";
							attannualitembo.setCalcAnnDay(uses);
							attannualitembo.setCriticalAvaDay(avas);  
						}
					}
				}else{ //�������ٽ�����
					String annDay=attannualitembo.getAnnDay(); // ��������
					String useDay=attannualitembo.getUseDay(); // ��������
					String avaDay=attannualitembo.getAvaDay(); // ��������
					float annDayNumber=Float.parseFloat(annDay);
					float useDayNumber=Float.parseFloat(useDay);
					float avaDayNumber=Float.parseFloat(avaDay);
					float daySpanNumber=Float.parseFloat(daySpan);
					String uses=(useDayNumber-daySpanNumber)+"";
					String avas=(avaDayNumber+daySpanNumber)+"";
					attannualitembo.setUseDay(uses);
					attannualitembo.setAvaDay(avas);    
				}
				attAnnualUcc.saveAttAnnualItemBO(attannualitembo);
				deleteCacl(attannualdetailbo,attannualitembo.getPersonID());//�Ƴ��շֻ���A807���ݱ��У������Ϣֵ��	
				attAnnualUcc.deleteAttAnnualDetailBO(detailID);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	/*
	 * �������伯��ɾ������
	 */
	public String deleteCacl(AttAnnualDetailBO attannualdetailbo,String personId) {
		try{
			String[] begindate=attannualdetailbo.getHolidayBegin().split(" ");
			String oldbegindatevalue=begindate[0];
			String[] enddate=attannualdetailbo.getHolidayEnd().split(" ");
			String oldenddatevalue=enddate[0];
			String beginTime=oldbegindatevalue;
			String endTime=oldenddatevalue;
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
			
			//�Ƴ��շֻ���A807���ݱ��У������Ϣֵ��
			if(lists!=null && lists.size()>0){
				for(int j=0;j<lists.size();j++){
					String daysss=(String)lists.get(j);
					attAnnualUcc.deleteAttenceSecondDayLogBO(personId,daysss);
				}
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
			return "";
		}
	
	/*
	 * �������伯�ϼ���
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
			
			//���շֻ���A807���ݱ��У���������Ϣֵ��
			if(lists!=null && lists.size()>0){
				for(int j=0;j<lists.size();j++){
					String daysss=(String)lists.get(j);
					attAnnualUcc.deleteAttenceSecondDayLogBO(attannualitembo.getPersonID(),daysss);//��ɾ��
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
					attAnnualUcc.saveAttenceSecondDayLogBO(attenceseconddaylogbo);//�����ӣ������ظ����ݵ����
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



	public String getCricalDate() {
		return cricalDate;
	}



	public void setCricalDate(String cricalDate) {
		this.cricalDate = cricalDate;
	}



	public String getCricalBefore() {
		return cricalBefore;
	}



	public void setCricalBefore(String cricalBefore) {
		this.cricalBefore = cricalBefore;
	}



	public String getCricalAfter() {
		return cricalAfter;
	}



	public void setCricalAfter(String cricalAfter) {
		this.cricalAfter = cricalAfter;
	}
	
}
