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
Hashtable hashTable=ucc1.getRightDate(user.getOrgId(),name,aDate);
if(hashTable!=null && hashTable.size()>0){
	
}else{
	hashTable=new Hashtable();
}
List listsss=ucc1.getAttChangeWorkBO3(personID,aDate);
Hashtable classhash=ucc1.getAllAttClassBOForHash();
if(listsss!=null && listsss.size()>0){
	for(int i=0;i<listsss.size();i++){
		AttChangeWorkBO attchangeworkbo=(AttChangeWorkBO)listsss.get(i);
		if(attchangeworkbo.getNewClass()!=null && !"".equals(attchangeworkbo.getNewClass())){
			if("1".equals(attchangeworkbo.getNewClass())){
				String namesss="休息:休息:班次主键值";
				hashTable.put(attchangeworkbo.getApplyDate(),namesss);
			}else{
				AttClassBO attclassbo=(AttClassBO)classhash.get(attchangeworkbo.getNewClass());
				attchangeworkbo.setNewClassName(attclassbo.getClassName());
				//换班值
				String namesss=attchangeworkbo.getNewClassName()+":班次:"+attclassbo.getClassID();
				hashTable.put(attchangeworkbo.getApplyDate(),namesss);	
			}	
		}else{
			String namesss="未设:未设:班次主键值";
			hashTable.put(attchangeworkbo.getApplyDate(),namesss);
		}
	}
}
StringBuffer buffer1=new StringBuffer();
Iterator it=hashTable.keySet().iterator();
while(it.hasNext()){
	String keyValue=(String)it.next();
	String keyValue1=(String)hashTable.get(keyValue);
    String flagchar=ucc1.findFlagChar(personID,keyValue,user.getOrgId());
    keyValue1=keyValue1+":"+flagchar;
	buffer1.append(keyValue+":"+keyValue1+",");
	}
out.println(buffer1);
%>
