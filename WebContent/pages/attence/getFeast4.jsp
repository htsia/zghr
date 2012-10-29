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
String name="";
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
Hashtable hashTable=null;
String orgID="";
if(personID!=null && !"".equals(personID)){
	if(user.getOrgId().equals(personID)){
		orgID=personID;
		hashTable=ucc1.getRightDate(orgID,name,aDate);
	}else{
		orgID="";
	}
}else{
	orgID=user.getOrgId();
	hashTable=ucc1.getRightDate(orgID,name,aDate);
}

if(hashTable!=null && hashTable.size()>0){
	
}else{
	hashTable=new Hashtable();
}
StringBuffer buffer1=new StringBuffer();
Iterator it=hashTable.keySet().iterator();
while(it.hasNext()){
	String keyValue=(String)it.next();
	String keyValue1=(String)hashTable.get(keyValue);
	buffer1.append(keyValue+":"+keyValue1+",");
	}
out.println(buffer1);
%>
