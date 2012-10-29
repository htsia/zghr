<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.wage.util.DeptWageTools" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO"%>
<%@ page import="com.hr319wg.common.web.SysContext" %>

<%
    String userId = ((User) session.getAttribute(Constants.USER_INFO)).getUserId();
    String unitId = SysCacheTool.findPersonById(userId).getGongZiGX();
    String unitName = SysCacheTool.findWageUnit(unitId).getName();
    String setId = request.getParameter("setId");
    String payoff_id = request.getParameter("dateId");
    String status = request.getParameter("status");
    try{
        DeptWageTools dwt = (DeptWageTools) SysContext.getBean("wage_deptWageTools");
        String col = dwt.getDynCols(setId, payoff_id, status);
        String[] cols = col.split(",");
        Vector head = dwt.getDynHead(col);
        Vector body = dwt.getDeptWage( setId, payoff_id, status);
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gbk">
    <title>部门汇总单</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script language="javascript">
        function exportToExcel() {
            try {
                var range = document.body.createTextRange();
                range.moveToElementText(dtable);
                range.execCommand('Copy');
                excel = new ActiveXObject('Excel.Application');
                excel.Application.Visible = true;
                book = excel.Workbooks.Add;
                sheet = book.Worksheets.Add;
                sheet.Paste;
            } catch(e) {
                alert("您可能没有安装Excel软件，或者没有将本站点设为信任站点："+e.message);
                return false;
            }
        }
    </script>
</head>

<body>
<table width="90%" border="0" cellspacing="2" cellpadding="0" align="center" id="table3">
    <tr align=right>
        <td>
            <input name="b1" type="button" class="button01" value="导出到Excel" onclick="exportToExcel()">
        </td>
    </tr>
</table>
<br>
<table width="100%" id="dtable" border="0" align="center">
    <tr><td>
<table width="90%" border="0" align="center">
    <tr>
        <td align="center" colspan="6"><font style="font-size:14;"><b>部&nbsp;门&nbsp;工&nbsp;资&nbsp;汇&nbsp;总&nbsp;单</b></font></td>
    </tr>
    <tr>
        <td align="left" colspan="3">发薪单位：<%=CommonFuns.filterNull(unitName)%></td>  <td align="left" colspan="3">发薪日期：<%=CommonFuns.filterNull(request.getParameter("date"))%></td>
    </tr>
</table>
<br>
<table width="90%"  class="table03" align="center">
    <tr align="center" class="td_top">
        <td nowrap class="td_top">序号</td>
        <%
            for (int i = 0; i < head.size(); i++)
                out.println("<td nowrap class=\"td_top\">" + head.elementAt(i) + "</td>");
        %>
    </tr>
    <%

        for (int i = 0; i < body.size(); i++) {
            Hashtable hash  = (Hashtable) body.get(i);
            out.println("<tr align=\"center\">");
             out.println("<td nowrap class=\"td_middle\" align=\"center\" >" + (i+1) + "</td>");
            String orgCode=(String) hash.get(cols[0]);
            OrgBO org=SysCacheTool.findOrgById(orgCode);

            if(org==null){
                out.println("<td nowrap class=\"td_middle\" align=\"center\" >" + orgCode + "</td>");
            }else{
                out.println("<td nowrap class=\"td_middle\" align=\"center\" >" + org.getName() + "</td>");
            }
            for (int k = 1; k < cols.length; k++) {
                out.println("<td nowrap align=\"right\" class=\"td_middle\">" + CommonFuns.filterNullToZero((String) hash.get(cols[k])) + "</td>");
            }
            out.println("</tr>");
        }
      }
      catch(Exception e){

      }
    %>
</table>
        <table width="90%" border="0" align="center">
    <tr>
        <td align="left">审批人：<%if ("TOMCAT".equals(CommonFuns.getAppType())){out.print(CommonFuns.getParaFromURL(request.getQueryString(),"approver"));}else{out.print(CommonFuns.filterNull(request.getParameter("approver")));}%></td>
        <td align="left"></td>
        <td align="left">复核人： <%if ("TOMCAT".equals(CommonFuns.getAppType())){out.print(CommonFuns.getParaFromURL(request.getQueryString(),"checker"));}else{out.print(CommonFuns.filterNull(request.getParameter("checker")));}%></td>
        <td align="left"></td>
         <td align="left">制表人：<%if ("TOMCAT".equals(CommonFuns.getAppType())){out.print(CommonFuns.getParaFromURL(request.getQueryString(),"creator"));}else{out.print(CommonFuns.filterNull(request.getParameter("creator")));}%></td>
        <td align="left"></td>
        <td align="left">制表日期：<%=CommonFuns.getSysDate("yyyy-MM-dd")%></td>
        <td align="left"></td>
    </tr>
</table>
</td></tr></table>
</body>
</html>
