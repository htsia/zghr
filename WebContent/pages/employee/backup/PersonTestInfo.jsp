<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.emp.ucc.IBackUpUCC" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">
</head>

<body>
<br>
<%
    try {
        IBackUpUCC backucc = (IBackUpUCC) SysContext.getBean("emp_backUpUCC");
        List list = backucc.queryPersonTestInfo(CommonFuns.filterNull(request.getParameter("chk")));
        if (list == null || list.size() == 0) {
%>
<table align="center" width="650" border="0" cellspacing="0" cellpadding="0">
    <tr height="41">
        <td align="center" style="font-size:14.0pt"><b>
          <%=LanguageSupport.getResource( "RYGL-2081", "日常考察情况表")%>
         </b></td>
    </tr>
</table>
<table align="center" width="647" border="1" cellpadding="0" cellspacing="0"
       style="border-collapse: collapse;border:2px solid #555555">
    <tr height="35">
        <td align="center" width="99" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2082", "日常考察情况表")%>：</b></td>
        <td align="center" width="137" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td align="center" width="137" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2083", "考察人")%>：</b></td>
        <td align="center" width="137" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td align="center" width="137" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    </tr>
    <tr height="30">
        <td align="center" rowspan="2" height="285" width="99" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2084", "所   在   行   行   长   意    见")%></b></td>
        <td align="center" colspan=2 width="274" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2086", "优势")%></b></td>
        <td align="center" colspan=2 width="274" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2085", "不足")%></b></td>
    </tr>
    <tr height="255">
        <td height="255" colspan="2" width="274" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="274" colspan="2" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    </tr>
    <tr height="35">
        <td align="center" rowspan="2" height="287" width="99" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2087", "所  在  行  其  他  行  级  领  导  见")%></b></td>
        <td align="center" colspan=2 width="274" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2086", "优势")%></b></td>
        <td align="center" colspan=2 width="274" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2085", "不足")%></b></td>
    </tr>
    <tr height="255">
        <td height="255" colspan="2" width="274" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="274" colspan="2" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    </tr>
    <tr height="34">
        <td align="center" rowspan="2" height="286" width="99" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2088", "所  在  行  同  级  领  导  意  见")%></b></td>
        <td align="center" colspan=2 width="274" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2086", "优势")%></b></td>
        <td align="center" colspan=2 width="274" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2085", "不足")%></b></td>
    </tr>
    <tr height="255">
        <td height="255" colspan="2" width="274" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="274" colspan="2" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    </tr>
</table>
<%
} else {
%>
<table align="center" width="650" border="0" cellspacing="0" cellpadding="0">
    <tr height="41">
        <td align="center" style="font-size:14.0pt"><b><%=LanguageSupport.getResource( "RYGL-2082", "日常考察情况表")%></b></td>
    </tr>
</table>
<table align="center" width="647" border="1" cellpadding="0" cellspacing="0"
       style="border-collapse: collapse;border:2px solid #555555">
    <%
        for (int i = 0; i < list.size(); i++) {
            Map map = (Map) list.get(i);
            String cur = CommonFuns.filterNull((String) map.get("A855000"));
            if (cur.equals(Constants.YES)) {
    %>
    <tr height="35">
        <td align="center" width="99" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2082", "考察时间")%>：</b></td>
        <td align="center" width="137" style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map.get("A855201"))%></td>
        <td align="center" width="137" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2083", "考察人")%>：</b></td>
        <td align="center" width="137" style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map.get("A855202"))%></td>
        <td align="center" width="137" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    </tr>
    <tr height="30">
        <td align="center" rowspan="4" height="285" width="99" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2084", "所   在   行   行   长   意    见")%> </b></td>
        <td align="center" colspan="2" width="274" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2086", "优势")%></b></td>
        <td align="center" colspan="2" width="274" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2085", "不足")%></b></td>
    </tr>
    <tr height="255">
        <td height="255" colspan="2" width="274" style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map.get("A855203"))%></td>
        <td width="274" colspan="2" style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map.get("A855200"))%></td>
    </tr>
    <tr height="30">
        <td align="center" rowspan="4" height="285" width="99" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2087", "所  在  行  其  他  行  级  领  导  见")%></b></td>
        <td align="center" colspan="2" width="274" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2086", "优势")%></b></td>
        <td align="center" colspan="2" width="274" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2085", "不足")%></b></td>
    </tr>
    <tr height="255">
        <td height="255" colspan="2" width="274" style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map.get("A855204"))%></td>
        <td width="274" colspan="2" style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map.get("A855206"))%></td>
    </tr>
    <tr height="30">
        <td align="center" rowspan="4" height="285" width="99" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2088", "所  在  行  同  级  领  导  意  见")%></b></td>
        <td align="center" colspan="2" width="274" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2086", "优势")%></b></td>
        <td align="center" colspan="2" width="274" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2085", "不足")%></b></td>
    </tr>
    <tr height="255">
        <td height="255" colspan="2" width="274" style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map.get("A855205"))%></td>
        <td width="274" colspan="2" style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map.get("A855207"))%></td>
    </tr>
    <%
            }
        }
    %>
</table>
<%
        }
    } catch (Exception e) {

    }
%>
</body>
</html>
