<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.hr319wg.user.ucc.IUserManageUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");
    String loginName = request.getParameter("loginName");
    String PassWord = request.getParameter("password");
    IUserManageUCC userucc = (IUserManageUCC)SysContext.getBean("user_userManageUccImpl");
    String result="";
    if (userucc.verifyLogon(loginName,PassWord)){
       result="true";
       session.setAttribute("loginName",loginName);
    }
    else{
       result="µÇÂ½Ê§°Ü£¬Çë¼ì²éÓÃ»§ÃûºÍÃÜÂë";
    }
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<CheckLogin>");
    out.println("<Result>"+result+"</Result>");
    out.println("</CheckLogin>");
%>
