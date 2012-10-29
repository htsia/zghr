<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@page import="com.hr319wg.rpt.pojo.bo.RptGroupBO"%>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.rpt.ucc.impl.RptInfoUCC" %>
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
    RptGroupBO rptGroupBO = null ;
    RptInfoUCC rptucc = null ;
    try {
        rptucc = (RptInfoUCC) SysContext.getBean("rpt_infoucc");
        list = rptucc.getRptGroupDefineList();
    }
    catch (Exception e) {
 
    }
    // 返回结果
    if (list != null && list.size() > 0) { 
        for (int i = 0; i < list.size(); i++) {
            icon = "folder";
            out.println("<Code>");
            rptGroupBO = (RptGroupBO)list.get(i);
                childnum = "0";
                out.println("<key>" + rptGroupBO.getGroupId()+ "</key>");
                out.println("<name>" + rptGroupBO.getGroupName()+ "</name>");
                out.println("<id>" + rptGroupBO.getGroupId()+ "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            out.println("</Code>");
        }
    }
    out.println("</tree>");
%>