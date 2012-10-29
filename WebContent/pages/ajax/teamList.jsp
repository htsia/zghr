<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.api.TrainAPI" %>
<%@ page import="com.hr319wg.emp.pojo.bo.EmpTeamInfoBo" %>
<%@ page import="com.hr319wg.emp.ucc.impl.teamManagerImpl" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String superId = request.getParameter("superId");// 上级
    User user=(User)session.getAttribute(Constants.USER_INFO);
    String orgid=user.getOrgId();
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    String icon = "";
    String childnum = "";
    List list = null;
    TrainAPI api = null;
    teamManagerImpl rc = null;
    try {
        rc = (teamManagerImpl) SysContext.getBean("teamucc");
        list = rc.getAllEmpTeamInfoBo(orgid);
    }
    catch (Exception e) {

    }
    // 返回结果
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            icon = "folder";
            out.println("<Teams>");

            EmpTeamInfoBo o = (EmpTeamInfoBo) list.get(i);
            if (o != null) {
                childnum = "0";
                out.println("<key>" + o.getTeamId()+ "</key>");
                out.println("<name>" + o.getTeamName() + "</name>");
                out.println("<id>" + o.getTeamId() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</Teams>");
        }
    }
    out.println("</tree>");
%>