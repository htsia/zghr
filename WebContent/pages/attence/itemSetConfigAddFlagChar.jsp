<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<%
String[] flagchars={"●","○","■","□","◎","╳","※","☆","★","¤","⊙","∴","∵","∷","╬","╋","▓","↑","▲","△","▼","▽","◆","∧","∨","Ω","∽","‖","∩","∪","≌","≦","≧","﹪","＃","＆","＠","﹡","￥","√"};
%>
<html>
<title></title>
<head>
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
<script language="JavaScript" type="text/JavaScript">
function GetDate(id){
    window.returnValue=id;
    window.close();
}
</script>
</head>
<body>
<h3>说明：直接单击要选择的字符即可</h3>
<table border="1" class='table_css1' width="100%" height="80%">
<%
for(int i=0;i<flagchars.length;i+=5){
%>
<tr>
 <td class='td_class'  onclick="GetDate('<%=flagchars[i] %>')" onmousemove="this.className='bg-hover'" onmouseout="this.className='td_class'">
 <%=flagchars[i] %>
 </td>
  <td class='td_class'  onclick="GetDate('<%=flagchars[i+1] %>')" onmousemove="this.className='bg-hover'" onmouseout="this.className='td_class'">
 <%=flagchars[i+1] %>
 </td>
  <td class='td_class'  onclick="GetDate('<%=flagchars[i+2] %>')" onmousemove="this.className='bg-hover'" onmouseout="this.className='td_class'">
 <%=flagchars[i+2] %>
 </td>
  <td class='td_class'  onclick="GetDate('<%=flagchars[i+3] %>')" onmousemove="this.className='bg-hover'" onmouseout="this.className='td_class'">
 <%=flagchars[i+3] %>
 </td>
  <td class='td_class'  onclick="GetDate('<%=flagchars[i+4] %>')" onmousemove="this.className='bg-hover'" onmouseout="this.className='td_class'">
 <%=flagchars[i+4] %>
 </td>
</tr>
<%} %>
</table>
</body>
</html>
