<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.sys.api.UserAPI" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>

<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

%>

<html>
<head>
    <title>人员档案浏览</title>
	<link rel="stylesheet" type="text/css"  		href="<%=request.getContextPath()%>/css/style.css" />
		<style>
.td_sec1 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #333333;
    background-color: #2074C5;
    border-left: 0px;
    border-top: 0px;
    border-right: 1px solid #BCBCBC;
    border-bottom: 1px solid #BCBCBC;
	text-align:center;
	height:30;
}
A.lead_white_link:link {font-family:Verdana, Arial, Helvetica, sans-serif;font-size: 12px;color: #FFFFFF;text-decoration: none;}
A.lead_white_link:active {font-family:Verdana, Arial, Helvetica, sans-serif;font-size: 12px;color: #FFFFFF;text-decoration: underline;}
A.lead_white_link:visited {font-family:Verdana, Arial, Helvetica, sans-serif;font-size: 12px;color: #FFFFFF;text-decoration: none;}
A.lead_white_link:hover {font-family:Verdana, Arial, Helvetica, sans-serif;font-size: 12px;color: #FFFFFF;text-decoration: underline;}

.td_sec2 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #333333;
    background-color: #666699;
    border-left: 0px;
    border-top: 0px;
    border-right: 1px solid #BCBCBC;
    border-bottom: 1px solid #BCBCBC;
	text-align:center;
	height:30;
}
.table{
	border-collapse:collapse;
	border-top: 1px #BCBCBC solid;
	border-left: 1px #BCBCBC solid;
}
a:link {font-family:Verdana, Arial, Helvetica, sans-serif;font-size: 12px;color: #444444;text-decoration: none;}
a:active {font-family:Verdana, Arial, Helvetica, sans-serif;font-size: 12px;color: #C54320;text-decoration: none;}
a:visited {font-family:Verdana, Arial, Helvetica, sans-serif;font-size: 12px;color: #444444;text-decoration: none;}
a:hover {font-family:Verdana, Arial, Helvetica, sans-serif;font-size: 12px;color: #C54320;text-decoration: none;}
</style>
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script type="text/javascript">
    with (window) onload = onresize = function()
        {
            var mainHeight = document.body.offsetHeight - 100;

            document.getElementById("content").style.height = "" + mainHeight + "px";
        }
    </script>
</head>

<body style="overflow:hidden;" topmargin=0>
<h:form id="form1" >
    <table width="798" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" align="center">
		 <tr>
			<td width=280><img src="../../../images/organ_index_03.gif" width="260" height="71"></td>
			<td><img src="../../../images/organ_index_04.jpg" width="518" height="71"></td>
		</tr>
        <tr>

        <td class="td_title" width="70%" colspan="2">
        	<%
                String filterSql = com.hr319wg.util.CommonFuns.filterNull(request.getParameter("tabFlag"));
                String filterSQL = com.hr319wg.util.CommonFuns.filterNull(request.getParameter("filterSQL"));
                String contentUrl = "/doc/DocInfoIndex.jsf";

                out.println("<table  border='0' cellpadding='0' cellspacing='0' width='100%'  valign='top' ><tr>");
                out.println("<td class='td_sec1'>");
                User bo = (User) session.getAttribute(com.hr319wg.common.Constants.USER_INFO);
                System.out.println(">>id:" + bo.getOrgId());
                UserAPI pmsapi = (UserAPI) SysContext.getBean("user_pmsAPI");
                if (pmsapi.checkIsHQUser(bo))
                    out.println("<a class='lead_white_link'  href=\"/pages/lead/organ/OrganMain.jsf\">");
                else
                    out.println("<a class='lead_white_link' href=\"/pages/lead/oneorgan/OrganMain.jsf\">");
                out.println("");
                out.println("</a></td>");
                if (filterSql != null && !"".equals(filterSql)) {

                    if ("1".equalsIgnoreCase(filterSql)) {
                        out.println("<td class='td_sec2'>");
                        contentUrl += "?filterSQL=(p.personCancel='00900')and(p.partyCancel='00900')";
                    } else {
                        out.println("<td class='td_sec1'>");
                    }
                    out.println("<a class='lead_white_link' href=\"/pages/lead/personview/OrgDocView.jsf?filterSQL=(p.personCancel='00900')and(p.partyCancel='00900')&tabFlag=1\">");

                    out.println("全部人员</a></td>");

                    if ("2".equalsIgnoreCase(filterSql)) {
                        out.println("<td class='td_sec2'>");
                        contentUrl += "?filterSQL=(p.personCancel='00900')and(p.partyCancel='00900')and(p.personType='013511')";
                    } else {
                        out.println("<td class='td_sec1'>");
                    }
                    out.println("<a class='lead_white_link' href=\"/pages/lead/personview/OrgDocView.jsf?filterSQL=(p.personCancel='00900')and(p.partyCancel='00900')and(p.personType='013511')&tabFlag=2\">");
                    out.println("中长期劳动合同员工</a></td>");


                    if ("3".equalsIgnoreCase(filterSql)) {
                        out.println("<td class='td_sec2'>");
                        contentUrl += "?filterSQL=(p.personCancel='00900')and(p.partyCancel='00900')and(p.personType='013512')";
                    } else {
                        out.println("<td class='td_sec1'>");
                    }
                    out.println("<a class='lead_white_link'  href=\"/pages/lead/personview/OrgDocView.jsf?filterSQL=(p.personCancel='00900')and(p.partyCancel='00900')and(p.personType='013512')&tabFlag=3\">");
                    out.println("短期劳动合同员工");
                    out.println("</a></td>");

                    if ("4".equalsIgnoreCase(filterSql)) {
                        out.println("<td class='td_sec2'>");
                        contentUrl += "?filterSQL=(p.personCancel='00900')and(p.partyCancel='00900')and(p.personType='013513')";
                    } else {
                        out.println("<td class='td_sec1'>");
                    }
                    out.println("<a class='lead_white_link'  href=\"/pages/lead/personview/OrgDocView.jsf?filterSQL=(p.personCancel='00900')and(p.partyCancel='00900')and(p.personType='013513')&tabFlag=4\">");
                    out.println("劳务用工");
                    out.println("</a></td>");


                    if ("6".equalsIgnoreCase(filterSql)) {
                        out.println("<td class='td_sec2'>");
                        contentUrl = "/doc/DocLeaderInfoIndex.jsf?filterSQL=(p.personCancel='00900')and(p.partyCancel='00900')and(substr(p.postType,9,2)='01')";
                    } else {
                        out.println("<td class='td_sec1'>");
                    }
                    out.println("<a class='lead_white_link'  href=\"/pages/lead/personview/OrgDocView.jsf?filterSQL=(p.personCancel='00900')and(p.partyCancel='00900')and(substr(p.postType,9,2)='01')&tabFlag=6\">");

                    out.println("本部部门领导");
                    out.println("</a></td>");

                    if ("7".equalsIgnoreCase(filterSql)) {
                        out.println("<td class='td_sec2'>");
                        contentUrl = "/doc/DocSysLeaderInfoIndex.jsf?filterSQL=(p.personCancel='00900' and p.partyCancel='00900') and (p.sysCadreCode='018821')";
                    } else {
                        out.println("<td class='td_sec1'>");
                    }
                    out.println("<a class='lead_white_link'  href=\"/pages/lead/personview/OrgDocView.jsf?filterSQL=(p.personCancel='00900' and p.partyCancel='00900') and (p.sysCadreCode='018821')&tabFlag=7\">");

                    out.println("条线领导");
                    out.println("</a></td>");

                    if ("8".equalsIgnoreCase(filterSql)) {
                        out.println("<td class='td_sec2'>");
                        contentUrl = "/doc/DocSysInfoIndex.jsf?filterSQL=(p.personCancel='00900')and(p.partyCancel='00900')and((p.sysCadreCode='018811')or(p.sysCadreCode='018812'))";
                    } else {
                        out.println("<td class='td_sec1'>");
                    }
                    out.println("<a class='lead_white_link'  href=\"/pages/lead/personview/OrgDocView.jsf?filterSQL=(p.personCancel='00900')and(p.partyCancel='00900')and((p.sysCadreCode='018811')or(p.sysCadreCode='018812'))&tabFlag=8\">");

                    out.println("分行领导");
                    out.println("</a></td>");

                    if ("11".equalsIgnoreCase(filterSql)) {
                        out.println("<td class='td_sec2'>");
                        contentUrl = "/pages/doc/SaveInfoIndex.jsf";
                    } else {
                        out.println("<td class='td_sec1'>");
                    }
                    out.println("<a class='lead_white_link'  href=\"/pages/lead/personview/OrgDocView.jsf?tabFlag=11\">");
                    out.println("后备人才");
                    out.println("</a></td>");
                    if ("5".equalsIgnoreCase(filterSql)) {
                        out.println("<td class='td_sec2'>");
                        contentUrl += "?filterSQL=(p.personCancel='00900')and(p.partyCancel='00900')and(p.retireCancel='00901')";
                    } else {
                        out.println("<td class='td_sec1'>");
                    }
                    out.println("<a class='lead_white_link'  href=\"/pages/lead/personview/OrgDocView.jsf?filterSQL=(p.personCancel='00900')and(p.partyCancel='00900')and(p.retireCancel='00901')&tabFlag=5\">");
                    out.println("离退休人员");
                    out.println("</a></td>");
                    if ("9".equalsIgnoreCase(filterSql)) {
                        out.println("<td class='td_sec2'>");
                        contentUrl += "?filterSQL=p.personCancel='00901'";
                    } else {
                        out.println("<td class='td_sec1'>");
                    }
                    out.println("<a class='lead_white_link'  href=\"/pages/lead/personview/OrgDocView.jsf?filterSQL=p.personCancel='00901'&tabFlag=9\">");

                    out.println("减员人员");
                    out.println("</a></td>");


                }
                out.println("</tr>");
                out.println("</table>");

            %>
        </td>
        </tr>
    </table>
    
    <table width="798" border="0" cellpadding="0" cellspacing="0" align="center">
        <tr>
            <td valign="top">
                        <iframe name="content" frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                 src="<%=contentUrl%>"></iframe>
	        </td>
        </tr>
    </table>
</h:form>
</body>
</html>
