<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.hr319wg.attence.pojo.bo.AttClassDetailBO" %>
<%@ page import="com.hr319wg.attence.ucc.impl.AttenceSetUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.attence.pojo.bo.AttClassGroupBO" %>
<%
String name=(String)request.getParameter("name");
%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<%
AttenceSetUCC ucc1=(AttenceSetUCC)SysContext.getBean("att_setUCC");
AttClassGroupBO groupbo=ucc1.findAttClassGroupBObyId(name);
List detailebos=null;
detailebos=ucc1.getAllAttClassDetailBO1(groupbo.getLinkClass());
String attclassboName="";
if(detailebos!=null && detailebos.size()>0){
	 for(int i=0;i<detailebos.size();i++){
		 AttClassDetailBO detailebo=(AttClassDetailBO)detailebos.get(i);
	 }
 }else{
	 attclassboName="预设中";
 }
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
    <h3>正常班：时段显示列表</h3>
    </div>
   <hr>
   <div  style="overflow-x:auto;overflow-y:auto;width:400px;height:300px">
 <table  align="center"  border="1">
    <tr>
      <td width="132" class=boxtitle>时刻名称</td>
      <td width="132" class=boxtitle>时间 </td>
    </tr>
    <%
   for(int i=0;detailebos!=null && i<detailebos.size();i++){
	   AttClassDetailBO detailebo=(AttClassDetailBO)detailebos.get(i);%>
    <tr>
      <td width="132" class=boxtitle><%=detailebo.getItemName() %></td>
      <td width="132" class=boxtitle><%=detailebo.getItemTime() %> </td>
    </tr>
 

 <%} %>
  </table>
  </div>
 </body>
 </html>
 