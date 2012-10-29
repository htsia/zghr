<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.hr319wg.sys.check.AbstractCheck"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");
    String pack = "com.hr319wg.sys.check.";
    String setId = request.getParameter("setId");
    Map map = request.getParameterMap();
    String messages = "no";
    if (setId != null && !"".equals(setId)) {
        String clazzPath = pack + setId + "Check";        
        try {
            Class clazz = Class.forName(clazzPath);
            if (clazz != null) {
                AbstractCheck check = (AbstractCheck) clazz.newInstance();
                messages = CommonFuns.filterNull(check.runCheck(map, setId));
            }
        } catch (Exception e) {

        }
    }
    if("".equals(messages.trim())){
         messages = "no";
    }
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");
    out.println("<message>");
    out.println("<info>" + messages + "</info>");
    out.println("</message>");
    out.println("</tree>");
%>
