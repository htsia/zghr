<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.util.CodeUtil"%>
<%@ page import="com.hr319wg.emp.ucc.IBackUpUCC"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="java.util.Map"%>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">
</head>

<body>
<%
    try{
        IBackUpUCC backucc = (IBackUpUCC) SysContext.getBean("emp_backUpUCC");
        List list = backucc.queryPersonTrainingInfo(CommonFuns.filterNull(request.getParameter("chk")));
        if (list == null || list.size() == 0) {
%>

        <p align="center" style="font-size:14.0pt"><b><%=LanguageSupport.getResource( "RYGL-2107", "��չѵ�������")%></b></p>

<table align="center" width="728" cellpadding="0" cellspacing="0" style="border-collapse: collapse;border:2px solid #555555">
    <tr height="41">
        <td align="center" width="105" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2102", "��ѵʱ��")%></b></td>
        <td colspan="2" width="185" style="border:1px solid #555555;">&nbsp;</td>
        <td align="center" width="96" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2103", "��ѵ������")%></b></td>
        <td colspan="3" width="270" style="border:1px solid #555555;">&nbsp;</td>
    </tr>
    <tr height="39">
        <td align="center" width="105" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2108", "��Ŀ����")%></b></td>
        <td align="center" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2109", "�÷ֵ���")%></b></td>
        <td align="center" colspan="5" width="463" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2110", "�ۺϱ��ּ���������")%></b></td>
    </tr>
    <tr height="36">
        <td height="108" width="105" style="border:1px solid #555555;">&nbsp;</td>
        <td width="88" style="border:1px solid #555555;">&nbsp;</td>
        <td colspan="5" width="463" style="border:1px solid #555555;">&nbsp;</td>
    </tr>
    <tr height="75">
        <td align="center" width="105" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2111", "����Ŀ����")%></b></td>
        <td colspan="6" width="551" style="border:1px solid #555555;">&nbsp;</td>
    </tr>
    </table>
<%
        } else {
            Map map1 = (Map) list.get(0);
%>

        <p align="center" style="font-size:14.0pt"><b><%=LanguageSupport.getResource( "RYGL-2107", "��չѵ�������")%></b></p>

<table width="728" cellpadding="0" cellspacing="0"  style="border-collapse: collapse;border:2px solid #555555">
    <tr height="41">
        <td align="center" width="105" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2102", "��ѵʱ��")%></b></td>
        <td align="center" colspan="2" width="185" style="border:1px solid #555555;"><%=CommonFuns.filterNull((String) map1.get("A220201"))%></td>
        <td align="center" width="96" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2103", "��Ŀ����")%></b></td>
        <td align="center" colspan="3" width="270" style="border:1px solid #555555;"><%=CommonFuns.filterNull((String) map1.get("A220202"))%></td>
    </tr>
<%
            for (int i=0;i<list.size();i++){
                Map map = (Map) list.get(i);
%>
    <tr height="39">
        <td align="center" width="105" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2108", "��Ŀ����")%></b></td>
        <td align="center" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2109", "�÷ֵ���")%></b></td>
        <td align="center" colspan="5" width="463" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2105", "�ۺϱ��ּ���������")%></b></td>
    </tr>
    <tr height="36">
        <td align="center" height="108" width="105" style="border:1px solid #555555;"><%=i+1%>��<%=CodeUtil.interpertCode("0394", CommonFuns.filterNull((String) map.get("A220203")))%></td>
        <td align="center" width="88" style="border:1px solid #555555;"><%=CodeUtil.interpertCode("0395", CommonFuns.filterNull((String) map.get("A220204")))%></td>
        <td align="center" colspan="5" width="463" style="border:1px solid #555555;"><%=CommonFuns.filterNull((String) map.get("A220205"))%></td>
    </tr>
    <tr height="75">
        <td align="center" width="105" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2111", "����Ŀ����")%></b></td>
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

</body>
</html>