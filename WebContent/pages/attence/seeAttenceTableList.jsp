<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.attence.ucc.impl.AttenceSetUCC" %>
<%@ page import="java.util.*" %>
<%@ page import="com.hr319wg.attence.pojo.bo.AttenceLogBO" %>	
<%
String id=(String)request.getParameter("id");
String year=(String)request.getParameter("year");
String month=(String)request.getParameter("month");
String day=(String)request.getParameter("day");
String ymd="";
String ymd1="";
int m=Integer.parseInt(month);
if(m<10){
	ymd="0"+m;
}else{
	ymd=""+m;
}
int d=Integer.parseInt(day);
if(d<10){
	ymd1="0"+d;
}else{
	ymd1=""+d;
}
String ymds=year+"-"+ymd+"-"+ymd1;
AttenceSetUCC ucc1=(AttenceSetUCC)SysContext.getBean("att_setUCC");
List attencecardlists=ucc1.getAttenceLogBO2(id,ymds);
%>
<html>
<head>
 <title></title>
 <Style>  
.boxtitle  
{        
       BORDER-BOTTOM:  #777777  1px  solid;  
       BORDER-LEFT:  #777777  1px  solid;  
       BORDER-RIGHT:  #777777  1px  solid;  
       BORDER-TOP:  #777777  1px  solid;  
       FONT-SIZE:  12px;  
       PADDING-BOTTOM:  0px;  
       PADDING-LEFT:  1px;  
       PADDING-RIGHT:  1px;  
       PADDING-TOP:  1px;  
       TEXT-ALIGN:  center  
}  
.tt1line  
{  
       BORDER-BOTTOM:  #a0a0a0  1px  solid;  
       COLOR:  #302010;  
       FONT-SIZE:  12px;  
       FONT-WEIGHT:  bold;  
       LINE-HEIGHT:  20px  
}  
</style>  
</head>
 <body>
 <div align="center">
    <h3>刷卡数据列表</h3>
    </div>
   <hr>
   <%if(attencecardlists!=null && attencecardlists.size()>0){ %>
   <div  style="overflow-x:auto;overflow-y:auto;width:400px;height:300px">
 <table  align="center"  border="1">
    <tr>
      <td width="132" class=boxtitle>日期</td>
      <td width="132" class=boxtitle>时间 </td>
    </tr>
    <%
    for(int i=0;i<attencecardlists.size();i++){
    	AttenceLogBO attencelogbo=(AttenceLogBO)attencecardlists.get(i);
    %>
    <tr>
      <td width="132" class=boxtitle><%=attencelogbo.getCardDate() %></td>
      <td width="132" class=boxtitle><%=attencelogbo.getCardTime() %> </td>
    </tr>
    <%}%>
  </table>
  </div>
  <%}else{ %>
  无任何刷卡记录。
  <%} %>
 </body>
 </html>
