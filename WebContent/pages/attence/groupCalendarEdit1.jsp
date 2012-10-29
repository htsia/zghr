<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="java.util.*" %>
<%@ page import="com.hr319wg.attence.pojo.bo.AttClassDetailBO" %>
<%@ page import="com.hr319wg.attence.ucc.impl.AttenceSetUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.attence.pojo.bo.AttClassBO" %>
<%@ page import="com.hr319wg.attence.pojo.bo.AttenceLogBO" %>
<%
String personId=(String)request.getParameter("personId");
String yearvalue=(String)request.getParameter("yearvalue");
String monthvalue=(String)request.getParameter("monthvalue");
String daily=(String)request.getParameter("daily");
String name=(String)request.getParameter("name");
%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<%
AttenceSetUCC ucc1=(AttenceSetUCC)SysContext.getBean("att_setUCC");
AttClassBO attclassbo=null;
List detailebos=null;
if(name!=null && !"".equals(name)){
	attclassbo=ucc1.findAttClassBObyId(name);
	if("1".equals(attclassbo.getDaySpan())){
		detailebos=ucc1.getAllAttClassDetailBO1(name);
	}else{
		detailebos=ucc1.getAllAttClassDetailBO3(name);
        List detaileboss=ucc1.getAllAttClassDetailBO4(name);
        detailebos.addAll(detaileboss);
	}
}
String attclassboName="";
if(detailebos!=null && detailebos.size()>0){
	 for(int i=0;i<detailebos.size();i++){
		 AttClassDetailBO detailebo=(AttClassDetailBO)detailebos.get(i);
	 }
 }else{
	 attclassboName="预设中";
 }

String monthvalue1="";
if(monthvalue!=null && !"".equals(monthvalue)){
	if(monthvalue.length()==2){
		monthvalue1=monthvalue;
	}else{
		monthvalue1="0"+monthvalue;
	}
}

String monthvalue2="";
if(daily!=null && !"".equals(daily)){
	if(daily.length()==2){
		monthvalue2=daily;
	}else{
		monthvalue2="0"+daily;
	}
}

String aDate="";
if(yearvalue!=null && !"".equals(yearvalue)){
	aDate=yearvalue+"-"+monthvalue1+"-"+monthvalue2;
}
List dailylists=null;
if(personId!=null && !"".equals(personId)){
	dailylists=ucc1.getAttenceLogBO3(personId,aDate);
}
%>
<html>
<head>
 <title></title>
<link href="/css/style.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
.bg-hover{
    width:300px;  
    text-align:center;
    background:#66CCFF; 
    color:red;
    cursor: pointer;
   }
        .td_class {   
            cursor: pointer;
            width:300px;  
            text-align:center;
        } 
        .table_css1 {   
            border: 1px solid #B1CDE3;   
            padding:0;    
            margin:0 auto;   
            border-collapse: collapse;   
        }
 .table_css{ 
	border-collapse:collapse;
	border-top: 1px #000000 solid;
	border-right: 1px #000000 solid;
	border-bottom: 1px #000000 solid;
	border-left: 1px #000000 solid;
}
</style>  
</head>
 <body>
 <div align="center">
   <h3>时段显示列表</h3>
    </div>
    <div  style="text-align:center;">
 <table  class='table_css1'  border="1">
    <tr align="center">
     <td colspan="2">所属班次【 <%=attclassbo.getClassName() %>】</td>
    </tr>
    <tr>
      <td class='td_class'>时刻名称</td>
      <td class='td_class'>时间 </td>
    </tr>
    <%
if(!"1".equals(attclassbo.getDaySpan())){
   for(int i=0;detailebos!=null && i<detailebos.size();i++){
	   AttClassDetailBO detailebo=(AttClassDetailBO)detailebos.get(i);
	   String itemNames="";
	   if("1".equals(detailebo.getDayFlag())){  
		   itemNames="[第一天]"+detailebo.getItemName(); 
	   }else if("2".equals(detailebo.getDayFlag())){
		   itemNames="[第二天]"+detailebo.getItemName(); 
	   }else{
		   itemNames=detailebo.getItemName(); 
	   }
   %>
	   
    <tr onmousemove="this.className='bg-hover'" onmouseout="this.className='td_class'">
      <td class='td_class'><%=itemNames %></td>
      <td class='td_class'><%=detailebo.getItemTime() %> </td>
    </tr>
 <%}
}else{
	for(int i=0;detailebos!=null && i<detailebos.size();i++){
	  AttClassDetailBO detailebo=(AttClassDetailBO)detailebos.get(i);	
	%>
	    <tr  onmousemove="this.className='bg-hover'" onmouseout="this.className='td_class'">
      <td class='td_class'><%=detailebo.getItemName() %></td>
      <td class='td_class'><%=detailebo.getItemTime() %> </td>
    </tr>
    <%}
}%>
  </table>
  </div>
  
  <div align="center">
    <h3><%=aDate%>打卡信息</h3>
  </div>
  <div  style="text-align:center;">
   <table  class='table_css1'  border="1">
    <tr>
      <td class='td_class'>时间</td>
      <td class='td_class'>是否补卡</td>
    </tr>
    <%
    if(dailylists!=null && dailylists.size()>0){
    	for(int i=0;i<dailylists.size();i++){
    		AttenceLogBO attencelogbo=(AttenceLogBO)dailylists.get(i);
    		String cardtimes=attencelogbo.getCardDate()+" "+attencelogbo.getCardTime();
    		String registerCard="";
    		if("00901".equals(attencelogbo.getRegisterCard())){
    			registerCard="是";
    		}else{
    			registerCard="否";
    		}
    %>
    <tr  onmousemove="this.className='bg-hover'" onmouseout="this.className='td_class'">
      <td class='td_class'><%=cardtimes %></td>
      <td class='td_class'><%=registerCard %> </td>
    </tr>
    <%
    	}}
    %>
   </table>
  </div>          
 </body>
 </html>