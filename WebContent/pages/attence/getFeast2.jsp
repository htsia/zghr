<%@ page language="java" contentType="text/plain; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.attence.ucc.impl.workCalenderUCC" %>
<%@ page import="com.hr319wg.attence.ucc.impl.AttenceSetUCC" %>
<%@ page import="com.hr319wg.attence.pojo.bo.AttFeastBO" %>
<%@ page import="com.hr319wg.attence.pojo.bo.AttClassGroupBO" %>
<%@ page import="com.hr319wg.attence.pojo.bo.AttChangeWorkBO" %>
<%@ page import="com.hr319wg.attence.pojo.bo.AttClassBO" %>
<%@ page import="java.util.*" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.attence.ucc.impl.workCalenderUCC" %>
<%@ page import="com.hr319wg.attence.pojo.bo.AttMimicReportRecBO" %>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<%
out.clear();
User user = (User) (session.getAttribute(Constants.USER_INFO));
String name=(String)request.getParameter("name");
String yearvalue=(String)request.getParameter("yearvalue");
String monthvalue=(String)request.getParameter("monthvalue");
String monthvalue1="";
if(monthvalue.length()==2){
	monthvalue1=monthvalue;
}else{
	monthvalue1="0"+monthvalue;
}
String aDate=yearvalue+"-"+monthvalue1;

workCalenderUCC workcalenderucc=(workCalenderUCC)SysContext.getBean("att_workCalenderUCC");
String workCalenderThing="workCalenderThing";
List workcalenderlists=workcalenderucc.getAttMimicReportRecBO(name,aDate);
if(workcalenderlists!=null && workcalenderlists.size()>0){
	AttMimicReportRecBO attmimicreportrecbo=(AttMimicReportRecBO)workcalenderlists.get(0);
	String[] workCalenderThingstrs=attmimicreportrecbo.getMrMonth().split(",");
	workCalenderThing="��ܰ��ʾ�����Ѿ���";
	for(int number=0;number<workCalenderThingstrs.length;number++){
		workCalenderThing=workCalenderThing+""+workCalenderThingstrs[number]+"�·�";
	}
	workCalenderThing=workCalenderThing+"����������ⱨ���뼰ʱ��д������롣";	
}else{
	workCalenderThing="workCalenderThing";
}
workCalenderUCC ucc1=(workCalenderUCC)SysContext.getBean("att_workCalenderUCC");
Hashtable hashTable=ucc1.getAttWorkCalendarBO(name,aDate);
StringBuffer buffer1=new StringBuffer();
AttenceSetUCC ucc2=(AttenceSetUCC)SysContext.getBean("att_setUCC");
String groupvalues=ucc2.getA001737(name);
if(groupvalues!=null && !"".equals(groupvalues)){
	AttClassGroupBO bo=ucc2.findAttClassGroupBObyId(groupvalues);
	if(bo!=null){
		if (bo.getLinkClass() != null && !"".equals(bo.getLinkClass())) {
			Hashtable hashTables=ucc2.getRightDate(user.getOrgId(),groupvalues,aDate);
			List listsss=ucc2.getAttChangeWorkBO3(name,aDate);
			if(listsss!=null && listsss.size()>0){
				for(int i=0;i<listsss.size();i++){
					AttChangeWorkBO attchangeworkbo=(AttChangeWorkBO)listsss.get(i);
					if(attchangeworkbo.getNewClass()!=null && !"".equals(attchangeworkbo.getNewClass())){
						if("1".equals(attchangeworkbo.getNewClass())){
							String namesss="��Ϣ:��Ϣ:�������ֵ";
							hashTables.put(attchangeworkbo.getApplyDate(),namesss);
						}else{
							AttClassBO attclassbo=ucc2.findAttClassBObyId(attchangeworkbo.getNewClass());
							attchangeworkbo.setNewClassName(attclassbo.getClassName());
							//����ֵ
							String namesss=attchangeworkbo.getNewClassName()+":���:"+attclassbo.getClassID();
							hashTables.put(attchangeworkbo.getApplyDate(),namesss);	
						}	
					}else{
						String namesss="δ��:δ��:�������ֵ";
						hashTables.put(attchangeworkbo.getApplyDate(),namesss);
					}
				}
			}
			Iterator it=hashTables.keySet().iterator();
			while(it.hasNext()){
				String keyValue=(String)it.next();
				String keyValue1=(String)hashTables.get(keyValue);
		    	String bos=(String)hashTable.get(keyValue);
		    	if(bos!=null && !"".equals(bos)){
		    		keyValue1=keyValue1+":"+bos;
		    	}else{
		    		String boss="�޼�¼";
		    		keyValue1=keyValue1+":"+boss;
		    	}
		        String flagchar=ucc2.findFlagChar(name,keyValue,user.getOrgId());
			    keyValue1=keyValue1+":"+flagchar;
				buffer1.append(keyValue+":"+keyValue1+",");
				}
		} else {
			Hashtable hashTables=ucc2.getPeriodInfoDate(groupvalues,aDate);			
			List listsss=ucc2.getAttChangeWorkBO3(name,aDate);
			if(listsss!=null && listsss.size()>0){
				for(int i=0;i<listsss.size();i++){
					AttChangeWorkBO attchangeworkbo=(AttChangeWorkBO)listsss.get(i);
					if(attchangeworkbo.getNewClass()!=null && !"".equals(attchangeworkbo.getNewClass())){
						if("1".equals(attchangeworkbo.getNewClass())){
							String namesss="��Ϣ:��Ϣ:�������ֵ:�޼�¼";
							hashTables.put(attchangeworkbo.getApplyDate(),namesss);
						}else{
							AttClassBO attclassbo=ucc2.findAttClassBObyId(attchangeworkbo.getNewClass());
							attchangeworkbo.setNewClassName(attclassbo.getClassName());
							//����ֵ
							String namesss=attchangeworkbo.getNewClassName()+":"+attclassbo.getClassID();
							hashTables.put(attchangeworkbo.getApplyDate(),namesss); 
						}	
					}else{
						String namesss="δ��:δ��:�������ֵ:�޼�¼";
						hashTables.put(attchangeworkbo.getApplyDate(),namesss);
					}
				}
			}
			Iterator it=hashTables.keySet().iterator();
			while(it.hasNext()){
				String keyValue=(String)it.next();
				String keyValue1=(String)hashTables.get(keyValue);
				String[] strs=keyValue1.split(":");
		    	String bos=(String)hashTable.get(keyValue);
		    	if(bos!=null && !"".equals(bos)){
		    		keyValue1=strs[0]+":���:"+strs[1]+":"+bos;
		    	}else{
		    		String boss="�޼�¼";
		    		keyValue1=strs[0]+":���:"+strs[1]+":"+boss;
		    	}
		        String flagchar=ucc2.findFlagChar(name,keyValue,user.getOrgId());
			    keyValue1=keyValue1+":"+flagchar;
				buffer1.append(keyValue+":"+keyValue1+",");
			}
		   
			Iterator its=hashTable.keySet().iterator();
			while(its.hasNext()){
				String keyValue=(String)its.next();
				String keyValue1=(String)hashTable.get(keyValue);
			    String flagchar=ucc2.findFlagChar(name,keyValue,user.getOrgId());
			    keyValue1=keyValue1+":"+flagchar;
				String bos=(String)hashTables.get(keyValue);
		    	if(bos!=null && !"".equals(bos)){
                   
		    	}else{
		    		buffer1.append(keyValue+":�ް��:���:�������ֵ:"+keyValue1+",");
		    	}
		     }
		}
	}
}else{
	Iterator it=hashTable.keySet().iterator();
	while(it.hasNext()){
		String keyValue=(String)it.next();
		String keyValue1=(String)hashTable.get(keyValue);
	    String flagchar=ucc2.findFlagChar(name,keyValue,user.getOrgId());
	    keyValue1=keyValue1+":"+flagchar;
    	buffer1.append(keyValue+":�ް��:���:�������ֵ:"+keyValue1+",");
     }
}
out.println(workCalenderThing+","+buffer1);
%>
