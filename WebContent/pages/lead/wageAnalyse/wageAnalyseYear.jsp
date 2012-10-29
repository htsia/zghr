<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.sys.service.ActivePageService" %>
<%@ page import="java.util.Vector" %>

<html>
<head>
<script language="javascript">
	//对比
	function refreshWageAnalyse(){
		var checkArr = "";
		var checkboxs = document.getElementsByName("mon");
        for(var i=0;i<checkboxs.length;i++){
            if(checkboxs[i].checked){
                if (checkArr==""){
                    checkArr=checkboxs[i].value;
                }
                else{
                    checkArr+=","+checkboxs[i].value;
                }
            }
         }
	   if(checkArr==""){
		  alert("请选择对比年份!");
       }else{
            window.returnValue=checkArr;
            window.close();
       }
   }
	
</script>
</head>

<body>
<link href="/css/styleDesktop.css" rel="stylesheet" type="text/css"/>
<style type="text/css">

.style1
{
    font-family: verdana;
	font-size: 9pt;
	cursor: default;
	border-collapse: collapse;
	border:2px solid #555555;
}
.style1 TH {
	FONT-SIZE: 9pt;
	COLOR: #555555;
	font-family: "宋体";
	background-color: #F3F3F3;
	font-weight: normal;
}
.style1 TR {
	FONT-SIZE: 9pt; COLOR: #555555; 
	border:1px solid #555555;
}
.style1 TD {
	FONT-SIZE: 9pt;
	COLOR: #555555;
	vertical-align:middle;
	font-family: "宋体";
	border:1px solid #555555;
}

</style>
<form id="form">
<input type="hidden" id="hide"></input>
	<%
	response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
	ActivePageService activepageservice = (ActivePageService) SysContext.getBean("sys_activePageService");
    String sql = "select distinct(substring(b721702,1,4)) as b721702 from b721 order by substring(b721702,1,4)";
    CellVO[] cv = new CellVO[1];
    cv[0] = new CellVO();
    cv[0].setItemId("b721702");
    Vector vtmonth = activepageservice.getDataListBySql(cv, sql);
    String[] month = new String[vtmonth.size()];
    for (int i = 0; i < vtmonth.size(); i++) {
        CellVO[] row = (CellVO[]) vtmonth.get(i);
        month[i] = row[0].getValue();
    }
    session.setAttribute("month", month);
	int iwidth = 140 + vtmonth.size() * 120; 
    String width = String.valueOf(iwidth);
	%>

    <br>
    请选择对比年份:
    <table align="center" border="1" class='style1' width="98%">
    <tr>
     <%
     for(int i=0;i<month.length;i++){
         out.println("<td align=center valign=middle height=20 width=120><strong><input type=checkbox name=mon value='"+month[i]+"'>"+month[i]+"</input></strong></td>");
     }
     %>
  </tr>
   </table>
    <table align="center" border="0" width="98%">
    <tr>
         <td align="right" ><input type="button" onclick="refreshWageAnalyse()" value="对比" class="button01"/></td>   
    </tr>
    </table>

</form>
</body>
</html>
