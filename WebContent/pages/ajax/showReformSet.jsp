<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.api.TrainAPI" %>
<%@ page import="com.hr319wg.wage.pojo.bo.WageReformSetBO" %>
<%@ page import="com.hr319wg.wage.ucc.impl.WageReformMgrUcc" %>
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
    WageReformMgrUcc rc = null;
    try {
        rc = (WageReformMgrUcc) SysContext.getBean("wageReformMgrucc");
        list = rc.getAllWageReformSetBO();
    }
    catch (Exception e) {
		e.printStackTrace();
    }
    // 返回结果
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            icon = "folder";
            out.println("<Sets>");

            WageReformSetBO o = (WageReformSetBO) list.get(i);
            if (o != null) {
                childnum = "0";
                out.println("<key>" + o.getSetId()+ "</key>");
                out.println("<name>" + o.getSetName() + "</name>");
                out.println("<id>" + o.getSetId() + "</id>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</Sets>");
        }
    }
    out.println("</tree>");
%>