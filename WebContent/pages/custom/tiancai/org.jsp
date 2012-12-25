<%@page import="com.hr319wg.custom.util.SqlUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="net.sf.json.JSONArray"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    
	String superID=request.getParameter("id");
	
    List orgList = new ArrayList();
	ResultSet set = SqlUtil.getData("select id,b001002,b001005,b001075,(select count(*) from b001 b2 where b2.b001002=b1.id) childNum from b001 b1 where b001002='"+superID+"'");
    if(set!=null){
    	while(set.next()){
    		if("089110".equals(set.getString("b001075"))){
				if(set.getInt("childNum")!=0){
					orgList.add("{id:'"+set.getString("id")+"',name:'"+set.getString("b001005")+"',pId:'"+set.getString("b001002")+"',isParent:true,iconOpen:'/images/tree_images/org.gif',iconClose:'/images/tree_images/org.gif'}");
				}else{
					orgList.add("{id:'"+set.getString("id")+"',name:'"+set.getString("b001005")+"',pId:'"+set.getString("b001002")+"',isParent:true,iconOpen:'/images/tree_images/org.gif',iconClose:'/images/tree_images/org.gif'}");
				}
			}else{
				if(set.getInt("childNum")!=0){
					orgList.add("{id:'"+set.getString("id")+"',name:'"+set.getString("b001005")+"',pId:'"+set.getString("b001002")+"',isParent:true,icon:'/images/tree_images/dept.gif'}");
				}else{
					orgList.add("{id:'"+set.getString("id")+"',name:'"+set.getString("b001005")+"',pId:'"+set.getString("b001002")+"',icon:'/images/tree_images/dept.gif'}");					
				}
			}
    	}
    }
    out.print(JSONArray.fromObject(orgList));
%>