<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.emp.ucc.IBackUpUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
</head>

<body>
<%
    try {
        IBackUpUCC backucc = (IBackUpUCC) SysContext.getBean("emp_backUpUCC");
        List list = backucc.queryPersonPunishInfo(CommonFuns.filterNull(request.getParameter("chk")));
        if (list == null || list.size() == 0) {

%>


        <p align="center" style="font-size:14.0pt"><b>  <%=LanguageSupport.getResource( "RYGL-2089", "奖惩情况表")%></b></p>

<table align="center" width="650" border="1" cellpadding="0" cellspacing="0"
       style="border-collapse: collapse;border:2px solid #555555">
    <tr height="38">
        <td align="center" colspan="6" width="650" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2090", "获奖情况")%></b></td>
    </tr>
    <tr height="52">
        <td align="center" width="52" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "YXGL-1035", "序号")%></b></td>
        <td align="center" width="119" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2091", "奖励名称")%></b></td>
        <td align="center" width="96" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2092", "获奖时间")%></b></td>
        <td align="center" width="136" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2093", "授奖单位")%></b></td>
        <td align="center" colspan="2" width="247" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2094", "因何种原因授奖")%></b></td>
    </tr>
    <tr height="52">
        <td align="center" width="52" style="font-size:9.0pt;border:1px solid #555555;"><b>1</b></td>
        <td width="119" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="96" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="136" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td colspan="2" width="247" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    </tr>
    <tr height="52">
        <td align="center" width="52" style="font-size:9.0pt;border:1px solid #555555;"><b>2</b></td>
        <td width="119" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="96" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="136" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td colspan="2" width="247" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    </tr>
    <tr height="52">
        <td align="center" width="52" style="font-size:9.0pt;border:1px solid #555555;"><b>3</b></td>
        <td width="119" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="96" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="136" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td colspan="2" width="247" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    </tr>
    <tr height="52">
        <td align="center" width="52" style="font-size:9.0pt;border:1px solid #555555;"><b>4</b></td>
        <td width="119" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="96" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="136" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td colspan="2" width="247" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    </tr>
    <tr height="52">
        <td align="center" width="52" style="font-size:9.0pt;border:1px solid #555555;"><b>5</b></td>
        <td width="119" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="96" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="136" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td colspan="2" width="247" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    </tr>
    <tr height="52">
        <td align="center" width="52" style="font-size:9.0pt;border:1px solid #555555;"><b>6</b></td>
        <td width="119" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="96" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="136" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td colspan="2" width="247" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    </tr>
    <tr height="52">
        <td align="center" width="52" style="font-size:9.0pt;border:1px solid #555555;"><b>7</b></td>
        <td width="119" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="96" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="136" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td colspan="2" width="247" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    </tr>
    <tr height="52">
        <td align="center" width="52" style="font-size:9.0pt;border:1px solid #555555;"><b>8</b></td>
        <td width="119" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="96" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="136" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td colspan="2" width="247" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    </tr>
    <tr height="38">
        <td align="center" colspan="6" width="650" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2095", "惩罚情况")%></b></td>
    </tr>
    <tr height="52">
        <td align="center" width="52" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "YXGL-1035", "序号")%></b></td>
        <td align="center" width="119" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2096", "处分名称")%></b></td>
        <td align="center" width="96" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2097", "处分时间")%></b></td>
        <td align="center" width="136" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2098", "处分单位")%></b></td>
        <td align="center" colspan="2" width="247" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2099", "因何种原因处分")%></b></td>
    </tr>
    <tr height="52">
        <td align="center" width="52" style="font-size:9.0pt;border:1px solid #555555;"><b>1</b></td>
        <td width="119" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="96" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="136" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td colspan="2" width="247" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    </tr>
    <tr height="52">
        <td align="center" width="52" style="font-size:9.0pt;border:1px solid #555555;"><b>2</b></td>
        <td width="119" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="96" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="136" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td colspan="2" width="247" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    </tr>
    <tr height="52">
        <td align="center" width="52" style="font-size:9.0pt;border:1px solid #555555;"><b>3</b></td>
        <td width="119" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="96" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td width="136" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
        <td colspan="2" width="247" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    </tr>
</table>
<%
} else {

%>

        <p align="center" style="font-size:14.0pt"><b><%=LanguageSupport.getResource( "RYGL-2089", "奖惩情况表")%></b></p>

<table align="center" width="650" cellpadding="0" cellspacing="0"
       style="border-collapse: collapse;border:2px solid #555555">
<tr height="38">
    <td align="center" colspan="6" width="650" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2090", "获奖情况")%></b></td>
</tr>
<tr height="52">
    <td align="center" width="52" style="font-size:9.0pt;border:1px solid #555555;"><b> <%=LanguageSupport.getResource( "YXGL-1035", "序号")%></b></td>
    <td align="center" width="119" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2091", "奖励名称")%></b></td>
    <td align="center" width="96" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2092", "获奖时间")%></b></td>
    <td align="center" width="136" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2093", "授奖单位")%></b></td>
    <td align="center" colspan="2" width="247" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2094", "因何种原因授奖")%></b></td>
</tr>
<%

    List list1 = new ArrayList();
    for (int i = 0; i < list.size(); i++) {
        Map map = (Map) list.get(i);
        String type = CommonFuns.filterNull((String) map.get("A026205"));
        if(type.length() > 5){
            if (type.substring(4, 5).equals("1")) {
                list1.add(map);
            }
        }
    }


    if (list1 != null && list1.size() > 0) {
        if (list1.size() > 8) {
            for (int j = 0; j < 8; j++) {
                Map map1 = (Map) list.get(j);
%>
<tr height="52">
    <td align="center" width="52" style="font-size:9.0pt;border:1px solid #555555;"><%=j + 1%></td>
    <td width="119"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map1.get("A026210"))%></td>
    <td width="96"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map1.get("A026220"))%></td>
    <td width="136"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map1.get("A026225"))%></td>
    <td colspan="2" width="247"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map1.get("A026215"))%></td>
</tr>
<%
    }
} else {
        int count = list1.size() ;
    int len = 8 - list1.size();
    for (int j = 0; j < list1.size(); j++) {
        Map map1 = (Map) list1.get(j);
%>
<tr height="52">
    <td align="center" width="52" style="font-size:9.0pt;border:1px solid #555555;"><%=j + 1%></td>
    <td width="119"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map1.get("A026210"))%></td>
    <td width="96"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map1.get("A026220"))%></td>
    <td width="136"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map1.get("A026225"))%></td>
    <td colspan="2" width="247"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map1.get("A026215"))%></td>
</tr>
<%
    }
    for (int n = 0; n < len; n++) {
%>
<tr height="52">
    <td align="center" width="52" style="font-size:9.0pt;border:1px solid #555555;"><%=count+n+1%></td>
    <td width="119" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <td width="96" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <td width="136" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <td colspan="2" width="247" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
</tr>
<%
        }
    }
} else {
    for (int m = 0; m < 8; m++) {
%>
<tr height="52">
    <td align="center" width="52" style="font-size:9.0pt;border:1px solid #555555;"><%=m+1%></td>
    <td width="119" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <td width="96" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <td width="136" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <td colspan="2" width="247" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
</tr>
<%
        }
    }

%>
<tr height="38">
    <td align="center" colspan="6" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2095", "惩罚情况")%></b></td>
</tr>
<tr height="52">
    <td align="center" width="52" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "YXGL-1035", "序号")%></b></td>
    <td align="center" width="119" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2096", "处分名称")%></b></td>
    <td align="center" width="96" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2097", "处分时间")%></b></td>
    <td align="center" width="136" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2098", "处分单位")%></b></td>
    <td align="center" colspan="2" width="247" style="font-size:9.0pt;border:1px solid #555555;"><b><%=LanguageSupport.getResource( "RYGL-2099", "因何种原因处分")%></b></td>
</tr>
<%
    List list2 = new ArrayList();
    for (int i = 0; i < list.size(); i++) {
        Map map = (Map) list.get(i);
        String type = CommonFuns.filterNull((String) map.get("A026205"));
         if(type.length() > 5) {
        if (type.substring(4, 5).equals("2")) {
            list2.add(map);
        }
    }
    }
    if (list2 != null && list2.size() > 0) {
        if (list2.size() > 3) {
            for (int j = 0; j < 3; j++) {
                Map map1 = (Map) list2.get(j);
%>
<tr height="52">
    <td align="center" width="52" style="font-size:9.0pt;border:1px solid #555555;"><%=j + 1%></td>
    <td width="119"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map1.get("A026210"))%></td>
    <td width="96"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map1.get("A026220"))%></td>
    <td width="136"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map1.get("A026225"))%></td>
    <td colspan="2" width="247"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map1.get("A026215"))%></td>
</tr>
<%
    }
} else {
        int count = list2.size();
    int len = 3-list2.size();
    for (int j = 0; j < list2.size(); j++) {
        Map map1 = (Map) list2.get(j);

%>
<tr height="52">
    <td align="center" width="52" style="font-size:9.0pt;border:1px solid #555555;"><%=j + 1%></td>
    <td width="119"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map1.get("A026210"))%></td>
    <td width="96"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map1.get("A026220"))%></td>
    <td width="136"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map1.get("A026225"))%></td>
    <td colspan="2" width="247"
        style="font-size:9.0pt;border:1px solid #555555;"><%=CommonFuns.filterNull((String) map1.get("A026215"))%></td>
</tr>
<%
    }
    for (int n = 0; n < len; n++) {
%>
<tr height="52">
    <td align="center" width="52" style="font-size:9.0pt;border:1px solid #555555;"><%=count+n+1%></td>
    <td width="119" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <td width="96" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <td width="136" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <td colspan="2" width="247" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
</tr>
<%
        }
    }
} else {
    for (int i = 0; i < 3; i++) {
%>
<tr height="52">
    <td align="center" width="52" style="font-size:9.0pt;border:1px solid #555555;"><%=i+1%></td>
    <td width="119" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <td width="96" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <td width="136" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
    <td colspan="2" width="247" style="font-size:9.0pt;border:1px solid #555555;">&nbsp;</td>
</tr>
<%
        }
    }


%>
</table>
<%
        }
    }
    catch
            (Exception
            e
            ) {

    }
%>
</body>
</html>
