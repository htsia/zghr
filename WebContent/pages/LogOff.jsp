<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>

<%
    String portallogin=(String)session.getAttribute(Constants.PORTAL_LOGIN);
    String cardlogin=(String)session.getAttribute(Constants.CARD_LOGIN);
    // Çå³ýËùÓÐsession
    session.invalidate();
    if ("true".equals(portallogin)){
        response.sendRedirect("/PortalLogin.jsf");
    }
    else if ("true".equals(cardlogin)){
        response.sendRedirect("/LoginByCardI.jsf");
    }
    else{
        response.sendRedirect("/index.jsp");
    }
%>