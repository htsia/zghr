<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.emp.ucc.IBackUpUCC" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.doc.pojo.vo.PersonBasicInfoVO" %>
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
<%
    try {
        IBackUpUCC backucc = (IBackUpUCC) SysContext.getBean("emp_backUpUCC");
        List list = backucc.queryPersonArchiveInfo(CommonFuns.filterNull(request.getParameter("chk")));
        List list1 = backucc.queryPersonResumeInfo(CommonFuns.filterNull(request.getParameter("chk")));
        List list2 = backucc.queryFamilyInfo(CommonFuns.filterNull(request.getParameter("chk")));
       // List list3 = backucc.queryPersonDegreeInfo(CommonFuns.filterNull(request.getParameter("chk")));
       // List list4 = backucc.queryPersonSchoolInfo(CommonFuns.filterNull(request.getParameter("chk")));
        PersonBasicInfoVO vo = backucc.findZhEduction(CommonFuns.filterNull(request.getParameter("chk")));
        PersonBasicInfoVO vo1 = backucc.findEduction(CommonFuns.filterNull(request.getParameter("chk")));
%>
<form id="form1">
<input type="hidden" name="id" value="<%=CommonFuns.filterNull(request.getParameter("chk"))%>" />
<table align="center" width="645" border="0" cellspacing="0" cellpadding="0">
    <tr height="43">
        <td align="right" height="43" style="font-size:14.0pt"><input type="button" value="��������ӡ" onclick="window.open('/pages/employee/backup/PersonBaseInfoExcel.jsf?chk='+document.forms(0).id.value)"/></td>
    </tr>
</table>
<table align="center" width="645" border="0" cellspacing="0" cellpadding="0">
    <tr height="43">
        <td align="center" height="43" style="font-size:14.0pt"><b><%=LanguageSupport.getResource( "RYGL-2052", "���������")%></b></td>
    </tr>
</table>
<table align="center" width="645" cellpadding="0" cellspacing="0"
       style="border-collapse: collapse;border:2px solid #555555">
<%
    if (list == null && list.size() == 0) {
%>
<tr height="35">
    <td align="center" width="81" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-1016", " ����")%></b></td>
    <td align="center" width="102" style="border:1px solid #555555;">&nbsp;</td>
    <td align="center" width="92" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "MSG-0012", " �Ա�")%></b></td>
    <td align="center" width="100" style="border:1px solid #555555;">&nbsp;</td>
    <td align="center" width="82" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "MSG-0013", " ��������")%></b></td>
    <td align="center" width="99" style="border:1px solid #555555;">&nbsp;</td>
    <td rowspan="4" width="100" style="border:1px solid #555555;">&nbsp;</td>
</tr>
<tr height="35">
    <td align="center" width="81" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2053", " ����")%></b></td>
    <td align="center" width="102" style="border:1px solid #555555;">&nbsp;</td>
    <td align="center" width="92" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2054", " ������ò")%></b></td>
    <td align="center" width="105" style="border:1px solid #555555;">&nbsp;</td>
    <td align="center" width="82" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2055", " �μӵ���ʱ��")%></b></td>
    <td align="center" width="99" style="border:1px solid #555555;">&nbsp;</td>
</tr>
<tr height="35">
    <td align="center" width="81" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2056", " ������")%></b></td>
    <td align="center" width="102" style="border:1px solid #555555;">&nbsp;</td>
    <td align="center" width="92" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2057", " ����")%></b></td>
    <td align="center" width="105" style="border:1px solid #555555;">&nbsp;</td>
    <td align="center" width="82" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2058", " ����״��")%></b></td>
    <td align="center" width="99" style="border:1px solid #555555;">&nbsp;</td>
</tr>
<tr height="35">
    <td align="center" width="81" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2059", " ����ʱ��")%></b></td>
    <td align="center" width="102" style="border:1px solid #555555;">&nbsp;</td>
    <td align="center" width="92" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2060", " ��ϵͳʱ��")%></b></td>
    <td align="center" width="105" style="border:1px solid #555555;">&nbsp;</td>
    <td align="center" width="82" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2061|", " רҵ�����ʸ�")%></b></td>
    <td align="center" width="99" style="border:1px solid #555555;">&nbsp;</td>
</tr>
<tr height="35">
    <td align="center" width="81" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2062", " ���ڷ���")%></b></td>
    <td align="center" colspan="3" width="299" style="border:1px solid #555555;">&nbsp;</td>
    <td align="center" width="82" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2063", " ���ڲ���")%></b></td>
    <td align="center" colspan="2" width="199" style="border:1px solid #555555;">&nbsp;</td>
</tr>
<tr height="35">
    <td align="center" width="81" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2064", " ����ְ��")%></b></td>
    <td align="center" width="102" style="border:1px solid #555555;">&nbsp;</td>
    <td align="center" width="92" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2065", " ְ��ȼ�")%></b></td>
    <td align="center" width="105" style="border:1px solid #555555;">&nbsp;</td>
    <td align="center" width="82" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2066", " ��ְͬ��ְ��ʱ��")%></b></td>
    <td align="center" colspan="2" width="199" style="border:1px solid #555555;">&nbsp;</td>
</tr>
<tr height="35">
    <td align="center" width="81" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2067", " ���˲���������")%></b></td>
    <td align="center" colspan="3" width="299" style="border:1px solid #555555;">&nbsp;</td>
    <td align="center" width="82" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2068", " ȷ��Ϊ���˲�ʱ��")%></b></td>
    <td align="center" colspan="2" width="199" style="border:1px solid #555555;">&nbsp;</td>
</tr>
<%
} else {
    Map map = (Map) list.get(0);
    String pid = (String) map.get("ID");
    PersonBO bo = SysCacheTool.findPersonById(pid);
    String imgid = bo.getImageId();
%>
<tr height="35">
    <td align="center" width="81" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "MSG-0010", " �� ��")%></b></td>
    <%
        if (map.get("A001001") == null || map.get("A001001").equals("")) {
    %>
    <td align="center" width="102" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <%
    } else {
    %>
    <td align="center" width="102"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map.get("A001001"))%></td>
    <%
        }
    %>
    <td align="center" width="92" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "MSG-0012", " �Ա�")%></b></td>
    <%
        if (map.get("A001007") == null || map.get("A001007").equals("")) {
    %>
    <td align="center" width="100" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <%
    } else {
    %>
    <td align="center" width="100"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CodeUtil.interpertCode("0100", CommonFuns.filterNull((String) map.get("A001007")))%></td>
    <%
        }
    %>
    <td align="center" width="82" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "MSG-0013", "��������")%></b></td>
    <%
        if (map.get("A001011") == null || map.get("A001011").equals("")) {
    %>
    <td align="center" width="99" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <%
    } else {
    %>
    <td align="center" width="99"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map.get("A001011")).replaceAll("-", ".")%></td>
    <%
        }
    %>
    <td rowspan="4" width="100" style="font-size:9.0pt;border:1px solid #555555;">
        <div id=seryFilterDiv style="cursor:move;position:absolute;z-index:0;left:800px;top:55px;">
            <img id=showZP src="/pages/common/photo.jsp?id=<%=imgid%>>" width=110 height=140 alt="��Ƭ">
        </div>
    </td>
</tr>
<tr height="35">
    <td align="center" width="81" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2053", " ����")%></b></td>
    <%
        if (map.get("A001014") == null || map.get("A001014").equals("")) {
    %>
    <td align="center" width="102" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <%
    } else {
    %>
    <td align="center" width="102"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CodeUtil.interpertCode("0105", CommonFuns.filterNull((String) map.get("A001014")))%></td>
    <%
        }
    %>
    <td align="center" width="92" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2054", " ������ò")%></b></td>
    <%
        if (map.get("A001009") == null || map.get("A001009").equals("")) {
    %>
    <td align="center" width="105" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <%
    } else {
    %>
    <td align="center" width="105"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CodeUtil.interpertCode("0120", CommonFuns.filterNull((String) map.get("A001009")))%></td>
    <%
        }
    %>
    <td align="center" width="82" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2055", " �μӵ���ʱ��")%></b></td>
    <%
        if (map.get("A001718") == null || map.get("A001718").equals("")) {
    %>
    <td align="center" width="99" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <%
    } else {
    %>
    <td align="center" width="99"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map.get("A001718")).replaceAll("-", ".")%></td>
    <%
        }
    %>
</tr>
<tr height="35">
    <td align="center" width="81" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2056", " ������")%></b></td>
    <%
        if (map.get("A001017") == null || map.get("A001017").equals("")) {
    %>
    <td align="center" width="102" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <%
    } else {
    %>
    <td align="center" width="102"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CodeUtil.interpertCode("0105", CommonFuns.filterNull((String) map.get("A001017")))%></td>
    <%
        }
    %>
    <td align="center" width="92" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2057", " ����")%></b></td>
    <%
        if (map.get("A001021") == null || map.get("A001021").equals("")) {
    %>
    <td align="center" width="105" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <%
    } else {
    %>
    <td align="center" width="105"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CodeUtil.interpertCode("0115", CommonFuns.filterNull((String) map.get("A001021")))%></td>
    <%
        }
    %>
    <td align="center" width="82" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2058", " ����״��")%></b></td>
    <%
        if (map.get("A001024") == null || map.get("A001024").equals("")) {
    %>
    <td align="center" width="99" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <%
    } else {
    %>
    <td align="center" width="99"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map.get("A001024"))%></td>
    <%
        }
    %>
</tr>
<tr height="35">
    <td align="center" width="81" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2059", " ����ʱ��")%></b></td>
    <%
        if (map.get("A001041") == null || map.get("A001041").equals("")) {
    %>
    <td align="center" width="102" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <%
    } else {
    %>
    <td align="center" width="102"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map.get("A001041")).replaceAll("-", ".")%></td>
    <%
        }
    %>
    <td align="center" width="92" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2060", " ��ϵͳʱ��")%></b></td>
    <%
        if (map.get("A001044") == null || map.get("A001044").equals("")) {
    %>
    <td align="center" width="105" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <%
    } else {
    %>
    <td align="center" width="105"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map.get("A001044")).replaceAll("-", ".")%></td>
    <%
        }
    %>
    <td align="center" width="82" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2061", " רҵ�����ʸ�")%></b></td>
    <%
        if (map.get("A010005") == null || map.get("A010005").equals("")) {
    %>
    <td align="center" width="99" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <%
    } else {
    %>
    <td align="center" width="100"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CodeUtil.interpertCode("0330", CommonFuns.filterNull((String) map.get("A010005")))%></td>
    <%
        }
    %>
</tr>
<tr height="35">
    <td align="center" width="81" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2062", " ���ڷ���")%></b></td>
    <%
        if (map.get("A001701") == null || map.get("A001701").equals("")) {
    %>
    <td align="center" colspan="3" width="299" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <%
    } else {
    %>
    <td align="center" colspan="3"
        width="299"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CodeUtil.interpertCode("OU", CommonFuns.filterNull((String) map.get("A001701")))%></td>
    <%
        }
    %>
    <td align="center" width="82" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "XTGL-1045", "���ڲ���")%></b></td>
    <%
        if (map.get("A001705") == null || map.get("A001705").equals("")) {
    %>
    <td align="center" colspan="2" width="199" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <%
    } else {
    %>
    <td align="center" colspan="2" width="199" style="font-size:9.0pt;border:1px solid #555555;"
            ><%=CodeUtil.interpertCode("OU", CommonFuns.filterNull((String) map.get("A001705")))%></td>
    <%
        }
    %>
</tr>
<tr height="35">
    <td align="center" width="81" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2064", " ����ְ��")%></b></td>
    <%
        if (map.get("A705205") == null || map.get("A705205").equals("")) {
    %>
    <td align="center" width="102" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <%
    } else {
    %>
    <td align="center" width="102"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CodeUtil.interpertCode("0160", CommonFuns.filterNull((String) map.get("A705205")))%></td>
    <%
        }
    %>
    <td align="center" width="92" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2065", " ְ��ȼ�")%></b></td>
    <%
        if (map.get("A705208") == null || map.get("A705208").equals("")) {
    %>
    <td align="center" width="105" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <%
    } else {
    %>
    <td align="center" width="105"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CodeUtil.interpertCode("0165", CommonFuns.filterNull((String) map.get("A705208")))%></td>
    <%
        }
    %>
    <td align="center" width="82" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2066", " ��ְͬ��ְ��ʱ��")%></b></td>
    <%
        if (map.get("A705228") == null || map.get("A705228").equals("")) {
    %>
    <td align="center" colspan="2" width="199" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <%
    } else {
    %>
    <td align="center" colspan="2" width="199"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map.get("A705228")).replaceAll("-", ".")%></td>
    <%
        }
    %>
</tr>
<tr height="35">
    <td align="center" width="81" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2067", " ���˲���������")%></b></td>
    <%
        if (map.get("A067705") == null || map.get("A067705").equals("")) {
    %>
    <td align="center" colspan="3" width="299" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <%
    } else {
    %>
    <td align="center" colspan="3" width="299"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CodeUtil.interpertCode("0391", CommonFuns.filterNull((String) map.get("A067705")))%></td>
    <%
        }
    %>
    <td align="center" width="82" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2068", " ȷ��Ϊ���˲�ʱ��")%></b></td>
    <%
        if (map.get("A067701") == null || map.get("A067701").equals("")) {
    %>
    <td align="center" colspan="2" width="199" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <%
    } else {
    %>
    <td align="center" colspan="2" width="199"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map.get("A067701")).replaceAll("-", ".")%></td>
</tr>
<%
        }
    }
%>
<tr height="35">
    <td align="center" width="81" style="font-size:9.0pt;border:1px solid #555555;"><b>����</b></td>
    <td align="center" width="102" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2069", " ���ѧ��")%></b></td>
    <td align="center" colspan="2" width="197" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2070", " ��ҵԺУ��רҵ")%></b></td>
    <td align="center" width="82" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RRYGL-2071", " ���ѧλ")%></b></td>
    <td align="center" colspan="2" width="199" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2072", "��ҵԺУ��רҵ")%></b></td>
</tr>
<tr height="35">
    <td align="center" width="81" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2073", " ȫ����")%></b></td>
    <%
        if (vo1 != null) {
    %>
    <td align="center" width="102" style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull(vo1.getStudyRecord())%></td>
    <td align="center" colspan="2" width="197" style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull(vo1.getStudySchoolAndMajor())%></td>
    <td align="center" width="82" style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull(vo1.getDegreeAW())%></td>
    <td align="center" colspan="2" width="199" style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull(vo1.getStudySchoolAndMajorAW())%></td>
    <%
    } else {
    %>
    <td align="center" width="102" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <td align="center" colspan="2" width="197" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <td align="center" width="82" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <td align="center" colspan="2" width="199" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <%

        }
    %>
</tr>
<tr height="35">
    <td align="center" width="81" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2074", " �ڡ�ְ")%></b></td>
    <%
        if (vo != null) {
    %>
    <td align="center" width="102" style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull(vo.getStudyRecordAW())%></td>
    <td align="center" colspan="2" width="197" style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull(vo.getStudySchoolAndMajor())%></td>
    <td align="center" width="82" style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull(vo.getDegreeAW())%></td>
    <td align="center" colspan="2" width="199" style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull(vo.getStudySchoolAndMajorAW())%></td>
    <%
    } else {
    %>
    <td align="center" width="102" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <td align="center" colspan="2" width="197" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <td align="center" width="82" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <td align="center" colspan="2" width="199" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <%
        }
    %>
</tr>
<tr>
    <td align="center" width="81" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2075", " ����")%></b></td>
    <td align="center" colspan="6"  valign="top">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table03" >
            <%
                if (list1 == null && list1.size() == 0) {
            %>
            <tr height="19"><td width="580">&nbsp;</td></tr>
            <tr height="19"><td width="580">&nbsp;</td></tr>
            <tr height="19"><td width="580">&nbsp;</td></tr>
            <%
            } else {
            %>
            <tr height="19"><td width="580">&nbsp;</td></tr>
            <%
                for (int i = 0; i < list1.size(); i++) {
            %>
            <tr height="19">
                <%
                    Map map = (Map) list1.get(i);
                    String sdate = CommonFuns.filterNull((String) map.get("A019005"));//��ʼʱ��
                    String edate = CommonFuns.filterNull((String) map.get("A019010"));//��ֹʱ��
                    String unit = CommonFuns.filterNull((String) map.get("A019015"));//���ڵ�λ
                    String duty = CommonFuns.filterNull((String) map.get("A019205"));//ְ������
                %>
                <td width="580" style="font-size:9.0pt;"><%=sdate.replaceAll("-", ".")%>--<%=edate.replaceAll("-", ".")%>&nbsp;<%=unit%>
                    &nbsp;<%=duty%></td>
            </tr>
            <%
                }
            %>
            <tr height="19"><td width="580">&nbsp;</td></tr>
            <%
                }
            %>
        </table>
    </td>
</tr>
<tr>
    <td align="center" width="81" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2076", " ��Ҫ��ͥ��Ա������ϵ���")%></b></td>
    <td align="center" colspan="6" style="font-size:9.0pt;border:1px solid #555555;">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table03">
            <tr>
                <td align="center" style="font-size:9.0pt;border:1px solid #555555;" width="102"><b><%=LanguageSupport.getResource( "RYGL-2077", " ��ν")%></b></td>
                <td align="center" style="font-size:9.0pt;border:1px solid #555555;" width="49"><b><%=LanguageSupport.getResource( "RYGL-1016", " ����")%></b></td>
                <td align="center" style="font-size:9.0pt;border:1px solid #555555;" width="43"><b><%=LanguageSupport.getResource( "RYGL-2078", " ��")%></b></td>
                <td align="center" style="font-size:9.0pt;border:1px solid #555555;" width="105"><b><%=LanguageSupport.getResource( "MSG-0013", " ��������")%></b></td>
                <td align="center" style="font-size:9.0pt;border:1px solid #555555;" width="82"><b><%=LanguageSupport.getResource( "RYGL-2054", "������ò")%></b></td>
                <td align="center" style="font-size:9.0pt;border:1px solid #555555;" width="199"><b><%=LanguageSupport.getResource( "RYGL-2079", " ������λ��ְ��")%></b></td>
            </tr>
            <%
                if (list2 == null && list2.size() == 0) {
            %>
            <tr>
                <td align="center" width="102">&nbsp;</td>
                <td align="center" width="49">&nbsp;</td>
                <td align="center" width="43">&nbsp;</td>
                <td align="center" width="105">&nbsp;</td>
                <td align="center" width="82">&nbsp;</td>
                <td align="center" width="199">&nbsp;</td>
            </tr>
            <%
            } else {
                for (int i = 0; i < list2.size(); i++) {
                    Map map = (Map) list2.get(i);
            %>
            <tr>
                <%
                    if (map.get("A079010") == null || map.get("A079010").equals("")) {
                %>
                <td align="center" width="102">&nbsp;</td>
                <%
                } else {
                %>
                <td align="center" style="font-size:9.0pt;"
                    width="102"><%=CodeUtil.interpertCode("0150", CommonFuns.filterNull((String) map.get("A079010")))%></td>
                <%
                    }
                    if (map.get("A079005") == null || map.get("A079005").equals("")) {
                %>
                <td align="center" width="49">&nbsp;</td>
                <%
                } else {
                %>
                <td align="center" width="49" style="font-size:9.0pt;"><%=CommonFuns.filterNull((String) map.get("A079005"))%></td>
                <%
                    }
                    if (map.get("A079201") == null || map.get("A079201").equals("")) {
                %>
                <td align="center" width="43">&nbsp;</td>
                <%
                } else {
                %>
                <td align="center" style="font-size:9.0pt;"
                    width="43"><%=CodeUtil.interpertCode("0100", CommonFuns.filterNull((String) map.get("A079201")))%></td>
                <%
                    }
                    if (map.get("A079015") == null || map.get("A079015").equals("")) {
                %>
                <td align="center" width="105">&nbsp;</td>
                <%
                } else {
                %>
                <td align="center"  style="font-size:9.0pt;"
                    width="105"><%=CommonFuns.filterNull((String) map.get("A079015")).replaceAll("-", ".")%></td>
                <%
                    }
                    if (map.get("A079025") == null || map.get("A079025").equals("")) {
                %>
                <td align="center" width="82">&nbsp;</td>
                <%
                } else {
                %>
                <td align="center" style="font-size:9.0pt;"
                    width="82"><%=CodeUtil.interpertCode("0120", CommonFuns.filterNull((String) map.get("A079025")))%></td>
                <%
                    }
                    if (map.get("A079020") == null || map.get("A079020").equals("")) {
                %>
                <td align="center" width="199">&nbsp;</td>
                <%
                } else {
                %>
                <td align="center" width="199" style="font-size:9.0pt;"><%=CommonFuns.filterNull((String) map.get("A079020"))%></td>
                <%
                    }
                %>
            </tr>
            <%
                        }
                    }
                } catch (Exception e) {

                }
            %>
        </table>
    </td>
</tr>
</table>
</form>
</body>
</html>
