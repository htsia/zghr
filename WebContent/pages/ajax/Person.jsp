<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String perID = request.getParameter("perID");
    PersonBO pb = SysCacheTool.findPersonById(perID);
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    out.println("<person>");
    out.println("<A001044>" +CommonFuns.filterNull(pb.getUnitTime())+"</A001044>");
     out.println("<A001781>" +CommonFuns.filterNull(pb.getSysTime())+"</A001781>");
    out.println("</person>");
    out.println("</tree>");
%>