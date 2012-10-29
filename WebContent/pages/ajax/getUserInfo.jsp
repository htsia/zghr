<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");
    String UserID = request.getParameter("UserID");
    String name="";
    if (UserID!=null && !"".equals(UserID)){
        PersonBO pb = SysCacheTool.findPersonById(UserID);
        if (pb!=null){
            name=pb.getName();
        }
    }
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    out.println("<PersonInfo>");
    out.println("<name>" + name + "</name>");
    out.println("</PersonInfo>");
    out.println("</tree>");
%>
