<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="javax.faces.model.SelectItem" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.user.ucc.IUserReportUCC" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{Rpt_InfoIndexBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{Rpt_InfoIndexBB.initShow}"/>
    <h:inputHidden id="UnitID" value="#{Rpt_InfoIndexBB.unitId}"/>
    <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
            <td height=10 colspan=2></td>
        </tr>

        <tr>
            <td align="left">
                <h:outputText value="当前统计单位:"/>
                <h:outputText value="#{Rpt_InfoIndexBB.unitName}"/>
                <h:outputText rendered="#{Rpt_InfoIndexBB.initShow!='true'}" value="   统计时间:"/>
                <h:outputText rendered="#{Rpt_InfoIndexBB.initShow!='true'}" value="#{Rpt_InfoIndexBB.staticdate}"/>
            </td>
            <td align="right">
                <h:commandButton  styleClass="button01" value="返回" rendered="#{Rpt_InfoIndexBB.initShow!='true'}" action="dateList" />
            </td>
        </tr>

        <tr>
            <td height=10 colspan=2></td>
        </tr>

        <tr>
        <td colspan=2>
            <table border="0" cellspacing="0" cellpadding="0" align="center" class="table03">
            <%
                String orgId= (String)request.getAttribute("orgId");
                String Time = (String)request.getAttribute("time");
                String setID = (String)request.getAttribute("setID");
                IUserReportUCC rc = (IUserReportUCC) SysContext.getBean("user_userReportUccImpl");
                List reportList = rc.queryUserHisRptToWebByTime(orgId, Time,setID);
                int j = 0;
                while (true) {
                    // 每行2列
                    SelectItem item = null;
                    if (j < reportList.size()) {
                        out.println("<tr>");
                        item = (SelectItem) (reportList.get(j));
                        out.println("<td width='48%' class='td_middle_left'><span onmouseover=\"this.style.cursor='hand'\"  style=\"text-decoration: underline;\"  onclick=\"window.open('/pages/report/ServerHisReportShow.jsp?Orguid=" + orgId + "&RptCode=" + item.getValue() + "') \">" + item.getLabel() + "</span></td>");
                        j++;
                    }

                    if (j < reportList.size()) {
                        item = (SelectItem) (reportList.get(j));
                        out.println("<td width='48%' class='td_middle_left'><span onmouseover=\"this.style.cursor='hand'\"  style=\"text-decoration: underline;\"  onclick=\"window.open('/pages/report/ServerHisReportShow.jsp?Orguid=" + orgId + "&RptCode=" + item.getValue() + "') \">" + item.getLabel() + "</span></td>");
                        out.println("</tr>");
                        j++;
                    } else {
                        out.println("<td class='td_middle_left'></td>");
                        out.println("</tr>");
                        break;
                    }
                }
            %>
            </table>
        </td>
    </tr>
    </table>
</h:form>
