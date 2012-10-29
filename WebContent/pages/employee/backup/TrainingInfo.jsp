<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.util.CodeUtil"%>
<%@ page import="com.hr319wg.emp.ucc.IBackUpUCC"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="java.util.Map"%>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">
</head>

<body>
<form id="form1">
    <input type="hidden" name="id" value="<%=CommonFuns.filterNull(request.getParameter("chk"))%>" />
      <table align="center" width="645" border="0" cellspacing="0" cellpadding="0">
    <tr height="43">
        <td align="right" height="43" style="font-size:14.0pt"><input type="button" value="导出并打印" onclick="window.open('/pages/employee/backup/TrainingInfoExcel.jsf?chk='+document.forms(0).id.value)"/></td>
    </tr>
</table>
<%
    try{
        IBackUpUCC backucc = (IBackUpUCC) SysContext.getBean("emp_backUpUCC");
        List list = backucc.queryPersonTrainingInfo(CommonFuns.filterNull(request.getParameter("chk")));
        if (list == null || list.size() == 0) {
%>


        <p align="center" style="font-size:14.0pt"><b><%=LanguageSupport.getResource( "RYGL-2101", "拓展训练情况表")%></b></p>

<table align="center" width="728" cellpadding="0" cellspacing="0" style="border-collapse: collapse;border:2px solid #555555">
    <tr height="41">
        <td align="center" width="105" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2102", "参训时间")%></b></td>
        <td colspan="2" width="185" style="border:1px solid #555555;">&nbsp;</td>
        <td align="center" width="96" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2103", "培训班名称")%></b></td>
        <td colspan="3" width="270" style="border:1px solid #555555;">&nbsp;</td>
    </tr>
    <tr height="39">
        <td align="center" width="105" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2103", "培训班名称")%></b></td>
        <td align="center" style="font-size:9.0pt;border:1px solid #555555;"><b>
          <%=LanguageSupport.getResource( "RYGL-2104", "得分档次")%>
        </b></td>
        <td align="center" colspan="5" width="463" style="font-size:9.0pt;border:1px solid #555555;"><b> <%=LanguageSupport.getResource( "RYGL-2105", "综合表现及典型事例")%></b></td>
    </tr>
    <tr height="36">
        <td height="108" width="105" style="border:1px solid #555555;">&nbsp;</td>
        <td width="88" style="border:1px solid #555555;">&nbsp;</td>
        <td colspan="5" width="463" style="border:1px solid #555555;">&nbsp;</td>
    </tr>
    <tr height="75">
        <td align="center" width="105" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2105", "该项目介绍")%></b></td>
        <td colspan="6" width="551" style="border:1px solid #555555;">&nbsp;</td>
    </tr>
<%
        } else {
            Map map1 = (Map) list.get(0);
%>

<p align="center" style="font-size:14.0pt"><b><%=LanguageSupport.getResource( "RYGL-2107", "拓展训练情况表")%></b></p>

<table width="728" cellpadding="0" cellspacing="0"  style="border-collapse: collapse;border:2px solid #555555">
    <tr height="41">
        <td align="center" width="105" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2102", "参训时间")%></b></td>
        <td align="center" colspan="2" width="185" style="border:1px solid #555555;"><%=CommonFuns.filterNull((String) map1.get("A220201"))%></td>
        <td align="center" width="96" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2103", "培训班名称")%></b></td>
        <td align="center" colspan="3" width="270" style="border:1px solid #555555;"><%=CommonFuns.filterNull((String) map1.get("A220202"))%></td>
    </tr>
<%
            for (int i=0;i<list.size();i++){
                Map map = (Map) list.get(i);
%>
    <tr height="39">
        <td align="center" width="105" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2108", "项目名称")%></b></td>
        <td align="center" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2109", "得分档次")%></b></td>
        <td align="center" colspan="5" width="463" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2110", "综合表现及典型事例")%></b></td>
    </tr>
    <tr height="36">
        <td align="center" height="108" width="105" style="border:1px solid #555555;"><%=i+1%>、<%=CodeUtil.interpertCode("0394", CommonFuns.filterNull((String) map.get("A220203")))%></td>
        <td align="center" width="88" style="border:1px solid #555555;"><%=CodeUtil.interpertCode("0395", CommonFuns.filterNull((String) map.get("A220204")))%></td>
        <td align="center" colspan="5" width="463" style="border:1px solid #555555;"><%=CommonFuns.filterNull((String) map.get("A220205"))%></td>
    </tr>
    <tr height="75">
        <td align="center" width="105" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2111", "该项目介绍")%></b></td>
        <td align="center" colspan="6" width="551" style="border:1px solid #555555;"><%=CommonFuns.filterNull((String) map.get("A220206"))%></td>
    </tr>
<%
            }
%>
</table>
<%
        }
    }catch(Exception e){

    }
%>
    </form>
</body>
</html>