<%@ page language="java" contentType="text/plain; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.attence.ucc.impl.AttenceSetUCC" %>
<%@ page import="com.hr319wg.attence.pojo.bo.AttFeastBO" %>
<%@ page import="com.hr319wg.attence.pojo.bo.AttChangeWorkBO" %>
<%@ page import="com.hr319wg.attence.pojo.bo.AttClassBO" %>
<%@ page import="java.util.*" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
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
String personID=(String)request.getParameter("personID");
String monthvalue1="";
if(monthvalue.length()==2){
	monthvalue1=monthvalue;
}else{
	monthvalue1="0"+monthvalue;
}
String aDate=yearvalue+"-"+monthvalue1;
AttenceSetUCC ucc1=(AttenceSetUCC)SysContext.getBean("att_setUCC");
Hashtable hashTable=ucc1.getPeriodInfoDate(name,aDate);
if(hashTable!=null && hashTable.size()>0){
	
}else{
	hashTable=new Hashtable();
}
List listsss=ucc1.getAttChangeWorkBO3(personID,aDate);
if(listsss!=null && listsss.size()>0){
	for(int i=0;i<listsss.size();i++){
		AttChangeWorkBO attchangeworkbo=(AttChangeWorkBO)listsss.get(i);
		//String names=(String)hashTable.get(attchangeworkbo.getApplyDate());
		if(attchangeworkbo.getNewClass()!=null && !"".equals(attchangeworkbo.getNewClass())){
			if("1".equals(attchangeworkbo.getNewClass())){
				String namesss="��Ϣ:�������ֵ:��Ϣ";
				hashTable.put(attchangeworkbo.getApplyDate(),namesss);
			}else{
				AttClassBO attclassbo=ucc1.findAttClassBObyId(attchangeworkbo.getNewClass());
				attchangeworkbo.setNewClassName(attclassbo.getClassName());
				//����ֵ
				String namesss=attchangeworkbo.getNewClassName()+":"+attchangeworkbo.getNewClass();
				hashTable.put(attchangeworkbo.getApplyDate(),namesss);	
			}	
		}else{
			String namesss="δ��:�������ֵ:δ��";
			hashTable.put(attchangeworkbo.getApplyDate(),namesss);
		}
	}
}

StringBuffer buffer1=new StringBuffer();
Iterator it=hashTable.keySet().iterator();
while(it.hasNext()){
	String keyValue=(String)it.next();
	String keyValue1=(String)hashTable.get(keyValue);
	String[] strs=keyValue1.split(":");
	if("δ��".equals(strs[0])){
		keyValue1=keyValue1+":δ��";
	}else if("��Ϣ".equals(strs[0])){
		keyValue1=keyValue1+":��Ϣ";
	}else{
		keyValue1=keyValue1+":���";
	}
    String flagchar=ucc1.findFlagChar(personID,keyValue,user.getOrgId());
    keyValue1=keyValue1+":"+flagchar;
	buffer1.append(keyValue+":"+keyValue1+",");
	}
out.println(buffer1);
%>
